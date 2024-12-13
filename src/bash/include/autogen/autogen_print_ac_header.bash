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
# autogen_print_ac_header
#

autogen_print_ac_header() {

  if (($# != 0)); then
    sst_barf 'invalid argument count: %d' $#
  fi

  cat <<"EOF"
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

dnl#
dnl# This file was generated by autogen.
dnl#

EOF

}; readonly -f autogen_print_ac_header