#
# Copyright (C) 2019-2024 Stealth Software Technologies, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an "AS
# IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
# express or implied. See the License for the specific language
# governing permissions and limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0
#

sst_ajh_asciidoctor_document() {

  declare adoc
  declare ag_json
  declare child
  declare clean_rule
  declare distribute
  declare html
  declare html_recipe_sh
  declare imagesdir
  declare pdf
  declare prefix
  declare s
  declare slug
  # Bash >=4.2: declare -g sst_ajh_asciidoctor_document_first_call
  declare tar_file
  declare tar_file_slug
  declare tarname
  declare x
  declare y

  html_recipe_sh=build-aux/sst_ajh_asciidoctor_document_html_recipe.sh
  readonly html_recipe_sh

  for ag_json; do

    if [[ ! "${sst_ajh_asciidoctor_document_first_call-}" ]]; then
      sst_ajh_asciidoctor_document_first_call=1

      mkdir -p ${html_recipe_sh%/*}
      sst_ihd <<'EOF' >$html_recipe_sh
        #! /bin/sh -
        #
        # Copyright (C) 2019-2024 Stealth Software Technologies, Inc.
        #
        # Licensed under the Apache License, Version 2.0 (the "License");
        # you may not use this file except in compliance with the License.
        # You may obtain a copy of the License at
        #
        #     http://www.apache.org/licenses/LICENSE-2.0
        #
        # Unless required by applicable law or agreed to in writing,
        # software distributed under the License is distributed on an "AS
        # IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
        # express or implied. See the License for the specific language
        # governing permissions and limitations under the License.
        #
        # SPDX-License-Identifier: Apache-2.0
        #

        eval ASCIIDOCTOR_FLAGS='${ASCIIDOCTOR_FLAGS?}'
        eval MAKE='${MAKE:?}'
        eval SED='${SED:?}'
        eval TSUF=${TSUF:?}
        eval adoc=${adoc:?}
        eval dst=${dst:?}
        eval imagesdir=${imagesdir:?}
        eval pdf=${pdf:?}
        eval prefix=${prefix:?}
        eval slug=${slug:?}
        eval srcdir=${srcdir:?}

        readonly ASCIIDOCTOR_FLAGS
        readonly MAKE
        readonly SED
        readonly TSUF
        readonly adoc
        readonly dst
        readonly imagesdir
        readonly pdf
        readonly prefix
        readonly slug
        readonly srcdir

        tmp=${dst?}${TSUF?}999
        readonly tmp

        if test -f ${adoc?}; then
          cp ${adoc?} ${tmp?}.adoc || exit $?
        else
          cp ${srcdir?}/${adoc?} ${tmp?}.adoc || exit $?
        fi

        af=
        af="${af?} -a imagesdir=${imagesdir?}"
        af="${af?} ${ASCIIDOCTOR_FLAGS?}"
        readonly af

        eval " ${MAKE?}"' \
          ASCIIDOCTOR_FLAGS="${af?}" \
          ${tmp?}.html \
        ' || exit $?

        #---------------------------------------------------------------
        # KaTeX installation
        #---------------------------------------------------------------

        if test -d ${prefix?}katex; then

          mv -f ${tmp?}.html ${dst?}${TSUF?}1 || exit $?

          x='
            /<script.*[Mm]ath[Jj]ax.*\.js/ d
          '
          eval " ${SED?}"' \
            "${x?}" \
            <${dst?}${TSUF?}1 \
            >${dst?}${TSUF?}2 \
          ' || exit $?

          mv -f ${dst?}${TSUF?}2 ${tmp?}.html || exit $?

        fi

        #---------------------------------------------------------------
        # Fonts installation
        #---------------------------------------------------------------
        #
        # TODO: This used to have some code to download Google fonts
        #       locally, but it was removed because it was too brittle
        #       (??). The code here now seems silly because all it does
        #       is remove any <link>'d Google fonts (??). Maybe we
        #       should revisit the downloading idea, but with a soft
        #       failure approach, so that if downloading fails for
        #       whatever reason then the fonts are just skipped.
        #

        if test -d ${prefix?}fonts; then

          mv -f ${tmp?}.html ${dst?}${TSUF?}1 || exit $?

          x='
            /<link.*fonts\.googleapis\.com/ d
          '
          eval " ${SED?}"' \
            "${x?}" \
            <${dst?}${TSUF?}1 \
            >${dst?}${TSUF?}2 \
          ' || exit $?

          mv -f ${dst?}${TSUF?}2 ${tmp?}.html || exit $?

        fi

        #---------------------------------------------------------------

        eval " ${MAKE?}"' \
          ASCIIDOCTOR_FLAGS="${af?}" \
          ${tmp?}.pdf \
        ' || exit $?

        #---------------------------------------------------------------

        mv -f ${tmp?}.html ${dst?} || exit $?
        mv -f ${tmp?}.pdf ${pdf?} || exit $?

        #---------------------------------------------------------------
EOF
      sst_am_distribute $html_recipe_sh

    fi

    sst_expect_ag_json html "$ag_json"
    sst_expect_extension $ag_json .html.ag.json

    pdf=${html/%.html/.pdf}

    slug=$(sst_underscore_slug $html)

    adoc=${html%.html}.adoc
    sst_expect_any_file $adoc{,.ag.json,.ag,.ac,.am,.im.in,.in,.im}

    prefix=$(sst_get_prefix $ag_json)
    if [[ "$prefix" == "" ]]; then
      sst_barf 'document must have its own subdirectory: %s' $ag_json
    fi

    sst_jq_get_string "$ag_json" .tarname tarname
    if [[ ! "$tarname" ]]; then
      tarname=${html%/*}
      tarname=${tarname##*/}
    fi

    tar_file=$(sst_get_prefix ${prefix%/})$tarname.tar
    tar_file_slug=$(sst_underscore_slug $tar_file)

    sst_jq_get_string_or_null .clean_rule $ag_json clean_rule
    case $clean_rule in
      '' | mostlyclean | clean | distclean | maintainer-clean)
        :
      ;;
      *)
        sst_barf '%s: .clean_rule: invalid value' $ag_json
      ;;
    esac

    sst_jq_get_boolean_or_null .distribute $ag_json distribute
    if [[ "$distribute" == true ]]; then
      distribute=1
    else
      distribute=
    fi

    sst_jq_get_string_or_null .imagesdir $ag_json imagesdir
    if [[ "$imagesdir" == "" ]]; then
      imagesdir=images
    else
      sst_expect_source_path "$imagesdir"
    fi

    sst_am_var_add_unique_word ${slug}_children $prefix$imagesdir

    sst_am_append <<EOF

#-----------------------------------------------------------------------
# $html
#-----------------------------------------------------------------------

$prefix$imagesdir:
	\$(AM_V_at)\$(MKDIR_P) \$@

EOF

    if ((distribute)); then
      sst_am_distribute $html
      if [[ "$clean_rule" != "" ]]; then
        sst_warn '%s: ignoring clean_rule because distribute is true' $ag_json
      fi
      clean_rule=maintainer-clean
    elif [[ "$clean_rule" == "" ]]; then
      clean_rule=mostlyclean
    fi

    for x in $prefix**.im.in $prefix**; do
      x=${x%/}
      sst_expect_source_path "$x"
      if [[ ! -f $x ]]; then
        continue
      fi
      if [[ $x == $ag_json || $x == $html ]]; then
        continue
      fi
      sst_ag_process_leaf $html $x child
    done

    #
    # If we were to inline the list of children into a makefile recipe
    # using the makefile variables, we'd eventually run into execve()
    # limits once the list becomes large enough, as that tends to be
    # how make executes recipe lines. Writing the list out to files
    # and reading them in during the recipe prevents this problem,
    # instead leveraging the shell to handle the large list.
    #

    x=${sst_am_var_value[${slug}_children]-}
    printf '%s\n' "${x// /$'\n'}" >$html.children
    sst_am_distribute $html.children

    x=${sst_am_var_value[${slug}_children_nodist]-}
    printf '%s\n' "${x// /$'\n'}" >$html.children_nodist
    sst_am_distribute $html.children_nodist

    sst_am_append <<EOF

$html: \\
  $html_recipe_sh \\
  \$(${slug}_children) \\
  \$(${slug}_children_nodist) \\
\$(empty)
	\$(AM_V_at)rm -f -r \\
	  \$@\$(TSUF)* \\
	  $pdf\$(TSUF)* \\
	  $prefix$imagesdir/diag-* \\
	;
	\$(AM_V_at)( \\
	  x=ASCIIDOCTOR_FLAGS; set x \$(ASCIIDOCTOR_FLAGS); \$(GATBPS_EXPORT); \\
	  x=MAKE; set x \$(MAKE); \$(GATBPS_EXPORT); \\
	  x=SED; set x \$(SED); \$(GATBPS_EXPORT); \\
	  x=TSUF; set x \$(TSUF); \$(GATBPS_EXPORT); \\
	  x=adoc; set x $adoc; \$(GATBPS_EXPORT); \\
	  x=dst; set x \$@; \$(GATBPS_EXPORT); \\
	  x=imagesdir; set x $imagesdir; \$(GATBPS_EXPORT); \\
	  x=pdf; set x $pdf; \$(GATBPS_EXPORT); \\
	  x=prefix; set x $prefix; \$(GATBPS_EXPORT); \\
	  x=slug; set x $slug; \$(GATBPS_EXPORT); \\
	  x=srcdir; set x \$(srcdir); \$(GATBPS_EXPORT); \\
	  sh \$(srcdir)/$html_recipe_sh || exit \$\$?; \\
	)

$pdf: $html

$html/clean: FORCE
	-rm -f -r \\
	  \$(@D) \\
	  \$(@D)\$(TSUF)* \\
	  $pdf \\
	  $pdf\$(TSUF)* \\
	  $prefix$imagesdir/diag-* \\
	;

$clean_rule-local: $html/clean

$tar_file: $html
	\$(AM_V_at)rm -f -r \$@ \$@\$(TSUF)*
	\$(AM_V_at)\$(MKDIR_P) \$@\$(TSUF)1/$tarname
	\$(AM_V_at)cp $html \$@\$(TSUF)1/$tarname
	\$(AM_V_at)cp $pdf \$@\$(TSUF)1/$tarname
	\$(GATBPS_at)( \\
	\\
	  xs=; \\
	\\
	  for y in \\
	    $html.children \\
	    $html.children_nodist \\
	  ; do \\
	    ys=\`cat \$\$y\` || exit \$\$?; \\
	    for x in \$\$ys; do \\
	      case \$\$x in *.adoc) \\
	        : \\
	      ;; *) \\
	        case \$\$xs in *" \$\$x "*) \\
	          : \\
	        ;; *) \\
	          xs="\$\$xs \$\$x "; \\
	        esac; \\
	      esac; \\
	    done; \\
	  done; \\
	\\
	  for x in \\
	    css \\
	    gif \\
	    jpg \\
	    js \\
	    mjs \\
	    png \\
	    svg \\
	    woff \\
	    woff2 \\
	  ; do \\
	    xs="\$\$xs "\` \\
	      find -L ${prefix%/} -name "*.\$\$x" -type f \\
	    \`" " || exit \$\$?; \\
	  done; \\
	\\
	  for x in \$\$xs; do \\
	    y='$prefix\\(.*\\)'; \\
	    y=\`expr \$\$x : \$\$y\` || exit \$\$?; \\
	    case \$\$y in \\
	      */*) \\
	        d=\`dirname \$\$y\` || exit \$\$?; \\
	        if test -d \$@\$(TSUF)1/$tarname/\$\$d; then \\
	          :; \\
	        else \\
	          \$(AM_V_P) && echo \$(MKDIR_P) \\
	            \$@\$(TSUF)1/$tarname/\$\$d \\
	          ; \\
	          \$(MKDIR_P) \\
	            \$@\$(TSUF)1/$tarname/\$\$d \\
	          || exit \$\$?; \\
	        fi; \\
	      ;; \\
	    esac; \\
	    y=\$@\$(TSUF)1/$tarname/\$\$y; \\
	    if test -d \$\$x && test -r \$\$y; then \\
	      echo uh oh 1 >&2; \\
	      exit 1; \\
	    fi; \\
	    if test -f \$\$x && test -d \$\$y; then \\
	      echo uh oh 2 >&2; \\
	      exit 1; \\
	    fi; \\
	    if test -f \$\$y; then \\
	      :; \\
	    else \\
	      \$(AM_V_P) && echo cp -R -L \$\$x \$\$y; \\
	      cp -R -L \$\$x \$\$y || exit \$\$?; \\
	    fi; \\
	  done; \\
	)
	\$(AM_V_at)(cd \$@\$(TSUF)1 && \$(TAR) c $tarname) >\$@\$(TSUF)2
	\$(AM_V_at)mv -f \$@\$(TSUF)2 \$@

${tar_file_slug}_leaves = \$(${slug}_leaves)

$tar_file/clean: FORCE
$tar_file/clean: $html/clean
	-rm -f -r \$(@D) \$(@D)\$(TSUF)*

mostlyclean-local: $tar_file/clean

#-----------------------------------------------------------------------
EOF

    # Distribute any images generated by Asciidoctor Diagram.
    if ((distribute)); then
      autogen_am_var_append EXTRA_DIST $prefix$imagesdir
    fi

  done

}; readonly -f sst_ajh_asciidoctor_document
