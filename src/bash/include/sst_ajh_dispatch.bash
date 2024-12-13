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

sst_ajh_dispatch() {

  # Bash >=4.2: declare -g -A sst_ajh_dispatch_seen

  local    ag_json
  local    handler

  for ag_json; do
    if [[ ! "${sst_ajh_dispatch_seen["$ag_json"]-}" ]]; then
      sst_ajh_dispatch_seen["$ag_json"]=x
      sst_jq_get_string "$ag_json" handler
      eval "$handler \"\$ag_json\""
    fi
  done

}; readonly -f sst_ajh_dispatch
