//
// Copyright (C) 2019-2024 Stealth Software Technologies, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an "AS
// IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language
// governing permissions and limitations under the License.
//
// SPDX-License-Identifier: Apache-2.0
//

// Include first to test independence.
#include <kestrel/carma/global_config_t.hpp>
// Include twice to test idempotence.
#include <kestrel/carma/global_config_t.hpp>
//

#include <sst/catalog/SST_ASSERT.h>
#include <sst/catalog/checked.hpp>
#include <sst/catalog/checked_cast.hpp>

#include <kestrel/carma/node_count_t.hpp>

namespace kestrel {
namespace carma {

node_count_t global_config_t::min_servers() const {
  SST_ASSERT((!moved_from_));
  return sst::checked_cast<node_count_t>(
      sst::checked(shamir_threshold()) + 2);
}

} // namespace carma
} // namespace kestrel