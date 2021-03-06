/*
 * Copyright (c) 2006-2018, RT-Thread Development Team
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Change Logs:
 * Date           Author       Notes
 * 2018/10/01     Bernard      The first version
 */

#define MSTATUS_FS      0x00006000U /* initial state of FPU     */
#include <cpuport.h>

  .global	_start
  .section ".start", "ax"
_start:
  j 1f
  .word 0xdeadbeef
1:
  csrw mideleg, 0
  csrw medeleg, 0
  csrw mie, 0
  csrw mip, 0
  la t0, trap_entry
  csrw mtvec, t0

  li x1, 0
  li x2, 0
  li x3, 0
  li x4, 0
  li x5, 0
  li x6, 0
  li x7, 0
  li x8, 0
  li x9, 0
  li x10,0
  li x11,0
  li x12,0
  li x13,0
  li x14,0
  li x15,0
  li x16,0
  li x17,0
  li x18,0
  li x19,0
  li x20,0
  li x21,0
  li x22,0
  li x23,0
  li x24,0
  li x25,0
  li x26,0
  li x27,0
  li x28,0
  li x29,0
  li x30,0
  li x31,0

  /* set to initial state of FPU and disable interrupt */
  li t0, MSTATUS_FS
  csrs mstatus, t0

  fssr    x0
  fmv.d.x f0, x0
  fmv.d.x f1, x0
  fmv.d.x f2, x0
  fmv.d.x f3, x0
  fmv.d.x f4, x0
  fmv.d.x f5, x0
  fmv.d.x f6, x0
  fmv.d.x f7, x0
  fmv.d.x f8, x0
  fmv.d.x f9, x0
  fmv.d.x f10,x0
  fmv.d.x f11,x0
  fmv.d.x f12,x0
  fmv.d.x f13,x0
  fmv.d.x f14,x0
  fmv.d.x f15,x0
  fmv.d.x f16,x0
  fmv.d.x f17,x0
  fmv.d.x f18,x0
  fmv.d.x f19,x0
  fmv.d.x f20,x0
  fmv.d.x f21,x0
  fmv.d.x f22,x0
  fmv.d.x f23,x0
  fmv.d.x f24,x0
  fmv.d.x f25,x0
  fmv.d.x f26,x0
  fmv.d.x f27,x0
  fmv.d.x f28,x0
  fmv.d.x f29,x0
  fmv.d.x f30,x0
  fmv.d.x f31,x0

.option push
.option norelax
  la gp, __global_pointer$
.option pop

  /* get cpu id */
  csrr a0, mhartid

  la   sp, __stack_start__
  addi t1, a0, 1
  li   t2, __STACKSIZE__
  mul  t1, t1, t2
  add  sp, sp, t1 /* sp = (cpuid + 1) * __STACKSIZE__ + __stack_start__ */

  /* other cpu core, jump to cpu entry directly */
  bnez a0, _cpu_entry

#if 0
  /* clear bss section */
  la a0, __bss_start
  la a1, __bss_end
  bgeu a0, a1, 2f
1:
  sw zero, (a0)
  addi a0, a0, REGBYTES
  bltu a0, a1, 1b
2:
#endif

_cpu_entry:
  csrr a0, mhartid
  j cpu_entry
