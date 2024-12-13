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

sst_jq_get_string_or_null() {

  sst_expect_argument_count $# 2-3
  jq_expect_string_or_null "$1" "$2"
  if (($# == 2)); then
    jq -r " $1 | select(.)" <"$2"
  else
    sst_expect_basic_identifier "$3"
    eval $3='$(jq -r " $1 | select(.)" <"$2" | sst_csf)'
    sst_csf $3
  fi

}; readonly -f sst_jq_get_string_or_null
