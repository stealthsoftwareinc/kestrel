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

#ifndef KESTREL_LINK_DIRECTION_T_HPP
#define KESTREL_LINK_DIRECTION_T_HPP

#include <ChannelProperties.h>

#include <kestrel/KESTREL_SDK_ENUM_WRAPPER.hpp>

namespace kestrel {

#define KESTREL_LINK_DIRECTION_ITEMS(ITEM)                             \
  ITEM(bidi, LD_BIDI)                                                  \
  ITEM(creator_to_loader, LD_CREATOR_TO_LOADER)                        \
  ITEM(loader_to_creator, LD_LOADER_TO_CREATOR)                        \
  ITEM(undef, LD_UNDEF)

KESTREL_SDK_ENUM_WRAPPER(link_direction_t,
                         KESTREL_LINK_DIRECTION_ITEMS,
                         LinkDirection,
                         LD_UNDEF)

} // namespace kestrel

#endif // #ifndef KESTREL_LINK_DIRECTION_T_HPP
