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
#include <kestrel/rabbitmq/link_addrinfo_t.hpp>
// Include twice to test idempotence.
#include <kestrel/rabbitmq/link_addrinfo_t.hpp>
//

#include <kestrel/catalog/KESTREL_WITH_KESTREL_RABBITMQ.h>

#if KESTREL_WITH_KESTREL_RABBITMQ

namespace kestrel {
namespace rabbitmq {

namespace guts {
namespace link_addrinfo_t {

char const default_host[] = "rabbitmq.kestrel.stealthsoftwareinc.com";

} // namespace link_addrinfo_t
} // namespace guts

} // namespace rabbitmq
} // namespace kestrel

#endif // #if KESTREL_WITH_KESTREL_RABBITMQ
