dnl
dnl This file was generated by GATBPS 0.2.0-alpha.172+g96a0cb7, which was
dnl released on 2024-12-12. Before changing it, make sure
dnl you're doing the right thing. Depending on how GATBPS
dnl is being used, your changes may be automatically lost.
dnl A short description of this file follows.
dnl
dnl Special file: GATBPS_CHECK_CFLAG.m4
dnl
dnl For more information, see the GATBPS manual.
dnl
#serial 20241212
AC_DEFUN([GATBPS_CHECK_CFLAG], [[{

]GATBPS_CHECK(
  [$1],
  [$2],
  [[
    gatbps_save_CFLAGS="$][{CFLAGS}"
    CFLAGS="$][{CFLAGS} "'$3'
    ]AC_LANG_PUSH([C])[
    ]AC_COMPILE_IFELSE(
      [GATBPS_LANG_PROGRAM([], [])],
      [gatbps_cv_$2='yes'],
      [gatbps_cv_$2='no'])[
    ]AC_LANG_POP([C])[
    CFLAGS="$][{gatbps_save_CFLAGS}"
  ]],
  [$4])[

:;}]])[]dnl
dnl
dnl The authors of this file have waived all copyright and
dnl related or neighboring rights to the extent permitted by
dnl law as described by the CC0 1.0 Universal Public Domain
dnl Dedication. You should have received a copy of the full
dnl dedication along with this file, typically as a file
dnl named <CC0-1.0.txt>. If not, it may be available at
dnl <https://creativecommons.org/publicdomain/zero/1.0/>.
dnl
