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
