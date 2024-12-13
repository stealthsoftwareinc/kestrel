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

case $0 in /*)
  d=$0
;; *)
  d=./$0
esac
r='\(.*/\)'
d=`expr "$d" : "$r"`. || exit $?
. "${d?}"/external_services_prelude.sh

docker-compose \
  -f - <<EOF \
  -p "${project_name?}" \
  up \
  -d \
|| exit $?
${compose_yaml?}
EOF