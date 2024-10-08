/* pocl_runtime_config.h: functions to query pocl runtime configuration
   settings

   Copyright (c) 2013 Pekka Jääskeläinen

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to
   deal in the Software without restriction, including without limitation the
   rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
   sell copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
   IN THE SOFTWARE.
*/

#ifndef _POCL_RUNTIME_CONFIG_H
#define _POCL_RUNTIME_CONFIG_H

#include "pocl_export.h"

#ifdef __cplusplus
extern "C" {
#endif

POCL_EXPORT
int pocl_is_option_set(const char *key);
POCL_EXPORT
int pocl_get_int_option(const char *key, int default_value);
POCL_EXPORT
int pocl_get_bool_option(const char *key, int default_value);
POCL_EXPORT
const char* pocl_get_string_option(const char *key, const char *default_value);

POCL_EXPORT
const char *pocl_get_path (const char *name, const char *default_value);

#ifdef __cplusplus
}
#endif


#endif
