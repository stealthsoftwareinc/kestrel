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

sst_am_var_add_unique_file() {

  local path
  # Bash >=4.2: declare -g -A sst_am_var_value
  # Bash >=4.2: declare -g -A sst_am_var_value_files
  local var

  sst_expect_argument_count $# 1-

  var=$1
  readonly var
  sst_expect_basic_identifier "$var"

  if [[ "${sst_am_var_value[$var]-}" == "" ]]; then
    sst_am_var_set $var
  fi

  shift
  for path; do
    sst_expect_source_path "$path"
    sst_expect_file $path
    if [[ "${sst_am_var_value_files[$var]= }" == *" $path "* ]]; then
      continue
    fi
    sst_am_var_value_files[$var]+="$path "
    sst_am_var_value[$var]+="$path "
    sst_am_append <<<"$var += $path"
  done

}; readonly -f sst_am_var_add_unique_file