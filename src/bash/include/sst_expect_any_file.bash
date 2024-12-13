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

sst_expect_any_file() {

  local path
  local paths

  for path; do
    if [[ -f "$path" ]]; then
      return
    fi
  done

  paths=
  for path; do
    paths+=${paths:+ }$(sst_smart_quote "$path")
  done
  sst_barf "expected at least one path to exist as a file: $paths"

}; readonly -f sst_expect_any_file