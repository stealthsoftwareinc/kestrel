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

sst_ajh_copy() {

  local    ag_json
  local    dst
  local    src

  for ag_json; do

    sst_expect_ag_json dst "$ag_json"

    sst_jq_get_string "$ag_json" src
    eval src="$src"

    sst_ac_append <<<"GATBPS_CP([$dst], [$src])"

  done

}; readonly -f sst_ajh_copy
