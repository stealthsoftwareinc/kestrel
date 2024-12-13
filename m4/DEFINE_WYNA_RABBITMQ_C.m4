dnl#
dnl# Copyright (C) 2019-2024 Stealth Software Technologies, Inc.
dnl#
dnl# Licensed under the Apache License, Version 2.0 (the "License");
dnl# you may not use this file except in compliance with the License.
dnl# You may obtain a copy of the License at
dnl#
dnl#     http://www.apache.org/licenses/LICENSE-2.0
dnl#
dnl# Unless required by applicable law or agreed to in writing,
dnl# software distributed under the License is distributed on an "AS
dnl# IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
dnl# express or implied. See the License for the specific language
dnl# governing permissions and limitations under the License.
dnl#
dnl# SPDX-License-Identifier: Apache-2.0
dnl#

AC_DEFUN_ONCE([DEFINE_WYNA_RABBITMQ_C], [
GATBPS_CALL_COMMENT([$0]m4_if(m4_eval([$# > 0]), [1], [, $@]))
{ :

  GATBPS_BEFORE([$0], [DEFINE_WYNAS])

  GATBPS_ARG_WYNA(
    [--with-rabbitmq-c],
    [
      Use the RabbitMQ-C library.
    ],
    [
      Do not use the RabbitMQ-C library.
    ],
    [
      Automatically decide whether to use the RabbitMQ-C library.
    ],
    [
    ])

}])