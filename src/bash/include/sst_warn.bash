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
# This function may be called by sst_install_utility, so we need to be
# careful to only use utilities that are always available and run them
# with "command", and we need to explicitly call sst_err_trap on error
# to handle errexit suspension correctly. errexit suspension will occur
# when the user uses idioms such as "foo || s=$?" or "if foo; then" and
# foo triggers our automatic utility installation system. In this case,
# we want to maintain the behavior expected by the user but still barf
# if the installation of foo fails.
#

sst_warn() {

  # Bash >=4.2: declare -g    CLICOLOR_FORCE
  # Bash >=4.2: declare -g    NO_COLOR

  local    color_start
  local    color_stop
  local    message

  #
  # See [1], [2], and [3] for the basics of color control environment
  # variables. Note that the approach in FreeBSD [3] defaults to color
  # disabled and always requires CLICOLOR to be set to enable color, but
  # the approach in [1] defaults to color enabled in a terminal and does
  # not use CLICOLOR. We use the approach in [1] since we generally want
  # color enabled by default in a terminal.
  #
  # [1] https://bixense.com/clicolors/
  # [2] https://no-color.org/
  # [3] https://stackoverflow.com/q/75625246
  #

  if [[ ! "${NO_COLOR+x}" && ( "${CLICOLOR_FORCE+x}" || -t 2 ) ]]; then
    color_start=$'\x1B[33m'
    color_stop=$'\x1B[0m'
  else
    color_start=
    color_stop=
  fi
  readonly color_start
  readonly color_stop

  message="$color_start$0: Warning: $@$color_stop"
  readonly message

  printf '%s\n' "$message" >&2 || :

}; readonly -f sst_warn
