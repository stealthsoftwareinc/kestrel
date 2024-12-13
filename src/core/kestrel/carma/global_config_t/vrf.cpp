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
#include <sst/catalog/json/remove_to.hpp>

#include <kestrel/json_t.hpp>
#include <kestrel/vrf_shell_t.hpp>

namespace kestrel {
namespace carma {

void global_config_t::parse_vrf(json_t & src) {
  SST_ASSERT((!moved_from_));
  if (!have_vrf_) {
    sst::json::remove_to(src, vrf_, "vrf");
    have_vrf_ = true;
  }
}

vrf_shell_t const & global_config_t::vrf() const {
  SST_ASSERT((!moved_from_));
  SST_ASSERT((have_vrf_));
  return vrf_;
}

global_config_t & global_config_t::vrf(vrf_shell_t src) {
  SST_ASSERT((!moved_from_));
  vrf_ = std::move(src);
  have_vrf_ = true;
  return *this;
}

} // namespace carma
} // namespace kestrel