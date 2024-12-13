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

#ifndef KESTREL_EASY_TA2_PLUGIN_T_ONUSERACKNOWLEDGEMENTRECEIVED_HPP
#define KESTREL_EASY_TA2_PLUGIN_T_ONUSERACKNOWLEDGEMENTRECEIVED_HPP

#include <utility>

#include <sst/catalog/SST_TEV_ADD.hpp>
#include <sst/catalog/SST_TEV_ARG.hpp>
#include <sst/catalog/SST_TEV_DEF.hpp>

#include <PluginResponse.h>
#include <SdkResponse.h>

#include <kestrel/easy_ta2_plugin_t.hpp>
#include <kestrel/race_handle_t.hpp>
#include <kestrel/tracing_event_t.hpp>

namespace kestrel {

template<class Plugin, class Types>
PluginResponse
easy_ta2_plugin_t<Plugin, Types>::onUserAcknowledgementReceived(
    RaceHandle handle) {
  tracing_event_t SST_TEV_DEF(tev);
  SST_TEV_ADD(tev,
              "plugin_function_input",
              this->i_onUserAcknowledgementReceived(handle));
  return this->template inner_call<func_onUserAcknowledgementReceived,
                                   PLUGIN_ERROR>(
      tev,
      [&](tracing_event_t & tev) {
        this->expect_active();
        this->inner_onUserAcknowledgementReceived(
            SST_TEV_ARG(tev),
            race_handle_t(std::move(handle)));
        SST_TEV_ADD(tev,
                    "plugin_function_output",
                    this->o_onUserAcknowledgementReceived(handle));
      });
}

} // namespace kestrel

#endif // #ifndef KESTREL_EASY_TA2_PLUGIN_T_ONUSERACKNOWLEDGEMENTRECEIVED_HPP