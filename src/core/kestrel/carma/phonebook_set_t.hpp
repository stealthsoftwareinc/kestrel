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

#ifndef KESTREL_CARMA_PHONEBOOK_SET_T_HPP
#define KESTREL_CARMA_PHONEBOOK_SET_T_HPP

#include <unordered_set>

#include <sst/catalog/atomic.hpp>
#include <sst/catalog/unique_ptr.hpp>

#include <kestrel/carma/phonebook_pair_eq_t.hpp>
#include <kestrel/carma/phonebook_pair_hash_t.hpp>
#include <kestrel/carma/phonebook_pair_t.hpp>
#include <kestrel/json_t.hpp>

namespace kestrel {
namespace carma {

//----------------------------------------------------------------------

class phonebook_t;

//----------------------------------------------------------------------

using phonebook_set_t = std::unordered_set<phonebook_pair_t const *,
                                           phonebook_pair_hash_t,
                                           phonebook_pair_eq_t>;

//----------------------------------------------------------------------

void parse_phonebook_set(phonebook_t const & phonebook,
                         json_t & src,
                         char const * key,
                         sst::unique_ptr<phonebook_set_t> & dst,
                         bool required = false);

void parse_phonebook_set(
    phonebook_t const & phonebook,
    json_t & src,
    char const * key,
    sst::atomic<sst::unique_ptr<phonebook_set_t>> & dst,
    bool required = false);

//----------------------------------------------------------------------

void unparse_phonebook_set(json_t & dst,
                           char const * const key,
                           phonebook_set_t const & src);

void unparse_phonebook_set(json_t & dst,
                           char const * const key,
                           phonebook_set_t const * src);

void unparse_phonebook_set(
    json_t & dst,
    char const * const key,
    sst::unique_ptr<phonebook_set_t> const & src);

void unparse_phonebook_set(
    json_t & dst,
    char const * const key,
    sst::atomic<sst::unique_ptr<phonebook_set_t>> const & src);

//----------------------------------------------------------------------

} // namespace carma
} // namespace kestrel

#endif // #ifndef KESTREL_CARMA_PHONEBOOK_SET_T_HPP