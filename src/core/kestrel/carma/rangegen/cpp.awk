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

BEGIN {

  gsub(/\\n/, "\n", copyright_notice);

  print copyright_notice;
  print "";
  print "#include <cstdint>";
  print "#include <utility>";
  print "";
  print "#include <kestrel/carma/rangegen/row.hpp>";
  print "";
  print "namespace kestrel {";
  print "namespace carma {";
  print "namespace rangegen {";
  print "";
  print "std::pair<row const *, std::size_t> " array_name "() {";
  print "  static row const v[] = {";

  num_servers = -1;

  FS = ",";

}

{
  if (NR > 1) {
    for (i = num_servers + 1; i < $1; ++i) {
      printf "    {";
      for (j = 0; j++ < NF;) {
        if (j > 1) {
          printf ", ";
        }
        printf "-1";
      }
      print "},";
    }
    printf "    {";
    for (i = 0; i++ < NF;) {
      if (i > 1) {
        printf ", ";
      }
      printf "%s", $i;
    }
    print "},";
    num_servers = $1;
  }
}

END {
  print "  };";
  print "  return {v, sizeof(v) / sizeof(*v)};";
  print "}";
  print "";
  print "} // namespace rangegen";
  print "} // namespace carma";
  print "} // namespace kestrel";
}
