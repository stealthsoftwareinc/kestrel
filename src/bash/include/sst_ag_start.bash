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
#       sst_ag_start
#
#       sst_ag_start <dir>
#
#       sst_ag_start <ac_file> <am_file>
#

sst_ag_start() {

  # Bash >=4.2: declare -g    SST_DEBUG
  # Bash >=4.2: declare -g    sst_ac_start_has_been_called
  # Bash >=4.2: declare -g    sst_ag_start_has_been_called
  # Bash >=4.2: declare -g    sst_am_start_has_been_called

  declare    ac_file
  declare    am_file

  if ((SST_DEBUG)); then

    if [[ "${sst_ag_start_has_been_called-}" ]]; then
      sst_barf "You called sst_ag_start twice"
    fi
    sst_ag_start_has_been_called=1
    readonly sst_ag_start_has_been_called

    if [[ "${sst_ac_start_has_been_called-}" ]]; then
      sst_barf "You called sst_ag_start after sst_ac_start"
    fi

    if [[ "${sst_am_start_has_been_called-}" ]]; then
      sst_barf "You called sst_ag_start after sst_am_start"
    fi

  fi

  if (($# == 0)); then
    ac_file=autogen.ac
    am_file=autogen.am
  elif (($# == 1)); then
    if ((SST_DEBUG)); then
      if [[ "$1" == "" ]]; then
        sst_barf "<dir> must not be the empty string"
      fi
    fi
    if [[ "$1" == */ ]]; then
      ac_file=${1}autogen.ac
      am_file=${1}autogen.am
    else
      ac_file=$1/autogen.ac
      am_file=$1/autogen.am
    fi
  elif (($# == 2)); then
    ac_file=$1
    am_file=$2
    if ((SST_DEBUG)); then
      if [[ "$ac_file" == "" ]]; then
        sst_barf "<ac_file> must not be the empty string"
      fi
      if [[ "$ac_file" == */ ]]; then
        sst_barf "<ac_file> must not end with a slash"
      fi
      if [[ "$am_file" == "" ]]; then
        sst_barf "<am_file> must not be the empty string"
      fi
      if [[ "$am_file" == */ ]]; then
        sst_barf "<am_file> must not end with a slash"
      fi
    fi
  elif ((SST_DEBUG)); then
    sst_expect_argument_count $# 0-2
  fi

  if ((SST_DEBUG)); then
    sst_trap_append '
      if ((sst_trap_entry_status == 0)); then
        if [[ ! "${sst_ag_finish_has_been_called-}" ]]; then
          sst_barf "You forgot to call sst_ag_finish"
        fi
      fi
    ' EXIT
  fi

  sst_ac_start "$ac_file"
  sst_am_start "$am_file"

}; readonly -f sst_ag_start
