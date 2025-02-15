/* vecbuiltin - simple invocation of a builtins on global buffer of values

   Copyright (c) 2025 Michal Babej / Intel Finland Oy

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

#include "poclu.h"
#include <CL/opencl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int
exec_vecbuiltin_kernel (cl_context context,
                        cl_device_id device,
                        cl_command_queue cmd_queue,
                        cl_program program,
                        int n,
                        int wg_size,
                        cl_float *srcA,
                        cl_float *srcB,
                        cl_float *dst)
{
  cl_kernel kernel = NULL;
  cl_mem memobjs[3] = { 0, 0, 0 };
  size_t global_work_size[1];
  size_t local_work_size[1];
  cl_int err = CL_SUCCESS;
  int i;

  poclu_bswap_cl_float_array (device, (cl_float *)srcA, 4 * n);
  poclu_bswap_cl_float_array (device, (cl_float *)srcB, 4 * n);

  memobjs[0]
    = clCreateBuffer (context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                      sizeof (cl_float) * n, srcA, &err);
  CHECK_CL_ERROR2 (err);

  memobjs[1]
    = clCreateBuffer (context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR,
                      sizeof (cl_float) * n, srcB, &err);
  CHECK_CL_ERROR2 (err);

  memobjs[2] = clCreateBuffer (context, CL_MEM_READ_WRITE,
                               sizeof (cl_float) * n, NULL, &err);
  CHECK_CL_ERROR2 (err);

  kernel = clCreateKernel (program, "vecbuiltin", NULL);
  CHECK_CL_ERROR2 (err);

  err = clSetKernelArg (kernel, 0, sizeof (cl_mem), (void *)&memobjs[0]);
  CHECK_CL_ERROR2 (err);

  err = clSetKernelArg (kernel, 1, sizeof (cl_mem), (void *)&memobjs[1]);
  CHECK_CL_ERROR2 (err);

  err = clSetKernelArg (kernel, 2, sizeof (cl_mem), (void *)&memobjs[2]);
  CHECK_CL_ERROR2 (err);

  global_work_size[0] = n;
  local_work_size[0] = wg_size;

  err = clEnqueueNDRangeKernel (cmd_queue, kernel, 1, NULL, global_work_size,
                                local_work_size, 0, NULL, NULL);
  CHECK_CL_ERROR2 (err);

  err = clEnqueueReadBuffer (cmd_queue, memobjs[2], CL_TRUE, 0,
                             n * sizeof (cl_float), dst, 0, NULL, NULL);
  CHECK_CL_ERROR2 (err);

  poclu_bswap_cl_float_array (device, (cl_float *)dst, n);
  poclu_bswap_cl_float_array (device, (cl_float *)srcA, 4 * n);
  poclu_bswap_cl_float_array (device, (cl_float *)srcB, 4 * n);

ERROR:
  clReleaseMemObject (memobjs[0]);
  clReleaseMemObject (memobjs[1]);
  clReleaseMemObject (memobjs[2]);
  clReleaseKernel (kernel);
  return err;
}
