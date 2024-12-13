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

#
# Synopsis:
#
#       sst_ag_finish
#

sst_ag_finish() {

  # Bash >=4.2: declare -g    SST_DEBUG
  # Bash >=4.2: declare -g    sst_ac_finish_has_been_called
  # Bash >=4.2: declare -g    sst_ag_finish_has_been_called
  # Bash >=4.2: declare -g    sst_ag_start_has_been_called
  # Bash >=4.2: declare -g    sst_am_finish_has_been_called

  if ((SST_DEBUG)); then

    if [[ "${sst_ag_finish_has_been_called-}" ]]; then
      sst_barf "You called sst_ag_finish twice"
    fi
    sst_ag_finish_has_been_called=1
    readonly sst_ag_finish_has_been_called

    if [[ ! "${sst_ag_start_has_been_called-}" ]]; then
      sst_barf "You called sst_ag_finish before sst_ag_start"
    fi

    if [[ "${sst_ac_finish_has_been_called-}" ]]; then
      sst_barf "You called sst_ag_finish after sst_ac_finish"
    fi

    if [[ "${sst_am_finish_has_been_called-}" ]]; then
      sst_barf "You called sst_ag_finish after sst_am_finish"
    fi

    if (($# != 0)); then
      sst_expect_argument_count $# 0
    fi

  fi

  sst_ac_finish

  sst_am_finish

}; readonly -f sst_ag_finish
