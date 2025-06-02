
core_main.elf:     file format elf32-littleriscv
core_main.elf
architecture: riscv:rv32, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x00000000

Program Header:
    LOAD off    0x00001000 vaddr 0x40000000 paddr 0x40000000 align 2**12
         filesz 0x0000216c memsz 0x0000216c flags r-x
    LOAD off    0x00004000 vaddr 0x00000000 paddr 0x4000216c align 2**12
         filesz 0x00000018 memsz 0x0000002c flags rw-

Sections:
Idx Name          Size      VMA       LMA       File off  Algn  Flags
  0 .text         0000216c  40000000  40000000  00001000  2**4  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data         00000018  00000000  4000216c  00004000  2**2  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000014  00000018  40002184  00004018  2**2  ALLOC
  3 .comment      00000039  00000000  00000000  00004018  2**0  CONTENTS, READONLY
SYMBOL TABLE:
40000000 l    d  .text	00000000 .text
00000000 l    d  .data	00000000 .data
00000018 l    d  .bss	00000000 .bss
00000000 l    d  .comment	00000000 .comment
00000000 l    df *ABS*	00000000 start.o
40000000 l       .text	00000000 reset_vec
40000010 l       .text	00000000 start
40000038 l       .text	00000000 end_init_data
4000002c l       .text	00000000 loop_init_data
4000004e l       .text	00000000 end_init_bss
40000044 l       .text	00000000 loop_init_bss
00000000 l    df *ABS*	00000000 core_main.c
40001b48 l     O .text	0000000a list_known_crc
40001b54 l     O .text	0000000a matrix_known_crc
40001b60 l     O .text	0000000a state_known_crc
00000000 l    df *ABS*	00000000 core_list_join.c
00000000 l    df *ABS*	00000000 core_matrix.c
00000000 l    df *ABS*	00000000 core_portme.c
0000001c l     O .bss	00000004 start_time_val
00000018 l     O .bss	00000004 stop_time_val
00000000 l    df *ABS*	00000000 core_state.c
40001ba0 l     O .text	00000010 intpat
40001bb0 l     O .text	00000010 floatpat
40001bc0 l     O .text	00000010 scipat
40001bd0 l     O .text	00000010 errpat
00000000 l    df *ABS*	00000000 core_util.c
00000000 l    df *ABS*	00000000 ee_printf.c
40000c98 l     F .text	000001b0 number
00000000 l    df *ABS*	00000000 timer.c
00000000 l    df *ABS*	00000000 debug.c
00000028 g     O .bss	00000004 seed1_volatile
40001386 g     F .text	00000012 get_mtimer
4000049e g     F .text	000000f8 core_list_init
40000c72 g     F .text	0000001c crcu32
40000c94 g     F .text	00000004 check_data_types
400008c0 g     F .text	0000001a stop_time
00000000 g     O .data	0000000c mem_name
40000286 g     F .text	00000012 core_list_reverse
4000146a g     F .text	0000000e write_uart0
40000c56 g     F .text	0000001c crcu16
4000216c g       .text	00000000 _sidata
400014aa g     F .text	0000001c print_str_uart0
4000216c g       .text	00000000 _etext
40000634 g     F .text	0000004c matrix_sum
40000910 g     F .text	00000006 portable_fini
4000148a g     F .text	0000000e write_uart1
400007c4 g     F .text	000000b0 matrix_test
400008da g     F .text	0000000c get_time
40000afc g     F .text	000000f6 core_bench_state
40000344 g     F .text	0000015a core_bench_list
40000680 g     F .text	00000036 matrix_mul_const
400013ca g     F .text	0000001c memcpy
400013f0 g     F .text	00000014 print_str
40000e52 g     F .text	00000534 ee_printf
00000014 g     O .data	00000004 seed3_volatile
40001498 g     F .text	00000012 read_uart1
00000010 g     O .data	00000004 seed4_volatile
40001404 g     F .text	0000003c print_dec
40000060 g     F .text	0000005a iterate
40000716 g     F .text	0000004e matrix_mul_matrix
0000002c g       .bss	00000000 __bss_end
400001b4 g     F .text	00000028 cmp_complex
400009dc g     F .text	00000120 core_state_transition
40000874 g     F .text	0000001e core_bench_matrix
40000298 g     F .text	000000ac core_list_mergesort
400008a6 g     F .text	0000001a start_time
00000020 g     O .bss	00000004 seed5_volatile
00000018 g       .data	00000000 __data_end
40000232 g     F .text	00000016 core_list_remove
40000c8e g     F .text	00000006 crc16
40001478 g     F .text	00000012 read_uart0
400001dc g     F .text	00000012 copy_info
40000248 g     F .text	00000010 core_list_undo_remove
00000018 g       .bss	00000000 __bss_start
400014e2 g     F .text	00000664 main
40000892 g     F .text	00000014 barebones_clock
40000bf2 g     F .text	0000003a get_seed_32
40001440 g     F .text	0000002a print_hex
400013e6 g     F .text	0000000a print_chr
40000c2c g     F .text	0000002a crcu8
40000764 g     F .text	00000060 matrix_mul_matrix_bitextract
400001ee g     F .text	00000044 core_list_insert_new
400008f0 g     F .text	00000020 portable_init
40000596 g     F .text	0000009e core_init_matrix
400014c6 g     F .text	0000001c print_str_uart1
40001398 g     F .text	00000032 set_mtimer
400006e0 g     F .text	00000036 matrix_mul_vect
0000002c g       .bss	00000000 _edata
0000002c g       .bss	00000000 _end
400006b6 g     F .text	0000002a matrix_add_const
40000916 g     F .text	000000c6 core_init_state
00000000 g       *ABS*	00000000 start
400008e6 g     F .text	0000000a time_in_secs
40000e48 g     F .text	0000000a uart_send_char
00000000 g       .data	00000000 __data_start
00000024 g     O .bss	00000004 seed2_volatile
40000258 g     F .text	0000002e core_list_find
400000ba g     F .text	00000036 cmp_idx
400000f0 g     F .text	000000c4 calc_func
0000000c g     O .data	00000004 default_num_contexts



Disassembly of section .text:

40000000 <reset_vec>:
40000000:	a801                	j	40000010 <start>
40000002:	0001                	nop
40000004:	00000013          	nop
40000008:	00000013          	nop
4000000c:	00000013          	nop

40000010 <start>:
40000010:	00008137          	lui	sp,0x8
40000014:	b8010113          	addi	sp,sp,-1152 # 7b80 <__bss_end+0x7b54>
40000018:	00002517          	auipc	a0,0x2
4000001c:	15450513          	addi	a0,a0,340 # 4000216c <_etext>
40000020:	00000593          	li	a1,0
40000024:	01800613          	li	a2,24
40000028:	00c5d863          	bge	a1,a2,40000038 <end_init_data>

4000002c <loop_init_data>:
4000002c:	4114                	lw	a3,0(a0)
4000002e:	c194                	sw	a3,0(a1)
40000030:	0511                	addi	a0,a0,4
40000032:	0591                	addi	a1,a1,4
40000034:	fec5cce3          	blt	a1,a2,4000002c <loop_init_data>

40000038 <end_init_data>:
40000038:	01800513          	li	a0,24
4000003c:	02c00593          	li	a1,44
40000040:	00b55763          	bge	a0,a1,4000004e <end_init_bss>

40000044 <loop_init_bss>:
40000044:	00052023          	sw	zero,0(a0)
40000048:	0511                	addi	a0,a0,4
4000004a:	feb54de3          	blt	a0,a1,40000044 <loop_init_bss>

4000004e <end_init_bss>:
4000004e:	494010ef          	jal	ra,400014e2 <main>
40000052:	9002                	ebreak
	...

40000060 <iterate>:
40000060:	1141                	addi	sp,sp,-16
40000062:	c04a                	sw	s2,0(sp)
40000064:	01c52903          	lw	s2,28(a0)
40000068:	c422                	sw	s0,8(sp)
4000006a:	c226                	sw	s1,4(sp)
4000006c:	c606                	sw	ra,12(sp)
4000006e:	842a                	mv	s0,a0
40000070:	02052c23          	sw	zero,56(a0)
40000074:	02052e23          	sw	zero,60(a0)
40000078:	4481                	li	s1,0
4000007a:	01249963          	bne	s1,s2,4000008c <iterate+0x2c>
4000007e:	40b2                	lw	ra,12(sp)
40000080:	4422                	lw	s0,8(sp)
40000082:	4492                	lw	s1,4(sp)
40000084:	4902                	lw	s2,0(sp)
40000086:	4501                	li	a0,0
40000088:	0141                	addi	sp,sp,16
4000008a:	8082                	ret
4000008c:	4585                	li	a1,1
4000008e:	8522                	mv	a0,s0
40000090:	2c55                	jal	40000344 <core_bench_list>
40000092:	03845583          	lhu	a1,56(s0)
40000096:	3c1000ef          	jal	ra,40000c56 <crcu16>
4000009a:	02a41c23          	sh	a0,56(s0)
4000009e:	55fd                	li	a1,-1
400000a0:	8522                	mv	a0,s0
400000a2:	244d                	jal	40000344 <core_bench_list>
400000a4:	03845583          	lhu	a1,56(s0)
400000a8:	3af000ef          	jal	ra,40000c56 <crcu16>
400000ac:	02a41c23          	sh	a0,56(s0)
400000b0:	e099                	bnez	s1,400000b6 <iterate+0x56>
400000b2:	02a41d23          	sh	a0,58(s0)
400000b6:	0485                	addi	s1,s1,1
400000b8:	b7c9                	j	4000007a <iterate+0x1a>

400000ba <cmp_idx>:
400000ba:	e60d                	bnez	a2,400000e4 <cmp_idx+0x2a>
400000bc:	00051783          	lh	a5,0(a0)
400000c0:	f007f713          	andi	a4,a5,-256
400000c4:	07c2                	slli	a5,a5,0x10
400000c6:	83c1                	srli	a5,a5,0x10
400000c8:	83a1                	srli	a5,a5,0x8
400000ca:	8fd9                	or	a5,a5,a4
400000cc:	00f51023          	sh	a5,0(a0)
400000d0:	00059783          	lh	a5,0(a1)
400000d4:	f007f713          	andi	a4,a5,-256
400000d8:	07c2                	slli	a5,a5,0x10
400000da:	83c1                	srli	a5,a5,0x10
400000dc:	83a1                	srli	a5,a5,0x8
400000de:	8fd9                	or	a5,a5,a4
400000e0:	00f59023          	sh	a5,0(a1)
400000e4:	00251503          	lh	a0,2(a0)
400000e8:	00259783          	lh	a5,2(a1)
400000ec:	8d1d                	sub	a0,a0,a5
400000ee:	8082                	ret

400000f0 <calc_func>:
400000f0:	1101                	addi	sp,sp,-32
400000f2:	ca26                	sw	s1,20(sp)
400000f4:	00051483          	lh	s1,0(a0)
400000f8:	ce06                	sw	ra,28(sp)
400000fa:	cc22                	sw	s0,24(sp)
400000fc:	4074d793          	srai	a5,s1,0x7
40000100:	c84a                	sw	s2,16(sp)
40000102:	c64e                	sw	s3,12(sp)
40000104:	8b85                	andi	a5,a5,1
40000106:	cb91                	beqz	a5,4000011a <calc_func+0x2a>
40000108:	07f4f513          	andi	a0,s1,127
4000010c:	40f2                	lw	ra,28(sp)
4000010e:	4462                	lw	s0,24(sp)
40000110:	44d2                	lw	s1,20(sp)
40000112:	4942                	lw	s2,16(sp)
40000114:	49b2                	lw	s3,12(sp)
40000116:	6105                	addi	sp,sp,32
40000118:	8082                	ret
4000011a:	842e                	mv	s0,a1
4000011c:	4034d593          	srai	a1,s1,0x3
40000120:	00f5f793          	andi	a5,a1,15
40000124:	00479593          	slli	a1,a5,0x4
40000128:	0074f713          	andi	a4,s1,7
4000012c:	8ddd                	or	a1,a1,a5
4000012e:	89aa                	mv	s3,a0
40000130:	03845783          	lhu	a5,56(s0)
40000134:	c31d                	beqz	a4,4000015a <calc_func+0x6a>
40000136:	4685                	li	a3,1
40000138:	8926                	mv	s2,s1
4000013a:	04d71a63          	bne	a4,a3,4000018e <calc_func+0x9e>
4000013e:	863e                	mv	a2,a5
40000140:	02840513          	addi	a0,s0,40
40000144:	2f05                	jal	40000874 <core_bench_matrix>
40000146:	03c45783          	lhu	a5,60(s0)
4000014a:	01051913          	slli	s2,a0,0x10
4000014e:	41095913          	srai	s2,s2,0x10
40000152:	ef95                	bnez	a5,4000018e <calc_func+0x9e>
40000154:	02a41e23          	sh	a0,60(s0)
40000158:	a81d                	j	4000018e <calc_func+0x9e>
4000015a:	02200693          	li	a3,34
4000015e:	872e                	mv	a4,a1
40000160:	00d5d463          	bge	a1,a3,40000168 <calc_func+0x78>
40000164:	02200713          	li	a4,34
40000168:	00241683          	lh	a3,2(s0)
4000016c:	00041603          	lh	a2,0(s0)
40000170:	484c                	lw	a1,20(s0)
40000172:	4c08                	lw	a0,24(s0)
40000174:	0ff77713          	andi	a4,a4,255
40000178:	185000ef          	jal	ra,40000afc <core_bench_state>
4000017c:	03e45783          	lhu	a5,62(s0)
40000180:	01051913          	slli	s2,a0,0x10
40000184:	41095913          	srai	s2,s2,0x10
40000188:	e399                	bnez	a5,4000018e <calc_func+0x9e>
4000018a:	02a41f23          	sh	a0,62(s0)
4000018e:	03845583          	lhu	a1,56(s0)
40000192:	01091513          	slli	a0,s2,0x10
40000196:	8141                	srli	a0,a0,0x10
40000198:	2bf000ef          	jal	ra,40000c56 <crcu16>
4000019c:	02a41c23          	sh	a0,56(s0)
400001a0:	f004f493          	andi	s1,s1,-256
400001a4:	07f97513          	andi	a0,s2,127
400001a8:	8cc9                	or	s1,s1,a0
400001aa:	0804e493          	ori	s1,s1,128
400001ae:	00999023          	sh	s1,0(s3)
400001b2:	bfa9                	j	4000010c <calc_func+0x1c>

400001b4 <cmp_complex>:
400001b4:	1101                	addi	sp,sp,-32
400001b6:	ca26                	sw	s1,20(sp)
400001b8:	84ae                	mv	s1,a1
400001ba:	85b2                	mv	a1,a2
400001bc:	ce06                	sw	ra,28(sp)
400001be:	cc22                	sw	s0,24(sp)
400001c0:	c632                	sw	a2,12(sp)
400001c2:	373d                	jal	400000f0 <calc_func>
400001c4:	4632                	lw	a2,12(sp)
400001c6:	842a                	mv	s0,a0
400001c8:	8526                	mv	a0,s1
400001ca:	85b2                	mv	a1,a2
400001cc:	3715                	jal	400000f0 <calc_func>
400001ce:	40a40533          	sub	a0,s0,a0
400001d2:	40f2                	lw	ra,28(sp)
400001d4:	4462                	lw	s0,24(sp)
400001d6:	44d2                	lw	s1,20(sp)
400001d8:	6105                	addi	sp,sp,32
400001da:	8082                	ret

400001dc <copy_info>:
400001dc:	00059783          	lh	a5,0(a1)
400001e0:	00f51023          	sh	a5,0(a0)
400001e4:	00259783          	lh	a5,2(a1)
400001e8:	00f51123          	sh	a5,2(a0)
400001ec:	8082                	ret

400001ee <core_list_insert_new>:
400001ee:	882a                	mv	a6,a0
400001f0:	4208                	lw	a0,0(a2)
400001f2:	00850893          	addi	a7,a0,8
400001f6:	02e8fc63          	bgeu	a7,a4,4000022e <core_list_insert_new+0x40>
400001fa:	4298                	lw	a4,0(a3)
400001fc:	00470313          	addi	t1,a4,4
40000200:	02f37763          	bgeu	t1,a5,4000022e <core_list_insert_new+0x40>
40000204:	01162023          	sw	a7,0(a2)
40000208:	00082783          	lw	a5,0(a6)
4000020c:	c11c                	sw	a5,0(a0)
4000020e:	00a82023          	sw	a0,0(a6)
40000212:	c158                	sw	a4,4(a0)
40000214:	429c                	lw	a5,0(a3)
40000216:	00059703          	lh	a4,0(a1)
4000021a:	0791                	addi	a5,a5,4
4000021c:	c29c                	sw	a5,0(a3)
4000021e:	415c                	lw	a5,4(a0)
40000220:	00e79023          	sh	a4,0(a5)
40000224:	00259703          	lh	a4,2(a1)
40000228:	00e79123          	sh	a4,2(a5)
4000022c:	8082                	ret
4000022e:	4501                	li	a0,0
40000230:	8082                	ret

40000232 <core_list_remove>:
40000232:	411c                	lw	a5,0(a0)
40000234:	4158                	lw	a4,4(a0)
40000236:	43d4                	lw	a3,4(a5)
40000238:	c154                	sw	a3,4(a0)
4000023a:	c3d8                	sw	a4,4(a5)
4000023c:	4398                	lw	a4,0(a5)
4000023e:	c118                	sw	a4,0(a0)
40000240:	0007a023          	sw	zero,0(a5)
40000244:	853e                	mv	a0,a5
40000246:	8082                	ret

40000248 <core_list_undo_remove>:
40000248:	41d4                	lw	a3,4(a1)
4000024a:	4158                	lw	a4,4(a0)
4000024c:	c154                	sw	a3,4(a0)
4000024e:	c1d8                	sw	a4,4(a1)
40000250:	4198                	lw	a4,0(a1)
40000252:	c118                	sw	a4,0(a0)
40000254:	c188                	sw	a0,0(a1)
40000256:	8082                	ret

40000258 <core_list_find>:
40000258:	00259783          	lh	a5,2(a1)
4000025c:	0007de63          	bgez	a5,40000278 <core_list_find+0x20>
40000260:	c115                	beqz	a0,40000284 <core_list_find+0x2c>
40000262:	415c                	lw	a5,4(a0)
40000264:	0007c703          	lbu	a4,0(a5)
40000268:	00059783          	lh	a5,0(a1)
4000026c:	00f71363          	bne	a4,a5,40000272 <core_list_find+0x1a>
40000270:	8082                	ret
40000272:	4108                	lw	a0,0(a0)
40000274:	b7f5                	j	40000260 <core_list_find+0x8>
40000276:	4108                	lw	a0,0(a0)
40000278:	c511                	beqz	a0,40000284 <core_list_find+0x2c>
4000027a:	4158                	lw	a4,4(a0)
4000027c:	00271703          	lh	a4,2(a4)
40000280:	fef71be3          	bne	a4,a5,40000276 <core_list_find+0x1e>
40000284:	8082                	ret

40000286 <core_list_reverse>:
40000286:	87aa                	mv	a5,a0
40000288:	4501                	li	a0,0
4000028a:	e391                	bnez	a5,4000028e <core_list_reverse+0x8>
4000028c:	8082                	ret
4000028e:	4398                	lw	a4,0(a5)
40000290:	c388                	sw	a0,0(a5)
40000292:	853e                	mv	a0,a5
40000294:	87ba                	mv	a5,a4
40000296:	bfd5                	j	4000028a <core_list_reverse+0x4>

40000298 <core_list_mergesort>:
40000298:	7179                	addi	sp,sp,-48
4000029a:	cc52                	sw	s4,24(sp)
4000029c:	ca56                	sw	s5,20(sp)
4000029e:	c462                	sw	s8,8(sp)
400002a0:	c266                	sw	s9,4(sp)
400002a2:	c06a                	sw	s10,0(sp)
400002a4:	d606                	sw	ra,44(sp)
400002a6:	d422                	sw	s0,40(sp)
400002a8:	d226                	sw	s1,36(sp)
400002aa:	d04a                	sw	s2,32(sp)
400002ac:	ce4e                	sw	s3,28(sp)
400002ae:	c85a                	sw	s6,16(sp)
400002b0:	c65e                	sw	s7,12(sp)
400002b2:	8c2e                	mv	s8,a1
400002b4:	8cb2                	mv	s9,a2
400002b6:	8a2a                	mv	s4,a0
400002b8:	4a85                	li	s5,1
400002ba:	4d05                	li	s10,1
400002bc:	84d2                	mv	s1,s4
400002be:	4b81                	li	s7,0
400002c0:	4b01                	li	s6,0
400002c2:	4a01                	li	s4,0
400002c4:	e499                	bnez	s1,400002d2 <core_list_mergesort+0x3a>
400002c6:	000b2023          	sw	zero,0(s6)
400002ca:	057d5e63          	bge	s10,s7,40000326 <core_list_mergesort+0x8e>
400002ce:	0a86                	slli	s5,s5,0x1
400002d0:	b7f5                	j	400002bc <core_list_mergesort+0x24>
400002d2:	0b85                	addi	s7,s7,1
400002d4:	8426                	mv	s0,s1
400002d6:	4901                	li	s2,0
400002d8:	4000                	lw	s0,0(s0)
400002da:	0905                	addi	s2,s2,1
400002dc:	e809                	bnez	s0,400002ee <core_list_mergesort+0x56>
400002de:	89d6                	mv	s3,s5
400002e0:	00091a63          	bnez	s2,400002f4 <core_list_mergesort+0x5c>
400002e4:	00098363          	beqz	s3,400002ea <core_list_mergesort+0x52>
400002e8:	e815                	bnez	s0,4000031c <core_list_mergesort+0x84>
400002ea:	84a2                	mv	s1,s0
400002ec:	bfe1                	j	400002c4 <core_list_mergesort+0x2c>
400002ee:	ff2a95e3          	bne	s5,s2,400002d8 <core_list_mergesort+0x40>
400002f2:	b7f5                	j	400002de <core_list_mergesort+0x46>
400002f4:	00098363          	beqz	s3,400002fa <core_list_mergesort+0x62>
400002f8:	ec01                	bnez	s0,40000310 <core_list_mergesort+0x78>
400002fa:	87a2                	mv	a5,s0
400002fc:	8426                	mv	s0,s1
400002fe:	4084                	lw	s1,0(s1)
40000300:	197d                	addi	s2,s2,-1
40000302:	020b0063          	beqz	s6,40000322 <core_list_mergesort+0x8a>
40000306:	008b2023          	sw	s0,0(s6)
4000030a:	8b22                	mv	s6,s0
4000030c:	843e                	mv	s0,a5
4000030e:	bfc9                	j	400002e0 <core_list_mergesort+0x48>
40000310:	404c                	lw	a1,4(s0)
40000312:	40c8                	lw	a0,4(s1)
40000314:	8666                	mv	a2,s9
40000316:	9c02                	jalr	s8
40000318:	fea051e3          	blez	a0,400002fa <core_list_mergesort+0x62>
4000031c:	401c                	lw	a5,0(s0)
4000031e:	19fd                	addi	s3,s3,-1
40000320:	b7cd                	j	40000302 <core_list_mergesort+0x6a>
40000322:	8a22                	mv	s4,s0
40000324:	b7dd                	j	4000030a <core_list_mergesort+0x72>
40000326:	50b2                	lw	ra,44(sp)
40000328:	5422                	lw	s0,40(sp)
4000032a:	8552                	mv	a0,s4
4000032c:	5492                	lw	s1,36(sp)
4000032e:	5902                	lw	s2,32(sp)
40000330:	49f2                	lw	s3,28(sp)
40000332:	4a62                	lw	s4,24(sp)
40000334:	4ad2                	lw	s5,20(sp)
40000336:	4b42                	lw	s6,16(sp)
40000338:	4bb2                	lw	s7,12(sp)
4000033a:	4c22                	lw	s8,8(sp)
4000033c:	4c92                	lw	s9,4(sp)
4000033e:	4d02                	lw	s10,0(sp)
40000340:	6145                	addi	sp,sp,48
40000342:	8082                	ret

40000344 <core_bench_list>:
40000344:	715d                	addi	sp,sp,-80
40000346:	c4a2                	sw	s0,72(sp)
40000348:	d65e                	sw	s7,44(sp)
4000034a:	5140                	lw	s0,36(a0)
4000034c:	00451b83          	lh	s7,4(a0)
40000350:	c2a6                	sw	s1,68(sp)
40000352:	c0ca                	sw	s2,64(sp)
40000354:	dc52                	sw	s4,56(sp)
40000356:	da56                	sw	s5,52(sp)
40000358:	d85a                	sw	s6,48(sp)
4000035a:	c686                	sw	ra,76(sp)
4000035c:	de4e                	sw	s3,60(sp)
4000035e:	862a                	mv	a2,a0
40000360:	8a2e                	mv	s4,a1
40000362:	00011e23          	sh	zero,28(sp)
40000366:	00b11f23          	sh	a1,30(sp)
4000036a:	4a81                	li	s5,0
4000036c:	4b01                	li	s6,0
4000036e:	4901                	li	s2,0
40000370:	4481                	li	s1,0
40000372:	077acf63          	blt	s5,s7,400003f0 <core_bench_list+0xac>
40000376:	090a                	slli	s2,s2,0x2
40000378:	41690933          	sub	s2,s2,s6
4000037c:	94ca                	add	s1,s1,s2
4000037e:	04c2                	slli	s1,s1,0x10
40000380:	80c1                	srli	s1,s1,0x10
40000382:	01405963          	blez	s4,40000394 <core_bench_list+0x50>
40000386:	400005b7          	lui	a1,0x40000
4000038a:	8522                	mv	a0,s0
4000038c:	1b458593          	addi	a1,a1,436 # 400001b4 <cmp_complex>
40000390:	3721                	jal	40000298 <core_list_mergesort>
40000392:	842a                	mv	s0,a0
40000394:	4008                	lw	a0,0(s0)
40000396:	3d71                	jal	40000232 <core_list_remove>
40000398:	89aa                	mv	s3,a0
4000039a:	086c                	addi	a1,sp,28
4000039c:	8522                	mv	a0,s0
4000039e:	3d6d                	jal	40000258 <core_list_find>
400003a0:	892a                	mv	s2,a0
400003a2:	e119                	bnez	a0,400003a8 <core_bench_list+0x64>
400003a4:	00042903          	lw	s2,0(s0)
400003a8:	0c091763          	bnez	s2,40000476 <core_bench_list+0x132>
400003ac:	401c                	lw	a5,0(s0)
400003ae:	0049a703          	lw	a4,4(s3)
400003b2:	400005b7          	lui	a1,0x40000
400003b6:	43d4                	lw	a3,4(a5)
400003b8:	8522                	mv	a0,s0
400003ba:	4601                	li	a2,0
400003bc:	00d9a223          	sw	a3,4(s3)
400003c0:	c3d8                	sw	a4,4(a5)
400003c2:	4398                	lw	a4,0(a5)
400003c4:	0ba58593          	addi	a1,a1,186 # 400000ba <cmp_idx>
400003c8:	00e9a023          	sw	a4,0(s3)
400003cc:	0137a023          	sw	s3,0(a5)
400003d0:	35e1                	jal	40000298 <core_list_mergesort>
400003d2:	4100                	lw	s0,0(a0)
400003d4:	892a                	mv	s2,a0
400003d6:	e855                	bnez	s0,4000048a <core_bench_list+0x146>
400003d8:	40b6                	lw	ra,76(sp)
400003da:	4426                	lw	s0,72(sp)
400003dc:	8526                	mv	a0,s1
400003de:	4906                	lw	s2,64(sp)
400003e0:	4496                	lw	s1,68(sp)
400003e2:	59f2                	lw	s3,60(sp)
400003e4:	5a62                	lw	s4,56(sp)
400003e6:	5ad2                	lw	s5,52(sp)
400003e8:	5b42                	lw	s6,48(sp)
400003ea:	5bb2                	lw	s7,44(sp)
400003ec:	6161                	addi	sp,sp,80
400003ee:	8082                	ret
400003f0:	0ffaf793          	andi	a5,s5,255
400003f4:	086c                	addi	a1,sp,28
400003f6:	8522                	mv	a0,s0
400003f8:	c632                	sw	a2,12(sp)
400003fa:	00f11e23          	sh	a5,28(sp)
400003fe:	3da9                	jal	40000258 <core_list_find>
40000400:	89aa                	mv	s3,a0
40000402:	8522                	mv	a0,s0
40000404:	3549                	jal	40000286 <core_list_reverse>
40000406:	842a                	mv	s0,a0
40000408:	4632                	lw	a2,12(sp)
4000040a:	02099c63          	bnez	s3,40000442 <core_bench_list+0xfe>
4000040e:	411c                	lw	a5,0(a0)
40000410:	0b05                	addi	s6,s6,1
40000412:	0b42                	slli	s6,s6,0x10
40000414:	43dc                	lw	a5,4(a5)
40000416:	010b5b13          	srli	s6,s6,0x10
4000041a:	00178783          	lb	a5,1(a5)
4000041e:	8b85                	andi	a5,a5,1
40000420:	94be                	add	s1,s1,a5
40000422:	04c2                	slli	s1,s1,0x10
40000424:	80c1                	srli	s1,s1,0x10
40000426:	01e11783          	lh	a5,30(sp)
4000042a:	0007c563          	bltz	a5,40000434 <core_bench_list+0xf0>
4000042e:	0785                	addi	a5,a5,1
40000430:	00f11f23          	sh	a5,30(sp)
40000434:	001a8793          	addi	a5,s5,1
40000438:	01079a93          	slli	s5,a5,0x10
4000043c:	410ada93          	srai	s5,s5,0x10
40000440:	bf0d                	j	40000372 <core_bench_list+0x2e>
40000442:	0049a703          	lw	a4,4(s3)
40000446:	0905                	addi	s2,s2,1
40000448:	0942                	slli	s2,s2,0x10
4000044a:	00071783          	lh	a5,0(a4)
4000044e:	01095913          	srli	s2,s2,0x10
40000452:	0017f713          	andi	a4,a5,1
40000456:	c711                	beqz	a4,40000462 <core_bench_list+0x11e>
40000458:	87a5                	srai	a5,a5,0x9
4000045a:	8b85                	andi	a5,a5,1
4000045c:	94be                	add	s1,s1,a5
4000045e:	04c2                	slli	s1,s1,0x10
40000460:	80c1                	srli	s1,s1,0x10
40000462:	0009a783          	lw	a5,0(s3)
40000466:	d3e1                	beqz	a5,40000426 <core_bench_list+0xe2>
40000468:	4398                	lw	a4,0(a5)
4000046a:	00e9a023          	sw	a4,0(s3)
4000046e:	4018                	lw	a4,0(s0)
40000470:	c398                	sw	a4,0(a5)
40000472:	c01c                	sw	a5,0(s0)
40000474:	bf4d                	j	40000426 <core_bench_list+0xe2>
40000476:	405c                	lw	a5,4(s0)
40000478:	85a6                	mv	a1,s1
4000047a:	00079503          	lh	a0,0(a5)
4000047e:	011000ef          	jal	ra,40000c8e <crc16>
40000482:	84aa                	mv	s1,a0
40000484:	00092903          	lw	s2,0(s2)
40000488:	b705                	j	400003a8 <core_bench_list+0x64>
4000048a:	00492783          	lw	a5,4(s2)
4000048e:	85a6                	mv	a1,s1
40000490:	00079503          	lh	a0,0(a5)
40000494:	7fa000ef          	jal	ra,40000c8e <crc16>
40000498:	84aa                	mv	s1,a0
4000049a:	4000                	lw	s0,0(s0)
4000049c:	bf2d                	j	400003d6 <core_bench_list+0x92>

4000049e <core_list_init>:
4000049e:	7139                	addi	sp,sp,-64
400004a0:	dc22                	sw	s0,56(sp)
400004a2:	4451                	li	s0,20
400004a4:	02855433          	divu	s0,a0,s0
400004a8:	da26                	sw	s1,52(sp)
400004aa:	d84a                	sw	s2,48(sp)
400004ac:	d64e                	sw	s3,44(sp)
400004ae:	d452                	sw	s4,40(sp)
400004b0:	d256                	sw	s5,36(sp)
400004b2:	de06                	sw	ra,60(sp)
400004b4:	77e1                	lui	a5,0xffff8
400004b6:	0005a023          	sw	zero,0(a1)
400004ba:	08078793          	addi	a5,a5,128 # ffff8080 <_etext+0xbfff5f14>
400004be:	89ae                	mv	s3,a1
400004c0:	8932                	mv	s2,a2
400004c2:	0834                	addi	a3,sp,24
400004c4:	0070                	addi	a2,sp,12
400004c6:	854e                	mv	a0,s3
400004c8:	4a01                	li	s4,0
400004ca:	1479                	addi	s0,s0,-2
400004cc:	00341493          	slli	s1,s0,0x3
400004d0:	94ae                	add	s1,s1,a1
400004d2:	c1c4                	sw	s1,4(a1)
400004d4:	00f49023          	sh	a5,0(s1)
400004d8:	00049123          	sh	zero,2(s1)
400004dc:	00858793          	addi	a5,a1,8
400004e0:	c63e                	sw	a5,12(sp)
400004e2:	00448793          	addi	a5,s1,4
400004e6:	cc3e                	sw	a5,24(sp)
400004e8:	00241a93          	slli	s5,s0,0x2
400004ec:	800007b7          	lui	a5,0x80000
400004f0:	fff7c793          	not	a5,a5
400004f4:	9aa6                	add	s5,s5,s1
400004f6:	ce3e                	sw	a5,28(sp)
400004f8:	8726                	mv	a4,s1
400004fa:	87d6                	mv	a5,s5
400004fc:	086c                	addi	a1,sp,28
400004fe:	39c5                	jal	400001ee <core_list_insert_new>
40000500:	028a6c63          	bltu	s4,s0,40000538 <core_list_init+0x9a>
40000504:	4515                	li	a0,5
40000506:	02a45433          	divu	s0,s0,a0
4000050a:	0009a783          	lw	a5,0(s3)
4000050e:	6611                	lui	a2,0x4
40000510:	4705                	li	a4,1
40000512:	167d                	addi	a2,a2,-1
40000514:	438c                	lw	a1,0(a5)
40000516:	e9a9                	bnez	a1,40000568 <core_list_init+0xca>
40000518:	400005b7          	lui	a1,0x40000
4000051c:	854e                	mv	a0,s3
4000051e:	4601                	li	a2,0
40000520:	0ba58593          	addi	a1,a1,186 # 400000ba <cmp_idx>
40000524:	3b95                	jal	40000298 <core_list_mergesort>
40000526:	50f2                	lw	ra,60(sp)
40000528:	5462                	lw	s0,56(sp)
4000052a:	54d2                	lw	s1,52(sp)
4000052c:	5942                	lw	s2,48(sp)
4000052e:	59b2                	lw	s3,44(sp)
40000530:	5a22                	lw	s4,40(sp)
40000532:	5a92                	lw	s5,36(sp)
40000534:	6121                	addi	sp,sp,64
40000536:	8082                	ret
40000538:	010a1713          	slli	a4,s4,0x10
4000053c:	8341                	srli	a4,a4,0x10
4000053e:	012747b3          	xor	a5,a4,s2
40000542:	078e                	slli	a5,a5,0x3
40000544:	8b1d                	andi	a4,a4,7
40000546:	0787f793          	andi	a5,a5,120
4000054a:	8fd9                	or	a5,a5,a4
4000054c:	00879713          	slli	a4,a5,0x8
40000550:	8fd9                	or	a5,a5,a4
40000552:	00f11e23          	sh	a5,28(sp)
40000556:	8726                	mv	a4,s1
40000558:	87d6                	mv	a5,s5
4000055a:	0834                	addi	a3,sp,24
4000055c:	0070                	addi	a2,sp,12
4000055e:	086c                	addi	a1,sp,28
40000560:	854e                	mv	a0,s3
40000562:	3171                	jal	400001ee <core_list_insert_new>
40000564:	0a05                	addi	s4,s4,1
40000566:	bf69                	j	40000500 <core_list_init+0x62>
40000568:	43c8                	lw	a0,4(a5)
4000056a:	00877763          	bgeu	a4,s0,40000578 <core_list_init+0xda>
4000056e:	00e51123          	sh	a4,2(a0)
40000572:	0705                	addi	a4,a4,1
40000574:	87ae                	mv	a5,a1
40000576:	bf79                	j	40000514 <core_list_init+0x76>
40000578:	01071693          	slli	a3,a4,0x10
4000057c:	82c1                	srli	a3,a3,0x10
4000057e:	00168793          	addi	a5,a3,1
40000582:	07a2                	slli	a5,a5,0x8
40000584:	7007f793          	andi	a5,a5,1792
40000588:	0126c6b3          	xor	a3,a3,s2
4000058c:	8fd5                	or	a5,a5,a3
4000058e:	8ff1                	and	a5,a5,a2
40000590:	00f51123          	sh	a5,2(a0)
40000594:	bff9                	j	40000572 <core_list_init+0xd4>

40000596 <core_init_matrix>:
40000596:	1141                	addi	sp,sp,-16
40000598:	c622                	sw	s0,12(sp)
4000059a:	e211                	bnez	a2,4000059e <core_init_matrix+0x8>
4000059c:	4605                	li	a2,1
4000059e:	4701                	li	a4,0
400005a0:	4781                	li	a5,0
400005a2:	a029                	j	400005ac <core_init_matrix+0x16>
400005a4:	0785                	addi	a5,a5,1
400005a6:	02f78733          	mul	a4,a5,a5
400005aa:	070e                	slli	a4,a4,0x3
400005ac:	fea76ce3          	bltu	a4,a0,400005a4 <core_init_matrix+0xe>
400005b0:	fff78513          	addi	a0,a5,-1 # 7fffffff <_etext+0x3fffde93>
400005b4:	02a507b3          	mul	a5,a0,a0
400005b8:	15fd                	addi	a1,a1,-1
400005ba:	99f1                	andi	a1,a1,-4
400005bc:	0591                	addi	a1,a1,4
400005be:	00151293          	slli	t0,a0,0x1
400005c2:	4e81                	li	t4,0
400005c4:	4f05                	li	t5,1
400005c6:	63c1                	lui	t2,0x10
400005c8:	00179893          	slli	a7,a5,0x1
400005cc:	011587b3          	add	a5,a1,a7
400005d0:	8fbe                	mv	t6,a5
400005d2:	40f58433          	sub	s0,a1,a5
400005d6:	04aeec63          	bltu	t4,a0,4000062e <core_init_matrix+0x98>
400005da:	c69c                	sw	a5,8(a3)
400005dc:	97c6                	add	a5,a5,a7
400005de:	17fd                	addi	a5,a5,-1
400005e0:	4432                	lw	s0,12(sp)
400005e2:	9bf1                	andi	a5,a5,-4
400005e4:	0791                	addi	a5,a5,4
400005e6:	c2cc                	sw	a1,4(a3)
400005e8:	c6dc                	sw	a5,12(a3)
400005ea:	c288                	sw	a0,0(a3)
400005ec:	0141                	addi	sp,sp,16
400005ee:	8082                	ret
400005f0:	02e60633          	mul	a2,a2,a4
400005f4:	01071813          	slli	a6,a4,0x10
400005f8:	01085813          	srli	a6,a6,0x10
400005fc:	0305                	addi	t1,t1,1
400005fe:	02766633          	rem	a2,a2,t2
40000602:	00c80733          	add	a4,a6,a2
40000606:	0742                	slli	a4,a4,0x10
40000608:	8341                	srli	a4,a4,0x10
4000060a:	00ee1023          	sh	a4,0(t3)
4000060e:	9742                	add	a4,a4,a6
40000610:	0ff77713          	andi	a4,a4,255
40000614:	01c40833          	add	a6,s0,t3
40000618:	00e81023          	sh	a4,0(a6)
4000061c:	0e09                	addi	t3,t3,2
4000061e:	01e30733          	add	a4,t1,t5
40000622:	fca367e3          	bltu	t1,a0,400005f0 <core_init_matrix+0x5a>
40000626:	0e85                	addi	t4,t4,1
40000628:	9f96                	add	t6,t6,t0
4000062a:	9f2a                	add	t5,t5,a0
4000062c:	b76d                	j	400005d6 <core_init_matrix+0x40>
4000062e:	8e7e                	mv	t3,t6
40000630:	4301                	li	t1,0
40000632:	b7f5                	j	4000061e <core_init_matrix+0x88>

40000634 <matrix_sum>:
40000634:	00251e93          	slli	t4,a0,0x2
40000638:	4801                	li	a6,0
4000063a:	4781                	li	a5,0
4000063c:	4681                	li	a3,0
4000063e:	4701                	li	a4,0
40000640:	02a81d63          	bne	a6,a0,4000067a <matrix_sum+0x46>
40000644:	853e                	mv	a0,a5
40000646:	8082                	ret
40000648:	00032e03          	lw	t3,0(t1)
4000064c:	07c2                	slli	a5,a5,0x10
4000064e:	83c1                	srli	a5,a5,0x10
40000650:	9772                	add	a4,a4,t3
40000652:	00e65e63          	bge	a2,a4,4000066e <matrix_sum+0x3a>
40000656:	07a9                	addi	a5,a5,10
40000658:	07c2                	slli	a5,a5,0x10
4000065a:	87c1                	srai	a5,a5,0x10
4000065c:	4701                	li	a4,0
4000065e:	0885                	addi	a7,a7,1
40000660:	0311                	addi	t1,t1,4
40000662:	86f2                	mv	a3,t3
40000664:	fea892e3          	bne	a7,a0,40000648 <matrix_sum+0x14>
40000668:	0805                	addi	a6,a6,1
4000066a:	95f6                	add	a1,a1,t4
4000066c:	bfd1                	j	40000640 <matrix_sum+0xc>
4000066e:	01c6a6b3          	slt	a3,a3,t3
40000672:	97b6                	add	a5,a5,a3
40000674:	07c2                	slli	a5,a5,0x10
40000676:	87c1                	srai	a5,a5,0x10
40000678:	b7dd                	j	4000065e <matrix_sum+0x2a>
4000067a:	832e                	mv	t1,a1
4000067c:	4881                	li	a7,0
4000067e:	b7dd                	j	40000664 <matrix_sum+0x30>

40000680 <matrix_mul_const>:
40000680:	00151e13          	slli	t3,a0,0x1
40000684:	00251e93          	slli	t4,a0,0x2
40000688:	4781                	li	a5,0
4000068a:	02a79263          	bne	a5,a0,400006ae <matrix_mul_const+0x2e>
4000068e:	8082                	ret
40000690:	00081303          	lh	t1,0(a6)
40000694:	0705                	addi	a4,a4,1
40000696:	0809                	addi	a6,a6,2
40000698:	02d30333          	mul	t1,t1,a3
4000069c:	0891                	addi	a7,a7,4
4000069e:	fe68ae23          	sw	t1,-4(a7)
400006a2:	fea717e3          	bne	a4,a0,40000690 <matrix_mul_const+0x10>
400006a6:	0785                	addi	a5,a5,1
400006a8:	9672                	add	a2,a2,t3
400006aa:	95f6                	add	a1,a1,t4
400006ac:	bff9                	j	4000068a <matrix_mul_const+0xa>
400006ae:	88ae                	mv	a7,a1
400006b0:	8832                	mv	a6,a2
400006b2:	4701                	li	a4,0
400006b4:	b7fd                	j	400006a2 <matrix_mul_const+0x22>

400006b6 <matrix_add_const>:
400006b6:	00151893          	slli	a7,a0,0x1
400006ba:	4701                	li	a4,0
400006bc:	00a71f63          	bne	a4,a0,400006da <matrix_add_const+0x24>
400006c0:	8082                	ret
400006c2:	0007d803          	lhu	a6,0(a5)
400006c6:	0685                	addi	a3,a3,1
400006c8:	0789                	addi	a5,a5,2
400006ca:	9832                	add	a6,a6,a2
400006cc:	ff079f23          	sh	a6,-2(a5)
400006d0:	fea699e3          	bne	a3,a0,400006c2 <matrix_add_const+0xc>
400006d4:	0705                	addi	a4,a4,1
400006d6:	95c6                	add	a1,a1,a7
400006d8:	b7d5                	j	400006bc <matrix_add_const+0x6>
400006da:	87ae                	mv	a5,a1
400006dc:	4681                	li	a3,0
400006de:	bfcd                	j	400006d0 <matrix_add_const+0x1a>

400006e0 <matrix_mul_vect>:
400006e0:	00151893          	slli	a7,a0,0x1
400006e4:	050a                	slli	a0,a0,0x2
400006e6:	952e                	add	a0,a0,a1
400006e8:	00b51363          	bne	a0,a1,400006ee <matrix_mul_vect+0xe>
400006ec:	8082                	ret
400006ee:	4781                	li	a5,0
400006f0:	4701                	li	a4,0
400006f2:	00f60833          	add	a6,a2,a5
400006f6:	00f68333          	add	t1,a3,a5
400006fa:	00081803          	lh	a6,0(a6)
400006fe:	00031303          	lh	t1,0(t1)
40000702:	0789                	addi	a5,a5,2
40000704:	02680833          	mul	a6,a6,t1
40000708:	9742                	add	a4,a4,a6
4000070a:	fef894e3          	bne	a7,a5,400006f2 <matrix_mul_vect+0x12>
4000070e:	c198                	sw	a4,0(a1)
40000710:	9646                	add	a2,a2,a7
40000712:	0591                	addi	a1,a1,4
40000714:	bfd1                	j	400006e8 <matrix_mul_vect+0x8>

40000716 <matrix_mul_matrix>:
40000716:	00251293          	slli	t0,a0,0x2
4000071a:	00151f93          	slli	t6,a0,0x1
4000071e:	4801                	li	a6,0
40000720:	02a81f63          	bne	a6,a0,4000075e <matrix_mul_matrix+0x48>
40000724:	8082                	ret
40000726:	00171793          	slli	a5,a4,0x1
4000072a:	97b6                	add	a5,a5,a3
4000072c:	8eb2                	mv	t4,a2
4000072e:	4301                	li	t1,0
40000730:	4e01                	li	t3,0
40000732:	000e9f03          	lh	t5,0(t4)
40000736:	00079383          	lh	t2,0(a5)
4000073a:	0e05                	addi	t3,t3,1
4000073c:	0e89                	addi	t4,t4,2
4000073e:	027f0f33          	mul	t5,t5,t2
40000742:	97fe                	add	a5,a5,t6
40000744:	937a                	add	t1,t1,t5
40000746:	ffc516e3          	bne	a0,t3,40000732 <matrix_mul_matrix+0x1c>
4000074a:	0068a023          	sw	t1,0(a7)
4000074e:	0705                	addi	a4,a4,1
40000750:	0891                	addi	a7,a7,4
40000752:	fca71ae3          	bne	a4,a0,40000726 <matrix_mul_matrix+0x10>
40000756:	0805                	addi	a6,a6,1
40000758:	9596                	add	a1,a1,t0
4000075a:	967e                	add	a2,a2,t6
4000075c:	b7d1                	j	40000720 <matrix_mul_matrix+0xa>
4000075e:	88ae                	mv	a7,a1
40000760:	4701                	li	a4,0
40000762:	bfc5                	j	40000752 <matrix_mul_matrix+0x3c>

40000764 <matrix_mul_matrix_bitextract>:
40000764:	00251393          	slli	t2,a0,0x2
40000768:	00151293          	slli	t0,a0,0x1
4000076c:	4301                	li	t1,0
4000076e:	04a31863          	bne	t1,a0,400007be <matrix_mul_matrix_bitextract+0x5a>
40000772:	8082                	ret
40000774:	00189713          	slli	a4,a7,0x1
40000778:	9736                	add	a4,a4,a3
4000077a:	8fb2                	mv	t6,a2
4000077c:	4e81                	li	t4,0
4000077e:	4f01                	li	t5,0
40000780:	00071803          	lh	a6,0(a4)
40000784:	000f9783          	lh	a5,0(t6)
40000788:	0f05                	addi	t5,t5,1
4000078a:	0f89                	addi	t6,t6,2
4000078c:	030787b3          	mul	a5,a5,a6
40000790:	9716                	add	a4,a4,t0
40000792:	4027d813          	srai	a6,a5,0x2
40000796:	8795                	srai	a5,a5,0x5
40000798:	00f87813          	andi	a6,a6,15
4000079c:	07f7f793          	andi	a5,a5,127
400007a0:	02f807b3          	mul	a5,a6,a5
400007a4:	9ebe                	add	t4,t4,a5
400007a6:	fde51de3          	bne	a0,t5,40000780 <matrix_mul_matrix_bitextract+0x1c>
400007aa:	01de2023          	sw	t4,0(t3)
400007ae:	0885                	addi	a7,a7,1
400007b0:	0e11                	addi	t3,t3,4
400007b2:	fca891e3          	bne	a7,a0,40000774 <matrix_mul_matrix_bitextract+0x10>
400007b6:	0305                	addi	t1,t1,1
400007b8:	959e                	add	a1,a1,t2
400007ba:	9616                	add	a2,a2,t0
400007bc:	bf4d                	j	4000076e <matrix_mul_matrix_bitextract+0xa>
400007be:	8e2e                	mv	t3,a1
400007c0:	4881                	li	a7,0
400007c2:	bfc5                	j	400007b2 <matrix_mul_matrix_bitextract+0x4e>

400007c4 <matrix_test>:
400007c4:	1101                	addi	sp,sp,-32
400007c6:	c84a                	sw	s2,16(sp)
400007c8:	8932                	mv	s2,a2
400007ca:	ca26                	sw	s1,20(sp)
400007cc:	863a                	mv	a2,a4
400007ce:	c452                	sw	s4,8(sp)
400007d0:	84ae                	mv	s1,a1
400007d2:	7a7d                	lui	s4,0xfffff
400007d4:	85ca                	mv	a1,s2
400007d6:	ce06                	sw	ra,28(sp)
400007d8:	01476a33          	or	s4,a4,s4
400007dc:	cc22                	sw	s0,24(sp)
400007de:	c64e                	sw	s3,12(sp)
400007e0:	c256                	sw	s5,4(sp)
400007e2:	89ba                	mv	s3,a4
400007e4:	c05a                	sw	s6,0(sp)
400007e6:	842a                	mv	s0,a0
400007e8:	8ab6                	mv	s5,a3
400007ea:	35f1                	jal	400006b6 <matrix_add_const>
400007ec:	86ce                	mv	a3,s3
400007ee:	864a                	mv	a2,s2
400007f0:	85a6                	mv	a1,s1
400007f2:	8522                	mv	a0,s0
400007f4:	3571                	jal	40000680 <matrix_mul_const>
400007f6:	8652                	mv	a2,s4
400007f8:	85a6                	mv	a1,s1
400007fa:	8522                	mv	a0,s0
400007fc:	3d25                	jal	40000634 <matrix_sum>
400007fe:	4581                	li	a1,0
40000800:	2179                	jal	40000c8e <crc16>
40000802:	86d6                	mv	a3,s5
40000804:	8b2a                	mv	s6,a0
40000806:	864a                	mv	a2,s2
40000808:	85a6                	mv	a1,s1
4000080a:	8522                	mv	a0,s0
4000080c:	3dd1                	jal	400006e0 <matrix_mul_vect>
4000080e:	8652                	mv	a2,s4
40000810:	85a6                	mv	a1,s1
40000812:	8522                	mv	a0,s0
40000814:	3505                	jal	40000634 <matrix_sum>
40000816:	85da                	mv	a1,s6
40000818:	299d                	jal	40000c8e <crc16>
4000081a:	86d6                	mv	a3,s5
4000081c:	8b2a                	mv	s6,a0
4000081e:	864a                	mv	a2,s2
40000820:	85a6                	mv	a1,s1
40000822:	8522                	mv	a0,s0
40000824:	3dcd                	jal	40000716 <matrix_mul_matrix>
40000826:	8652                	mv	a2,s4
40000828:	85a6                	mv	a1,s1
4000082a:	8522                	mv	a0,s0
4000082c:	3521                	jal	40000634 <matrix_sum>
4000082e:	85da                	mv	a1,s6
40000830:	29b9                	jal	40000c8e <crc16>
40000832:	86d6                	mv	a3,s5
40000834:	8b2a                	mv	s6,a0
40000836:	864a                	mv	a2,s2
40000838:	85a6                	mv	a1,s1
4000083a:	8522                	mv	a0,s0
4000083c:	3725                	jal	40000764 <matrix_mul_matrix_bitextract>
4000083e:	8652                	mv	a2,s4
40000840:	85a6                	mv	a1,s1
40000842:	8522                	mv	a0,s0
40000844:	3bc5                	jal	40000634 <matrix_sum>
40000846:	85da                	mv	a1,s6
40000848:	2199                	jal	40000c8e <crc16>
4000084a:	41300633          	neg	a2,s3
4000084e:	0642                	slli	a2,a2,0x10
40000850:	84aa                	mv	s1,a0
40000852:	85ca                	mv	a1,s2
40000854:	8522                	mv	a0,s0
40000856:	8641                	srai	a2,a2,0x10
40000858:	3db9                	jal	400006b6 <matrix_add_const>
4000085a:	40f2                	lw	ra,28(sp)
4000085c:	4462                	lw	s0,24(sp)
4000085e:	01049513          	slli	a0,s1,0x10
40000862:	4942                	lw	s2,16(sp)
40000864:	44d2                	lw	s1,20(sp)
40000866:	49b2                	lw	s3,12(sp)
40000868:	4a22                	lw	s4,8(sp)
4000086a:	4a92                	lw	s5,4(sp)
4000086c:	4b02                	lw	s6,0(sp)
4000086e:	8541                	srai	a0,a0,0x10
40000870:	6105                	addi	sp,sp,32
40000872:	8082                	ret

40000874 <core_bench_matrix>:
40000874:	1141                	addi	sp,sp,-16
40000876:	c422                	sw	s0,8(sp)
40000878:	872e                	mv	a4,a1
4000087a:	8432                	mv	s0,a2
4000087c:	454c                	lw	a1,12(a0)
4000087e:	4514                	lw	a3,8(a0)
40000880:	4150                	lw	a2,4(a0)
40000882:	4108                	lw	a0,0(a0)
40000884:	c606                	sw	ra,12(sp)
40000886:	3f3d                	jal	400007c4 <matrix_test>
40000888:	85a2                	mv	a1,s0
4000088a:	4422                	lw	s0,8(sp)
4000088c:	40b2                	lw	ra,12(sp)
4000088e:	0141                	addi	sp,sp,16
40000890:	aefd                	j	40000c8e <crc16>

40000892 <barebones_clock>:
40000892:	1141                	addi	sp,sp,-16
40000894:	c606                	sw	ra,12(sp)
40000896:	2f1000ef          	jal	ra,40001386 <get_mtimer>
4000089a:	40b2                	lw	ra,12(sp)
4000089c:	05e2                	slli	a1,a1,0x18
4000089e:	8121                	srli	a0,a0,0x8
400008a0:	8d4d                	or	a0,a0,a1
400008a2:	0141                	addi	sp,sp,16
400008a4:	8082                	ret

400008a6 <start_time>:
400008a6:	1141                	addi	sp,sp,-16
400008a8:	c606                	sw	ra,12(sp)
400008aa:	37e5                	jal	40000892 <barebones_clock>
400008ac:	40b2                	lw	ra,12(sp)
400008ae:	00a02e23          	sw	a0,28(zero) # 1c <start_time_val>
400008b2:	85aa                	mv	a1,a0
400008b4:	40002537          	lui	a0,0x40002
400008b8:	01450513          	addi	a0,a0,20 # 40002014 <errpat+0x444>
400008bc:	0141                	addi	sp,sp,16
400008be:	ab51                	j	40000e52 <ee_printf>

400008c0 <stop_time>:
400008c0:	1141                	addi	sp,sp,-16
400008c2:	c606                	sw	ra,12(sp)
400008c4:	37f9                	jal	40000892 <barebones_clock>
400008c6:	40b2                	lw	ra,12(sp)
400008c8:	00a02c23          	sw	a0,24(zero) # 18 <__data_end>
400008cc:	85aa                	mv	a1,a0
400008ce:	40002537          	lui	a0,0x40002
400008d2:	02450513          	addi	a0,a0,36 # 40002024 <errpat+0x454>
400008d6:	0141                	addi	sp,sp,16
400008d8:	abad                	j	40000e52 <ee_printf>

400008da <get_time>:
400008da:	01802503          	lw	a0,24(zero) # 18 <__data_end>
400008de:	01c02783          	lw	a5,28(zero) # 1c <start_time_val>
400008e2:	8d1d                	sub	a0,a0,a5
400008e4:	8082                	ret

400008e6 <time_in_secs>:
400008e6:	0b700793          	li	a5,183
400008ea:	02f55533          	divu	a0,a0,a5
400008ee:	8082                	ret

400008f0 <portable_init>:
400008f0:	1141                	addi	sp,sp,-16
400008f2:	c422                	sw	s0,8(sp)
400008f4:	842a                	mv	s0,a0
400008f6:	40002537          	lui	a0,0x40002
400008fa:	03450513          	addi	a0,a0,52 # 40002034 <errpat+0x464>
400008fe:	c606                	sw	ra,12(sp)
40000900:	2b89                	jal	40000e52 <ee_printf>
40000902:	4785                	li	a5,1
40000904:	00f40023          	sb	a5,0(s0)
40000908:	40b2                	lw	ra,12(sp)
4000090a:	4422                	lw	s0,8(sp)
4000090c:	0141                	addi	sp,sp,16
4000090e:	8082                	ret

40000910 <portable_fini>:
40000910:	00050023          	sb	zero,0(a0)
40000914:	8082                	ret

40000916 <core_init_state>:
40000916:	4781                	li	a5,0
40000918:	4681                	li	a3,0
4000091a:	0585                	addi	a1,a1,1
4000091c:	00f68333          	add	t1,a3,a5
40000920:	05c2                	slli	a1,a1,0x10
40000922:	40002837          	lui	a6,0x40002
40000926:	40002e37          	lui	t3,0x40002
4000092a:	fff50f13          	addi	t5,a0,-1
4000092e:	00130393          	addi	t2,t1,1
40000932:	81c1                	srli	a1,a1,0x10
40000934:	4701                	li	a4,0
40000936:	02c00f93          	li	t6,44
4000093a:	4291                	li	t0,4
4000093c:	ba080813          	addi	a6,a6,-1120 # 40001ba0 <intpat>
40000940:	b6ce0e13          	addi	t3,t3,-1172 # 40001b6c <state_known_crc+0xc>
40000944:	05e3e963          	bltu	t2,t5,40000996 <core_init_state+0x80>
40000948:	04a6e163          	bltu	a3,a0,4000098a <core_init_state+0x74>
4000094c:	8082                	ret
4000094e:	97c2                	add	a5,a5,a6
40000950:	4398                	lw	a4,0(a5)
40000952:	4791                	li	a5,4
40000954:	0585                	addi	a1,a1,1
40000956:	00f68333          	add	t1,a3,a5
4000095a:	05c2                	slli	a1,a1,0x10
4000095c:	00130393          	addi	t2,t1,1
40000960:	81c1                	srli	a1,a1,0x10
40000962:	03e3ec63          	bltu	t2,t5,4000099a <core_init_state+0x84>
40000966:	00a6ec63          	bltu	a3,a0,4000097e <core_init_state+0x68>
4000096a:	4432                	lw	s0,12(sp)
4000096c:	0141                	addi	sp,sp,16
4000096e:	8082                	ret
40000970:	4b98                	lw	a4,16(a5)
40000972:	47a1                	li	a5,8
40000974:	b7c5                	j	40000954 <core_init_state+0x3e>
40000976:	5398                	lw	a4,32(a5)
40000978:	bfed                	j	40000972 <core_init_state+0x5c>
4000097a:	5b98                	lw	a4,48(a5)
4000097c:	bfdd                	j	40000972 <core_init_state+0x5c>
4000097e:	00d607b3          	add	a5,a2,a3
40000982:	00078023          	sb	zero,0(a5)
40000986:	0685                	addi	a3,a3,1
40000988:	bff9                	j	40000966 <core_init_state+0x50>
4000098a:	00d607b3          	add	a5,a2,a3
4000098e:	00078023          	sb	zero,0(a5)
40000992:	0685                	addi	a3,a3,1
40000994:	bf55                	j	40000948 <core_init_state+0x32>
40000996:	1141                	addi	sp,sp,-16
40000998:	c622                	sw	s0,12(sp)
4000099a:	c395                	beqz	a5,400009be <core_init_state+0xa8>
4000099c:	4881                	li	a7,0
4000099e:	01170eb3          	add	t4,a4,a7
400009a2:	000ec403          	lbu	s0,0(t4)
400009a6:	01168eb3          	add	t4,a3,a7
400009aa:	9eb2                	add	t4,t4,a2
400009ac:	008e8023          	sb	s0,0(t4)
400009b0:	0885                	addi	a7,a7,1
400009b2:	ff1796e3          	bne	a5,a7,4000099e <core_init_state+0x88>
400009b6:	9332                	add	t1,t1,a2
400009b8:	01f30023          	sb	t6,0(t1)
400009bc:	869e                	mv	a3,t2
400009be:	0075f713          	andi	a4,a1,7
400009c2:	1775                	addi	a4,a4,-3
400009c4:	0742                	slli	a4,a4,0x10
400009c6:	0015d793          	srli	a5,a1,0x1
400009ca:	8341                	srli	a4,a4,0x10
400009cc:	8bb1                	andi	a5,a5,12
400009ce:	f8e2e0e3          	bltu	t0,a4,4000094e <core_init_state+0x38>
400009d2:	070a                	slli	a4,a4,0x2
400009d4:	9772                	add	a4,a4,t3
400009d6:	4318                	lw	a4,0(a4)
400009d8:	97c2                	add	a5,a5,a6
400009da:	8702                	jr	a4

400009dc <core_state_transition>:
400009dc:	4114                	lw	a3,0(a0)
400009de:	40002837          	lui	a6,0x40002
400009e2:	4701                	li	a4,0
400009e4:	4305                	li	t1,1
400009e6:	02c00e13          	li	t3,44
400009ea:	4e9d                	li	t4,7
400009ec:	b8080813          	addi	a6,a6,-1152 # 40001b80 <state_known_crc+0x20>
400009f0:	4625                	li	a2,9
400009f2:	04500f13          	li	t5,69
400009f6:	02e00893          	li	a7,46
400009fa:	0006c783          	lbu	a5,0(a3)
400009fe:	c399                	beqz	a5,40000a04 <core_state_transition+0x28>
40000a00:	00671563          	bne	a4,t1,40000a0a <core_state_transition+0x2e>
40000a04:	c114                	sw	a3,0(a0)
40000a06:	853a                	mv	a0,a4
40000a08:	8082                	ret
40000a0a:	0685                	addi	a3,a3,1
40000a0c:	ffc78ce3          	beq	a5,t3,40000a04 <core_state_transition+0x28>
40000a10:	feeee5e3          	bltu	t4,a4,400009fa <core_state_transition+0x1e>
40000a14:	00271f93          	slli	t6,a4,0x2
40000a18:	9fc2                	add	t6,t6,a6
40000a1a:	000faf83          	lw	t6,0(t6)
40000a1e:	8f82                	jr	t6
40000a20:	fd078f93          	addi	t6,a5,-48
40000a24:	0fffff93          	andi	t6,t6,255
40000a28:	4711                	li	a4,4
40000a2a:	03f67063          	bgeu	a2,t6,40000a4a <core_state_transition+0x6e>
40000a2e:	fd578f93          	addi	t6,a5,-43
40000a32:	0fdfff93          	andi	t6,t6,253
40000a36:	4709                	li	a4,2
40000a38:	000f8963          	beqz	t6,40000a4a <core_state_transition+0x6e>
40000a3c:	4715                	li	a4,5
40000a3e:	01178663          	beq	a5,a7,40000a4a <core_state_transition+0x6e>
40000a42:	41dc                	lw	a5,4(a1)
40000a44:	4705                	li	a4,1
40000a46:	0785                	addi	a5,a5,1
40000a48:	c1dc                	sw	a5,4(a1)
40000a4a:	419c                	lw	a5,0(a1)
40000a4c:	0785                	addi	a5,a5,1
40000a4e:	c19c                	sw	a5,0(a1)
40000a50:	b76d                	j	400009fa <core_state_transition+0x1e>
40000a52:	4598                	lw	a4,8(a1)
40000a54:	fd078f93          	addi	t6,a5,-48
40000a58:	0fffff93          	andi	t6,t6,255
40000a5c:	0705                	addi	a4,a4,1
40000a5e:	01f67763          	bgeu	a2,t6,40000a6c <core_state_transition+0x90>
40000a62:	01179863          	bne	a5,a7,40000a72 <core_state_transition+0x96>
40000a66:	c598                	sw	a4,8(a1)
40000a68:	4715                	li	a4,5
40000a6a:	bf41                	j	400009fa <core_state_transition+0x1e>
40000a6c:	c598                	sw	a4,8(a1)
40000a6e:	4711                	li	a4,4
40000a70:	b769                	j	400009fa <core_state_transition+0x1e>
40000a72:	c598                	sw	a4,8(a1)
40000a74:	4705                	li	a4,1
40000a76:	b751                	j	400009fa <core_state_transition+0x1e>
40000a78:	01179663          	bne	a5,a7,40000a84 <core_state_transition+0xa8>
40000a7c:	499c                	lw	a5,16(a1)
40000a7e:	0785                	addi	a5,a5,1
40000a80:	c99c                	sw	a5,16(a1)
40000a82:	b7dd                	j	40000a68 <core_state_transition+0x8c>
40000a84:	fd078793          	addi	a5,a5,-48
40000a88:	0ff7f793          	andi	a5,a5,255
40000a8c:	f6f677e3          	bgeu	a2,a5,400009fa <core_state_transition+0x1e>
40000a90:	499c                	lw	a5,16(a1)
40000a92:	0785                	addi	a5,a5,1
40000a94:	c99c                	sw	a5,16(a1)
40000a96:	bff9                	j	40000a74 <core_state_transition+0x98>
40000a98:	0df7ff93          	andi	t6,a5,223
40000a9c:	01ef9763          	bne	t6,t5,40000aaa <core_state_transition+0xce>
40000aa0:	49dc                	lw	a5,20(a1)
40000aa2:	470d                	li	a4,3
40000aa4:	0785                	addi	a5,a5,1
40000aa6:	c9dc                	sw	a5,20(a1)
40000aa8:	bf89                	j	400009fa <core_state_transition+0x1e>
40000aaa:	fd078793          	addi	a5,a5,-48
40000aae:	0ff7f793          	andi	a5,a5,255
40000ab2:	f4f674e3          	bgeu	a2,a5,400009fa <core_state_transition+0x1e>
40000ab6:	49dc                	lw	a5,20(a1)
40000ab8:	0785                	addi	a5,a5,1
40000aba:	c9dc                	sw	a5,20(a1)
40000abc:	bf65                	j	40000a74 <core_state_transition+0x98>
40000abe:	45d8                	lw	a4,12(a1)
40000ac0:	fd578793          	addi	a5,a5,-43
40000ac4:	0fd7f793          	andi	a5,a5,253
40000ac8:	0705                	addi	a4,a4,1
40000aca:	c5d8                	sw	a4,12(a1)
40000acc:	4719                	li	a4,6
40000ace:	f3dd                	bnez	a5,40000a74 <core_state_transition+0x98>
40000ad0:	b72d                	j	400009fa <core_state_transition+0x1e>
40000ad2:	4d98                	lw	a4,24(a1)
40000ad4:	fd078793          	addi	a5,a5,-48
40000ad8:	0ff7f793          	andi	a5,a5,255
40000adc:	0705                	addi	a4,a4,1
40000ade:	cd98                	sw	a4,24(a1)
40000ae0:	471d                	li	a4,7
40000ae2:	f0f67ce3          	bgeu	a2,a5,400009fa <core_state_transition+0x1e>
40000ae6:	b779                	j	40000a74 <core_state_transition+0x98>
40000ae8:	fd078793          	addi	a5,a5,-48
40000aec:	0ff7f793          	andi	a5,a5,255
40000af0:	f0f675e3          	bgeu	a2,a5,400009fa <core_state_transition+0x1e>
40000af4:	41dc                	lw	a5,4(a1)
40000af6:	0785                	addi	a5,a5,1
40000af8:	c1dc                	sw	a5,4(a1)
40000afa:	bfad                	j	40000a74 <core_state_transition+0x98>

40000afc <core_bench_state>:
40000afc:	7119                	addi	sp,sp,-128
40000afe:	dca2                	sw	s0,120(sp)
40000b00:	daa6                	sw	s1,116(sp)
40000b02:	d8ca                	sw	s2,112(sp)
40000b04:	d6ce                	sw	s3,108(sp)
40000b06:	d4d2                	sw	s4,104(sp)
40000b08:	842e                	mv	s0,a1
40000b0a:	893e                	mv	s2,a5
40000b0c:	ce2e                	sw	a1,28(sp)
40000b0e:	de86                	sw	ra,124(sp)
40000b10:	84aa                	mv	s1,a0
40000b12:	8a36                	mv	s4,a3
40000b14:	89ba                	mv	s3,a4
40000b16:	4581                	li	a1,0
40000b18:	02000793          	li	a5,32
40000b1c:	0098                	addi	a4,sp,64
40000b1e:	972e                	add	a4,a4,a1
40000b20:	00072023          	sw	zero,0(a4)
40000b24:	1018                	addi	a4,sp,32
40000b26:	972e                	add	a4,a4,a1
40000b28:	00072023          	sw	zero,0(a4)
40000b2c:	0591                	addi	a1,a1,4
40000b2e:	fef597e3          	bne	a1,a5,40000b1c <core_bench_state+0x20>
40000b32:	47f2                	lw	a5,28(sp)
40000b34:	0007c783          	lbu	a5,0(a5)
40000b38:	efa1                	bnez	a5,40000b90 <core_bench_state+0x94>
40000b3a:	ce22                	sw	s0,28(sp)
40000b3c:	94a2                	add	s1,s1,s0
40000b3e:	02c00713          	li	a4,44
40000b42:	47f2                	lw	a5,28(sp)
40000b44:	0697e463          	bltu	a5,s1,40000bac <core_bench_state+0xb0>
40000b48:	ce22                	sw	s0,28(sp)
40000b4a:	47f2                	lw	a5,28(sp)
40000b4c:	0007c783          	lbu	a5,0(a5)
40000b50:	ebad                	bnez	a5,40000bc2 <core_bench_state+0xc6>
40000b52:	ce22                	sw	s0,28(sp)
40000b54:	02c00713          	li	a4,44
40000b58:	47f2                	lw	a5,28(sp)
40000b5a:	0897e063          	bltu	a5,s1,40000bda <core_bench_state+0xde>
40000b5e:	4401                	li	s0,0
40000b60:	02000493          	li	s1,32
40000b64:	101c                	addi	a5,sp,32
40000b66:	97a2                	add	a5,a5,s0
40000b68:	4388                	lw	a0,0(a5)
40000b6a:	85ca                	mv	a1,s2
40000b6c:	2219                	jal	40000c72 <crcu32>
40000b6e:	009c                	addi	a5,sp,64
40000b70:	97a2                	add	a5,a5,s0
40000b72:	85aa                	mv	a1,a0
40000b74:	4388                	lw	a0,0(a5)
40000b76:	0411                	addi	s0,s0,4
40000b78:	28ed                	jal	40000c72 <crcu32>
40000b7a:	892a                	mv	s2,a0
40000b7c:	fe9414e3          	bne	s0,s1,40000b64 <core_bench_state+0x68>
40000b80:	50f6                	lw	ra,124(sp)
40000b82:	5466                	lw	s0,120(sp)
40000b84:	54d6                	lw	s1,116(sp)
40000b86:	5946                	lw	s2,112(sp)
40000b88:	59b6                	lw	s3,108(sp)
40000b8a:	5a26                	lw	s4,104(sp)
40000b8c:	6109                	addi	sp,sp,128
40000b8e:	8082                	ret
40000b90:	008c                	addi	a1,sp,64
40000b92:	0868                	addi	a0,sp,28
40000b94:	c632                	sw	a2,12(sp)
40000b96:	3599                	jal	400009dc <core_state_transition>
40000b98:	109c                	addi	a5,sp,96
40000b9a:	050a                	slli	a0,a0,0x2
40000b9c:	953e                	add	a0,a0,a5
40000b9e:	fc052783          	lw	a5,-64(a0)
40000ba2:	4632                	lw	a2,12(sp)
40000ba4:	0785                	addi	a5,a5,1
40000ba6:	fcf52023          	sw	a5,-64(a0)
40000baa:	b761                	j	40000b32 <core_bench_state+0x36>
40000bac:	0007c583          	lbu	a1,0(a5)
40000bb0:	00e58563          	beq	a1,a4,40000bba <core_bench_state+0xbe>
40000bb4:	8db1                	xor	a1,a1,a2
40000bb6:	00b78023          	sb	a1,0(a5)
40000bba:	47f2                	lw	a5,28(sp)
40000bbc:	97ce                	add	a5,a5,s3
40000bbe:	ce3e                	sw	a5,28(sp)
40000bc0:	b749                	j	40000b42 <core_bench_state+0x46>
40000bc2:	008c                	addi	a1,sp,64
40000bc4:	0868                	addi	a0,sp,28
40000bc6:	3d19                	jal	400009dc <core_state_transition>
40000bc8:	109c                	addi	a5,sp,96
40000bca:	050a                	slli	a0,a0,0x2
40000bcc:	953e                	add	a0,a0,a5
40000bce:	fc052783          	lw	a5,-64(a0)
40000bd2:	0785                	addi	a5,a5,1
40000bd4:	fcf52023          	sw	a5,-64(a0)
40000bd8:	bf8d                	j	40000b4a <core_bench_state+0x4e>
40000bda:	0007c603          	lbu	a2,0(a5)
40000bde:	00e60663          	beq	a2,a4,40000bea <core_bench_state+0xee>
40000be2:	01464633          	xor	a2,a2,s4
40000be6:	00c78023          	sb	a2,0(a5)
40000bea:	47f2                	lw	a5,28(sp)
40000bec:	97ce                	add	a5,a5,s3
40000bee:	ce3e                	sw	a5,28(sp)
40000bf0:	b7a5                	j	40000b58 <core_bench_state+0x5c>

40000bf2 <get_seed_32>:
40000bf2:	157d                	addi	a0,a0,-1
40000bf4:	4791                	li	a5,4
40000bf6:	02a7e963          	bltu	a5,a0,40000c28 <get_seed_32+0x36>
40000bfa:	400027b7          	lui	a5,0x40002
40000bfe:	be078793          	addi	a5,a5,-1056 # 40001be0 <errpat+0x10>
40000c02:	050a                	slli	a0,a0,0x2
40000c04:	953e                	add	a0,a0,a5
40000c06:	411c                	lw	a5,0(a0)
40000c08:	8782                	jr	a5
40000c0a:	02802503          	lw	a0,40(zero) # 28 <seed1_volatile>
40000c0e:	8082                	ret
40000c10:	02402503          	lw	a0,36(zero) # 24 <seed2_volatile>
40000c14:	8082                	ret
40000c16:	01402503          	lw	a0,20(zero) # 14 <seed3_volatile>
40000c1a:	8082                	ret
40000c1c:	01002503          	lw	a0,16(zero) # 10 <seed4_volatile>
40000c20:	8082                	ret
40000c22:	02002503          	lw	a0,32(zero) # 20 <seed5_volatile>
40000c26:	8082                	ret
40000c28:	4501                	li	a0,0
40000c2a:	8082                	ret

40000c2c <crcu8>:
40000c2c:	6691                	lui	a3,0x4
40000c2e:	47a1                	li	a5,8
40000c30:	0689                	addi	a3,a3,2
40000c32:	7661                	lui	a2,0xffff8
40000c34:	00a5c733          	xor	a4,a1,a0
40000c38:	8b05                	andi	a4,a4,1
40000c3a:	8105                	srli	a0,a0,0x1
40000c3c:	c311                	beqz	a4,40000c40 <crcu8+0x14>
40000c3e:	8db5                	xor	a1,a1,a3
40000c40:	8185                	srli	a1,a1,0x1
40000c42:	c701                	beqz	a4,40000c4a <crcu8+0x1e>
40000c44:	8dd1                	or	a1,a1,a2
40000c46:	05c2                	slli	a1,a1,0x10
40000c48:	81c1                	srli	a1,a1,0x10
40000c4a:	17fd                	addi	a5,a5,-1
40000c4c:	0ff7f793          	andi	a5,a5,255
40000c50:	f3f5                	bnez	a5,40000c34 <crcu8+0x8>
40000c52:	852e                	mv	a0,a1
40000c54:	8082                	ret

40000c56 <crcu16>:
40000c56:	1141                	addi	sp,sp,-16
40000c58:	c422                	sw	s0,8(sp)
40000c5a:	842a                	mv	s0,a0
40000c5c:	0ff57513          	andi	a0,a0,255
40000c60:	c606                	sw	ra,12(sp)
40000c62:	37e9                	jal	40000c2c <crcu8>
40000c64:	85aa                	mv	a1,a0
40000c66:	00845513          	srli	a0,s0,0x8
40000c6a:	4422                	lw	s0,8(sp)
40000c6c:	40b2                	lw	ra,12(sp)
40000c6e:	0141                	addi	sp,sp,16
40000c70:	bf75                	j	40000c2c <crcu8>

40000c72 <crcu32>:
40000c72:	1141                	addi	sp,sp,-16
40000c74:	c422                	sw	s0,8(sp)
40000c76:	842a                	mv	s0,a0
40000c78:	0542                	slli	a0,a0,0x10
40000c7a:	8141                	srli	a0,a0,0x10
40000c7c:	c606                	sw	ra,12(sp)
40000c7e:	3fe1                	jal	40000c56 <crcu16>
40000c80:	85aa                	mv	a1,a0
40000c82:	01045513          	srli	a0,s0,0x10
40000c86:	4422                	lw	s0,8(sp)
40000c88:	40b2                	lw	ra,12(sp)
40000c8a:	0141                	addi	sp,sp,16
40000c8c:	b7e9                	j	40000c56 <crcu16>

40000c8e <crc16>:
40000c8e:	0542                	slli	a0,a0,0x10
40000c90:	8141                	srli	a0,a0,0x10
40000c92:	b7d1                	j	40000c56 <crcu16>

40000c94 <check_data_types>:
40000c94:	4501                	li	a0,0
40000c96:	8082                	ret

40000c98 <number>:
40000c98:	0407f813          	andi	a6,a5,64
40000c9c:	715d                	addi	sp,sp,-80
40000c9e:	00080e63          	beqz	a6,40000cba <number+0x22>
40000ca2:	400028b7          	lui	a7,0x40002
40000ca6:	12888893          	addi	a7,a7,296 # 40002128 <errpat+0x558>
40000caa:	0107ff93          	andi	t6,a5,16
40000cae:	000f8b63          	beqz	t6,40000cc4 <number+0x2c>
40000cb2:	9bf9                	andi	a5,a5,-2
40000cb4:	02000e13          	li	t3,32
40000cb8:	a821                	j	40000cd0 <number+0x38>
40000cba:	400028b7          	lui	a7,0x40002
40000cbe:	10088893          	addi	a7,a7,256 # 40002100 <errpat+0x530>
40000cc2:	b7e5                	j	40000caa <number+0x12>
40000cc4:	0017f813          	andi	a6,a5,1
40000cc8:	03000e13          	li	t3,48
40000ccc:	fe0804e3          	beqz	a6,40000cb4 <number+0x1c>
40000cd0:	0027f813          	andi	a6,a5,2
40000cd4:	4301                	li	t1,0
40000cd6:	00080963          	beqz	a6,40000ce8 <number+0x50>
40000cda:	0605d163          	bgez	a1,40000d3c <number+0xa4>
40000cde:	40b005b3          	neg	a1,a1
40000ce2:	16fd                	addi	a3,a3,-1
40000ce4:	02d00313          	li	t1,45
40000ce8:	0207f293          	andi	t0,a5,32
40000cec:	00028663          	beqz	t0,40000cf8 <number+0x60>
40000cf0:	4841                	li	a6,16
40000cf2:	07061563          	bne	a2,a6,40000d5c <number+0xc4>
40000cf6:	16f9                	addi	a3,a3,-2
40000cf8:	e5bd                	bnez	a1,40000d66 <number+0xce>
40000cfa:	03000593          	li	a1,48
40000cfe:	00b10623          	sb	a1,12(sp)
40000d02:	4805                	li	a6,1
40000d04:	85c2                	mv	a1,a6
40000d06:	00e85363          	bge	a6,a4,40000d0c <number+0x74>
40000d0a:	85ba                	mv	a1,a4
40000d0c:	8bc5                	andi	a5,a5,17
40000d0e:	8e8d                	sub	a3,a3,a1
40000d10:	cfc1                	beqz	a5,40000da8 <number+0x110>
40000d12:	00030563          	beqz	t1,40000d1c <number+0x84>
40000d16:	00650023          	sb	t1,0(a0)
40000d1a:	0505                	addi	a0,a0,1
40000d1c:	00028a63          	beqz	t0,40000d30 <number+0x98>
40000d20:	47a1                	li	a5,8
40000d22:	08f61963          	bne	a2,a5,40000db4 <number+0x11c>
40000d26:	03000793          	li	a5,48
40000d2a:	00f50023          	sb	a5,0(a0)
40000d2e:	0505                	addi	a0,a0,1
40000d30:	0a0f8e63          	beqz	t6,40000dec <number+0x154>
40000d34:	95aa                	add	a1,a1,a0
40000d36:	03000713          	li	a4,48
40000d3a:	a0c1                	j	40000dfa <number+0x162>
40000d3c:	0047f813          	andi	a6,a5,4
40000d40:	00080663          	beqz	a6,40000d4c <number+0xb4>
40000d44:	16fd                	addi	a3,a3,-1
40000d46:	02b00313          	li	t1,43
40000d4a:	bf79                	j	40000ce8 <number+0x50>
40000d4c:	0087f813          	andi	a6,a5,8
40000d50:	f8080ce3          	beqz	a6,40000ce8 <number+0x50>
40000d54:	16fd                	addi	a3,a3,-1
40000d56:	02000313          	li	t1,32
40000d5a:	b779                	j	40000ce8 <number+0x50>
40000d5c:	4821                	li	a6,8
40000d5e:	f9061de3          	bne	a2,a6,40000cf8 <number+0x60>
40000d62:	16fd                	addi	a3,a3,-1
40000d64:	bf51                	j	40000cf8 <number+0x60>
40000d66:	00c10e93          	addi	t4,sp,12
40000d6a:	4801                	li	a6,0
40000d6c:	02c5ff33          	remu	t5,a1,a2
40000d70:	83ae                	mv	t2,a1
40000d72:	0805                	addi	a6,a6,1
40000d74:	0e85                	addi	t4,t4,1
40000d76:	9f46                	add	t5,t5,a7
40000d78:	000f4f03          	lbu	t5,0(t5)
40000d7c:	02c5d5b3          	divu	a1,a1,a2
40000d80:	ffee8fa3          	sb	t5,-1(t4)
40000d84:	fec3f4e3          	bgeu	t2,a2,40000d6c <number+0xd4>
40000d88:	bfb5                	j	40000d04 <number+0x6c>
40000d8a:	0785                	addi	a5,a5,1
40000d8c:	ffd78fa3          	sb	t4,-1(a5)
40000d90:	40f88733          	sub	a4,a7,a5
40000d94:	fee04be3          	bgtz	a4,40000d8a <number+0xf2>
40000d98:	87b6                	mv	a5,a3
40000d9a:	0006d363          	bgez	a3,40000da0 <number+0x108>
40000d9e:	4781                	li	a5,0
40000da0:	16fd                	addi	a3,a3,-1
40000da2:	953e                	add	a0,a0,a5
40000da4:	8e9d                	sub	a3,a3,a5
40000da6:	b7b5                	j	40000d12 <number+0x7a>
40000da8:	87aa                	mv	a5,a0
40000daa:	00d508b3          	add	a7,a0,a3
40000dae:	02000e93          	li	t4,32
40000db2:	bff9                	j	40000d90 <number+0xf8>
40000db4:	47c1                	li	a5,16
40000db6:	f6f61de3          	bne	a2,a5,40000d30 <number+0x98>
40000dba:	03000793          	li	a5,48
40000dbe:	00f50023          	sb	a5,0(a0)
40000dc2:	07800793          	li	a5,120
40000dc6:	00f500a3          	sb	a5,1(a0)
40000dca:	0509                	addi	a0,a0,2
40000dcc:	b795                	j	40000d30 <number+0x98>
40000dce:	0785                	addi	a5,a5,1
40000dd0:	ffc78fa3          	sb	t3,-1(a5)
40000dd4:	40f60733          	sub	a4,a2,a5
40000dd8:	fee04be3          	bgtz	a4,40000dce <number+0x136>
40000ddc:	87b6                	mv	a5,a3
40000dde:	0006d363          	bgez	a3,40000de4 <number+0x14c>
40000de2:	4781                	li	a5,0
40000de4:	16fd                	addi	a3,a3,-1
40000de6:	953e                	add	a0,a0,a5
40000de8:	8e9d                	sub	a3,a3,a5
40000dea:	b7a9                	j	40000d34 <number+0x9c>
40000dec:	87aa                	mv	a5,a0
40000dee:	00d50633          	add	a2,a0,a3
40000df2:	b7cd                	j	40000dd4 <number+0x13c>
40000df4:	0505                	addi	a0,a0,1
40000df6:	fee50fa3          	sb	a4,-1(a0)
40000dfa:	40a587b3          	sub	a5,a1,a0
40000dfe:	fef84be3          	blt	a6,a5,40000df4 <number+0x15c>
40000e02:	87c2                	mv	a5,a6
40000e04:	872a                	mv	a4,a0
40000e06:	567d                	li	a2,-1
40000e08:	17fd                	addi	a5,a5,-1
40000e0a:	02c79363          	bne	a5,a2,40000e30 <number+0x198>
40000e0e:	982a                	add	a6,a6,a0
40000e10:	8742                	mv	a4,a6
40000e12:	00d805b3          	add	a1,a6,a3
40000e16:	02000513          	li	a0,32
40000e1a:	40e58633          	sub	a2,a1,a4
40000e1e:	02c04163          	bgtz	a2,40000e40 <number+0x1a8>
40000e22:	0006d363          	bgez	a3,40000e28 <number+0x190>
40000e26:	4681                	li	a3,0
40000e28:	00d80533          	add	a0,a6,a3
40000e2c:	6161                	addi	sp,sp,80
40000e2e:	8082                	ret
40000e30:	006c                	addi	a1,sp,12
40000e32:	95be                	add	a1,a1,a5
40000e34:	0005c583          	lbu	a1,0(a1)
40000e38:	0705                	addi	a4,a4,1
40000e3a:	feb70fa3          	sb	a1,-1(a4)
40000e3e:	b7e9                	j	40000e08 <number+0x170>
40000e40:	0705                	addi	a4,a4,1
40000e42:	fea70fa3          	sb	a0,-1(a4)
40000e46:	bfd1                	j	40000e1a <number+0x182>

40000e48 <uart_send_char>:
40000e48:	800007b7          	lui	a5,0x80000
40000e4c:	08a78023          	sb	a0,128(a5) # 80000080 <_etext+0x3fffdf14>
40000e50:	8082                	ret

40000e52 <ee_printf>:
40000e52:	7149                	addi	sp,sp,-368
40000e54:	14912223          	sw	s1,324(sp)
40000e58:	15212023          	sw	s2,320(sp)
40000e5c:	13512a23          	sw	s5,308(sp)
40000e60:	14b12a23          	sw	a1,340(sp)
40000e64:	17012423          	sw	a6,360(sp)
40000e68:	0acc                	addi	a1,sp,340
40000e6a:	02010813          	addi	a6,sp,32
40000e6e:	400024b7          	lui	s1,0x40002
40000e72:	40002ab7          	lui	s5,0x40002
40000e76:	40002937          	lui	s2,0x40002
40000e7a:	14812423          	sw	s0,328(sp)
40000e7e:	13312e23          	sw	s3,316(sp)
40000e82:	14112623          	sw	ra,332(sp)
40000e86:	13412c23          	sw	s4,312(sp)
40000e8a:	13612823          	sw	s6,304(sp)
40000e8e:	13712623          	sw	s7,300(sp)
40000e92:	842a                	mv	s0,a0
40000e94:	14c12c23          	sw	a2,344(sp)
40000e98:	14d12e23          	sw	a3,348(sp)
40000e9c:	16e12023          	sw	a4,352(sp)
40000ea0:	16f12223          	sw	a5,356(sp)
40000ea4:	17112623          	sw	a7,364(sp)
40000ea8:	c22e                	sw	a1,4(sp)
40000eaa:	89c2                	mv	s3,a6
40000eac:	15048493          	addi	s1,s1,336 # 40002150 <errpat+0x580>
40000eb0:	100a8a93          	addi	s5,s5,256 # 40002100 <errpat+0x530>
40000eb4:	12890913          	addi	s2,s2,296 # 40002128 <errpat+0x558>
40000eb8:	00044783          	lbu	a5,0(s0)
40000ebc:	e3a1                	bnez	a5,40000efc <ee_printf+0xaa>
40000ebe:	00080023          	sb	zero,0(a6)
40000ec2:	4501                	li	a0,0
40000ec4:	80000737          	lui	a4,0x80000
40000ec8:	00a987b3          	add	a5,s3,a0
40000ecc:	0007c783          	lbu	a5,0(a5)
40000ed0:	4a079763          	bnez	a5,4000137e <ee_printf+0x52c>
40000ed4:	14c12083          	lw	ra,332(sp)
40000ed8:	14812403          	lw	s0,328(sp)
40000edc:	14412483          	lw	s1,324(sp)
40000ee0:	14012903          	lw	s2,320(sp)
40000ee4:	13c12983          	lw	s3,316(sp)
40000ee8:	13812a03          	lw	s4,312(sp)
40000eec:	13412a83          	lw	s5,308(sp)
40000ef0:	13012b03          	lw	s6,304(sp)
40000ef4:	12c12b83          	lw	s7,300(sp)
40000ef8:	6175                	addi	sp,sp,368
40000efa:	8082                	ret
40000efc:	02500713          	li	a4,37
40000f00:	00e78863          	beq	a5,a4,40000f10 <ee_printf+0xbe>
40000f04:	00180513          	addi	a0,a6,1
40000f08:	00f80023          	sb	a5,0(a6)
40000f0c:	8a2e                	mv	s4,a1
40000f0e:	a42d                	j	40001138 <ee_printf+0x2e6>
40000f10:	4781                	li	a5,0
40000f12:	02b00693          	li	a3,43
40000f16:	02d00513          	li	a0,45
40000f1a:	03000893          	li	a7,48
40000f1e:	02000313          	li	t1,32
40000f22:	02300e13          	li	t3,35
40000f26:	a819                	j	40000f3c <ee_printf+0xea>
40000f28:	00a70763          	beq	a4,a0,40000f36 <ee_printf+0xe4>
40000f2c:	03171463          	bne	a4,a7,40000f54 <ee_printf+0x102>
40000f30:	0017e793          	ori	a5,a5,1
40000f34:	a019                	j	40000f3a <ee_printf+0xe8>
40000f36:	0107e793          	ori	a5,a5,16
40000f3a:	8432                	mv	s0,a2
40000f3c:	00144703          	lbu	a4,1(s0)
40000f40:	00140613          	addi	a2,s0,1
40000f44:	02d70363          	beq	a4,a3,40000f6a <ee_printf+0x118>
40000f48:	fee6e0e3          	bltu	a3,a4,40000f28 <ee_printf+0xd6>
40000f4c:	02670263          	beq	a4,t1,40000f70 <ee_printf+0x11e>
40000f50:	03c70363          	beq	a4,t3,40000f76 <ee_printf+0x124>
40000f54:	fd070693          	addi	a3,a4,-48 # 7fffffd0 <_etext+0x3fffde64>
40000f58:	0ff6f693          	andi	a3,a3,255
40000f5c:	4525                	li	a0,9
40000f5e:	06d56263          	bltu	a0,a3,40000fc2 <ee_printf+0x170>
40000f62:	4681                	li	a3,0
40000f64:	48a5                	li	a7,9
40000f66:	4329                	li	t1,10
40000f68:	a005                	j	40000f88 <ee_printf+0x136>
40000f6a:	0047e793          	ori	a5,a5,4
40000f6e:	b7f1                	j	40000f3a <ee_printf+0xe8>
40000f70:	0087e793          	ori	a5,a5,8
40000f74:	b7d9                	j	40000f3a <ee_printf+0xe8>
40000f76:	0207e793          	ori	a5,a5,32
40000f7a:	b7c1                	j	40000f3a <ee_printf+0xe8>
40000f7c:	026686b3          	mul	a3,a3,t1
40000f80:	0605                	addi	a2,a2,1
40000f82:	96aa                	add	a3,a3,a0
40000f84:	fd068693          	addi	a3,a3,-48 # 3fd0 <__bss_end+0x3fa4>
40000f88:	00064503          	lbu	a0,0(a2) # ffff8000 <_etext+0xbfff5e94>
40000f8c:	fd050713          	addi	a4,a0,-48
40000f90:	0ff77713          	andi	a4,a4,255
40000f94:	fee8f4e3          	bgeu	a7,a4,40000f7c <ee_printf+0x12a>
40000f98:	00064503          	lbu	a0,0(a2)
40000f9c:	02e00713          	li	a4,46
40000fa0:	0ce51e63          	bne	a0,a4,4000107c <ee_printf+0x22a>
40000fa4:	00164503          	lbu	a0,1(a2)
40000fa8:	48a5                	li	a7,9
40000faa:	00160413          	addi	s0,a2,1
40000fae:	fd050713          	addi	a4,a0,-48
40000fb2:	0ff77713          	andi	a4,a4,255
40000fb6:	0ae8e463          	bltu	a7,a4,4000105e <ee_printf+0x20c>
40000fba:	4701                	li	a4,0
40000fbc:	48a5                	li	a7,9
40000fbe:	4329                	li	t1,10
40000fc0:	a03d                	j	40000fee <ee_printf+0x19c>
40000fc2:	02a00513          	li	a0,42
40000fc6:	56fd                	li	a3,-1
40000fc8:	fca718e3          	bne	a4,a0,40000f98 <ee_printf+0x146>
40000fcc:	4194                	lw	a3,0(a1)
40000fce:	00240613          	addi	a2,s0,2
40000fd2:	0591                	addi	a1,a1,4
40000fd4:	fc06d2e3          	bgez	a3,40000f98 <ee_printf+0x146>
40000fd8:	40d006b3          	neg	a3,a3
40000fdc:	0107e793          	ori	a5,a5,16
40000fe0:	bf65                	j	40000f98 <ee_printf+0x146>
40000fe2:	02670733          	mul	a4,a4,t1
40000fe6:	0405                	addi	s0,s0,1
40000fe8:	972a                	add	a4,a4,a0
40000fea:	fd070713          	addi	a4,a4,-48
40000fee:	00044503          	lbu	a0,0(s0)
40000ff2:	fd050613          	addi	a2,a0,-48
40000ff6:	0ff67613          	andi	a2,a2,255
40000ffa:	fec8f4e3          	bgeu	a7,a2,40000fe2 <ee_printf+0x190>
40000ffe:	00044603          	lbu	a2,0(s0)
40001002:	04c00513          	li	a0,76
40001006:	58fd                	li	a7,-1
40001008:	0df67313          	andi	t1,a2,223
4000100c:	00a31463          	bne	t1,a0,40001014 <ee_printf+0x1c2>
40001010:	88b2                	mv	a7,a2
40001012:	0405                	addi	s0,s0,1
40001014:	00044503          	lbu	a0,0(s0)
40001018:	06900613          	li	a2,105
4000101c:	06c50b63          	beq	a0,a2,40001092 <ee_printf+0x240>
40001020:	08a66163          	bltu	a2,a0,400010a2 <ee_printf+0x250>
40001024:	06100613          	li	a2,97
40001028:	18c50d63          	beq	a0,a2,400011c2 <ee_printf+0x370>
4000102c:	04a66b63          	bltu	a2,a0,40001082 <ee_printf+0x230>
40001030:	04100613          	li	a2,65
40001034:	18c50563          	beq	a0,a2,400011be <ee_printf+0x36c>
40001038:	05800613          	li	a2,88
4000103c:	32c50463          	beq	a0,a2,40001364 <ee_printf+0x512>
40001040:	02500793          	li	a5,37
40001044:	00f50563          	beq	a0,a5,4000104e <ee_printf+0x1fc>
40001048:	00f80023          	sb	a5,0(a6)
4000104c:	0805                	addi	a6,a6,1
4000104e:	00044783          	lbu	a5,0(s0)
40001052:	ea0799e3          	bnez	a5,40000f04 <ee_printf+0xb2>
40001056:	147d                	addi	s0,s0,-1
40001058:	8a2e                	mv	s4,a1
4000105a:	8542                	mv	a0,a6
4000105c:	a8f1                	j	40001138 <ee_printf+0x2e6>
4000105e:	02a00893          	li	a7,42
40001062:	4701                	li	a4,0
40001064:	f9151de3          	bne	a0,a7,40000ffe <ee_printf+0x1ac>
40001068:	4198                	lw	a4,0(a1)
4000106a:	00260413          	addi	s0,a2,2
4000106e:	00458613          	addi	a2,a1,4
40001072:	00075363          	bgez	a4,40001078 <ee_printf+0x226>
40001076:	4701                	li	a4,0
40001078:	85b2                	mv	a1,a2
4000107a:	b751                	j	40000ffe <ee_printf+0x1ac>
4000107c:	8432                	mv	s0,a2
4000107e:	577d                	li	a4,-1
40001080:	bfbd                	j	40000ffe <ee_printf+0x1ac>
40001082:	06300613          	li	a2,99
40001086:	06c50363          	beq	a0,a2,400010ec <ee_printf+0x29a>
4000108a:	06400613          	li	a2,100
4000108e:	fac519e3          	bne	a0,a2,40001040 <ee_printf+0x1ee>
40001092:	06c00613          	li	a2,108
40001096:	0027e793          	ori	a5,a5,2
4000109a:	2cc89b63          	bne	a7,a2,40001370 <ee_printf+0x51e>
4000109e:	4629                	li	a2,10
400010a0:	a099                	j	400010e6 <ee_printf+0x294>
400010a2:	07300613          	li	a2,115
400010a6:	0ac50163          	beq	a0,a2,40001148 <ee_printf+0x2f6>
400010aa:	02a66563          	bltu	a2,a0,400010d4 <ee_printf+0x282>
400010ae:	06f00613          	li	a2,111
400010b2:	2ac50d63          	beq	a0,a2,4000136c <ee_printf+0x51a>
400010b6:	07000613          	li	a2,112
400010ba:	f8c513e3          	bne	a0,a2,40001040 <ee_printf+0x1ee>
400010be:	567d                	li	a2,-1
400010c0:	00c69563          	bne	a3,a2,400010ca <ee_printf+0x278>
400010c4:	0017e793          	ori	a5,a5,1
400010c8:	46a1                	li	a3,8
400010ca:	00458a13          	addi	s4,a1,4
400010ce:	4641                	li	a2,16
400010d0:	418c                	lw	a1,0(a1)
400010d2:	a45d                	j	40001378 <ee_printf+0x526>
400010d4:	07500613          	li	a2,117
400010d8:	fcc503e3          	beq	a0,a2,4000109e <ee_printf+0x24c>
400010dc:	07800313          	li	t1,120
400010e0:	4641                	li	a2,16
400010e2:	f4651fe3          	bne	a0,t1,40001040 <ee_printf+0x1ee>
400010e6:	00458a13          	addi	s4,a1,4
400010ea:	b7dd                	j	400010d0 <ee_printf+0x27e>
400010ec:	8bc1                	andi	a5,a5,16
400010ee:	e79d                	bnez	a5,4000111c <ee_printf+0x2ca>
400010f0:	00d80633          	add	a2,a6,a3
400010f4:	02000513          	li	a0,32
400010f8:	a021                	j	40001100 <ee_printf+0x2ae>
400010fa:	fea78fa3          	sb	a0,-1(a5)
400010fe:	883e                	mv	a6,a5
40001100:	00180793          	addi	a5,a6,1
40001104:	40f60733          	sub	a4,a2,a5
40001108:	fee049e3          	bgtz	a4,400010fa <ee_printf+0x2a8>
4000110c:	fff68793          	addi	a5,a3,-1
40001110:	00d04363          	bgtz	a3,40001116 <ee_printf+0x2c4>
40001114:	4685                	li	a3,1
40001116:	40d786b3          	sub	a3,a5,a3
4000111a:	0685                	addi	a3,a3,1
4000111c:	419c                	lw	a5,0(a1)
4000111e:	00458a13          	addi	s4,a1,4
40001122:	00180513          	addi	a0,a6,1
40001126:	00f80023          	sb	a5,0(a6)
4000112a:	96c2                	add	a3,a3,a6
4000112c:	02000713          	li	a4,32
40001130:	40a687b3          	sub	a5,a3,a0
40001134:	00f04663          	bgtz	a5,40001140 <ee_printf+0x2ee>
40001138:	0405                	addi	s0,s0,1
4000113a:	85d2                	mv	a1,s4
4000113c:	882a                	mv	a6,a0
4000113e:	bbad                	j	40000eb8 <ee_printf+0x66>
40001140:	0505                	addi	a0,a0,1
40001142:	fee50fa3          	sb	a4,-1(a0)
40001146:	b7ed                	j	40001130 <ee_printf+0x2de>
40001148:	00458a13          	addi	s4,a1,4
4000114c:	418c                	lw	a1,0(a1)
4000114e:	e191                	bnez	a1,40001152 <ee_printf+0x300>
40001150:	85a6                	mv	a1,s1
40001152:	972e                	add	a4,a4,a1
40001154:	862e                	mv	a2,a1
40001156:	00064503          	lbu	a0,0(a2)
4000115a:	c119                	beqz	a0,40001160 <ee_printf+0x30e>
4000115c:	02e61b63          	bne	a2,a4,40001192 <ee_printf+0x340>
40001160:	8bc1                	andi	a5,a5,16
40001162:	40b60733          	sub	a4,a2,a1
40001166:	02000613          	li	a2,32
4000116a:	cb95                	beqz	a5,4000119e <ee_printf+0x34c>
4000116c:	4781                	li	a5,0
4000116e:	02e7ce63          	blt	a5,a4,400011aa <ee_printf+0x358>
40001172:	853a                	mv	a0,a4
40001174:	00075363          	bgez	a4,4000117a <ee_printf+0x328>
40001178:	4501                	li	a0,0
4000117a:	9542                	add	a0,a0,a6
4000117c:	96aa                	add	a3,a3,a0
4000117e:	02000613          	li	a2,32
40001182:	40a687b3          	sub	a5,a3,a0
40001186:	faf759e3          	bge	a4,a5,40001138 <ee_printf+0x2e6>
4000118a:	0505                	addi	a0,a0,1
4000118c:	fec50fa3          	sb	a2,-1(a0)
40001190:	bfcd                	j	40001182 <ee_printf+0x330>
40001192:	0605                	addi	a2,a2,1
40001194:	b7c9                	j	40001156 <ee_printf+0x304>
40001196:	0805                	addi	a6,a6,1
40001198:	fec80fa3          	sb	a2,-1(a6)
4000119c:	86be                	mv	a3,a5
4000119e:	fff68793          	addi	a5,a3,-1
400011a2:	fed74ae3          	blt	a4,a3,40001196 <ee_printf+0x344>
400011a6:	86be                	mv	a3,a5
400011a8:	b7d1                	j	4000116c <ee_printf+0x31a>
400011aa:	00f58633          	add	a2,a1,a5
400011ae:	00064503          	lbu	a0,0(a2)
400011b2:	00f80633          	add	a2,a6,a5
400011b6:	0785                	addi	a5,a5,1
400011b8:	00a60023          	sb	a0,0(a2)
400011bc:	bf4d                	j	4000116e <ee_printf+0x31c>
400011be:	0407e793          	ori	a5,a5,64
400011c2:	06c00713          	li	a4,108
400011c6:	0005ae03          	lw	t3,0(a1)
400011ca:	00458a13          	addi	s4,a1,4
400011ce:	10e89163          	bne	a7,a4,400012d0 <ee_printf+0x47e>
400011d2:	0407f713          	andi	a4,a5,64
400011d6:	8556                	mv	a0,s5
400011d8:	c311                	beqz	a4,400011dc <ee_printf+0x38a>
400011da:	854a                	mv	a0,s2
400011dc:	0038                	addi	a4,sp,8
400011de:	4581                	li	a1,0
400011e0:	833a                	mv	t1,a4
400011e2:	4e99                	li	t4,6
400011e4:	03a00f13          	li	t5,58
400011e8:	00be0633          	add	a2,t3,a1
400011ec:	00064603          	lbu	a2,0(a2)
400011f0:	0585                	addi	a1,a1,1
400011f2:	070d                	addi	a4,a4,3
400011f4:	00465893          	srli	a7,a2,0x4
400011f8:	8a3d                	andi	a2,a2,15
400011fa:	98aa                	add	a7,a7,a0
400011fc:	962a                	add	a2,a2,a0
400011fe:	0008c883          	lbu	a7,0(a7)
40001202:	00064603          	lbu	a2,0(a2)
40001206:	ff170ea3          	sb	a7,-3(a4)
4000120a:	fec70f23          	sb	a2,-2(a4)
4000120e:	05d59763          	bne	a1,t4,4000125c <ee_printf+0x40a>
40001212:	8bc1                	andi	a5,a5,16
40001214:	eb99                	bnez	a5,4000122a <ee_printf+0x3d8>
40001216:	4645                	li	a2,17
40001218:	02000593          	li	a1,32
4000121c:	fff68793          	addi	a5,a3,-1
40001220:	00180713          	addi	a4,a6,1
40001224:	02d64f63          	blt	a2,a3,40001262 <ee_printf+0x410>
40001228:	86be                	mv	a3,a5
4000122a:	4781                	li	a5,0
4000122c:	4745                	li	a4,17
4000122e:	00f305b3          	add	a1,t1,a5
40001232:	0005c583          	lbu	a1,0(a1)
40001236:	00f80633          	add	a2,a6,a5
4000123a:	0785                	addi	a5,a5,1
4000123c:	00b60023          	sb	a1,0(a2)
40001240:	fee797e3          	bne	a5,a4,4000122e <ee_printf+0x3dc>
40001244:	01180513          	addi	a0,a6,17
40001248:	47c5                	li	a5,17
4000124a:	02000713          	li	a4,32
4000124e:	eed7d5e3          	bge	a5,a3,40001138 <ee_printf+0x2e6>
40001252:	0505                	addi	a0,a0,1
40001254:	fee50fa3          	sb	a4,-1(a0)
40001258:	16fd                	addi	a3,a3,-1
4000125a:	bfd5                	j	4000124e <ee_printf+0x3fc>
4000125c:	ffe70fa3          	sb	t5,-1(a4)
40001260:	b761                	j	400011e8 <ee_printf+0x396>
40001262:	feb70fa3          	sb	a1,-1(a4)
40001266:	86be                	mv	a3,a5
40001268:	883a                	mv	a6,a4
4000126a:	bf4d                	j	4000121c <ee_printf+0x3ca>
4000126c:	1218                	addi	a4,sp,288
4000126e:	00160593          	addi	a1,a2,1
40001272:	963a                	add	a2,a2,a4
40001274:	ef660423          	sb	s6,-280(a2)
40001278:	00ae0733          	add	a4,t3,a0
4000127c:	00074703          	lbu	a4,0(a4)
40001280:	12010313          	addi	t1,sp,288
40001284:	00158613          	addi	a2,a1,1
40001288:	932e                	add	t1,t1,a1
4000128a:	e32d                	bnez	a4,400012ec <ee_printf+0x49a>
4000128c:	ee730423          	sb	t2,-280(t1)
40001290:	0505                	addi	a0,a0,1
40001292:	fde51de3          	bne	a0,t5,4000126c <ee_printf+0x41a>
40001296:	8bc1                	andi	a5,a5,16
40001298:	02000593          	li	a1,32
4000129c:	cfc5                	beqz	a5,40001354 <ee_printf+0x502>
4000129e:	4781                	li	a5,0
400012a0:	002c                	addi	a1,sp,8
400012a2:	95be                	add	a1,a1,a5
400012a4:	0005c583          	lbu	a1,0(a1)
400012a8:	00f80733          	add	a4,a6,a5
400012ac:	0785                	addi	a5,a5,1
400012ae:	00b70023          	sb	a1,0(a4)
400012b2:	fec797e3          	bne	a5,a2,400012a0 <ee_printf+0x44e>
400012b6:	00c80533          	add	a0,a6,a2
400012ba:	96aa                	add	a3,a3,a0
400012bc:	02000713          	li	a4,32
400012c0:	40a687b3          	sub	a5,a3,a0
400012c4:	e6f65ae3          	bge	a2,a5,40001138 <ee_printf+0x2e6>
400012c8:	0505                	addi	a0,a0,1
400012ca:	fee50fa3          	sb	a4,-1(a0)
400012ce:	bfcd                	j	400012c0 <ee_printf+0x46e>
400012d0:	4501                	li	a0,0
400012d2:	4581                	li	a1,0
400012d4:	06300f93          	li	t6,99
400012d8:	42a5                	li	t0,9
400012da:	48a9                	li	a7,10
400012dc:	06400e93          	li	t4,100
400012e0:	03000393          	li	t2,48
400012e4:	4f11                	li	t5,4
400012e6:	02e00b13          	li	s6,46
400012ea:	b779                	j	40001278 <ee_printf+0x426>
400012ec:	04efd363          	bge	t6,a4,40001332 <ee_printf+0x4e0>
400012f0:	03d74bb3          	div	s7,a4,t4
400012f4:	0589                	addi	a1,a1,2
400012f6:	03d76733          	rem	a4,a4,t4
400012fa:	9bd6                	add	s7,s7,s5
400012fc:	000bcb83          	lbu	s7,0(s7)
40001300:	ef730423          	sb	s7,-280(t1)
40001304:	12010313          	addi	t1,sp,288
40001308:	961a                	add	a2,a2,t1
4000130a:	03174333          	div	t1,a4,a7
4000130e:	03176733          	rem	a4,a4,a7
40001312:	9356                	add	t1,t1,s5
40001314:	00034303          	lbu	t1,0(t1)
40001318:	ee660423          	sb	t1,-280(a2)
4000131c:	9756                	add	a4,a4,s5
4000131e:	00074703          	lbu	a4,0(a4)
40001322:	12010313          	addi	t1,sp,288
40001326:	00158613          	addi	a2,a1,1
4000132a:	959a                	add	a1,a1,t1
4000132c:	eee58423          	sb	a4,-280(a1)
40001330:	b785                	j	40001290 <ee_printf+0x43e>
40001332:	fee2d5e3          	bge	t0,a4,4000131c <ee_printf+0x4ca>
40001336:	031745b3          	div	a1,a4,a7
4000133a:	95d6                	add	a1,a1,s5
4000133c:	0005c583          	lbu	a1,0(a1)
40001340:	03176733          	rem	a4,a4,a7
40001344:	eeb30423          	sb	a1,-280(t1)
40001348:	85b2                	mv	a1,a2
4000134a:	bfc9                	j	4000131c <ee_printf+0x4ca>
4000134c:	feb70fa3          	sb	a1,-1(a4)
40001350:	86be                	mv	a3,a5
40001352:	883a                	mv	a6,a4
40001354:	fff68793          	addi	a5,a3,-1
40001358:	00180713          	addi	a4,a6,1
4000135c:	fed648e3          	blt	a2,a3,4000134c <ee_printf+0x4fa>
40001360:	86be                	mv	a3,a5
40001362:	bf35                	j	4000129e <ee_printf+0x44c>
40001364:	0407e793          	ori	a5,a5,64
40001368:	4641                	li	a2,16
4000136a:	bbb5                	j	400010e6 <ee_printf+0x294>
4000136c:	4621                	li	a2,8
4000136e:	bba5                	j	400010e6 <ee_printf+0x294>
40001370:	00458a13          	addi	s4,a1,4
40001374:	418c                	lw	a1,0(a1)
40001376:	4629                	li	a2,10
40001378:	8542                	mv	a0,a6
4000137a:	3a39                	jal	40000c98 <number>
4000137c:	bb75                	j	40001138 <ee_printf+0x2e6>
4000137e:	08f70023          	sb	a5,128(a4)
40001382:	0505                	addi	a0,a0,1
40001384:	b691                	j	40000ec8 <ee_printf+0x76>

40001386 <get_mtimer>:
40001386:	c81027f3          	rdtimeh	a5
4000138a:	c0102573          	rdtime	a0
4000138e:	c81025f3          	rdtimeh	a1
40001392:	fef59ae3          	bne	a1,a5,40001386 <get_mtimer>
40001396:	8082                	ret

40001398 <set_mtimer>:
40001398:	1141                	addi	sp,sp,-16
4000139a:	c422                	sw	s0,8(sp)
4000139c:	c226                	sw	s1,4(sp)
4000139e:	c606                	sw	ra,12(sp)
400013a0:	842a                	mv	s0,a0
400013a2:	84ae                	mv	s1,a1
400013a4:	37cd                	jal	40001386 <get_mtimer>
400013a6:	008507b3          	add	a5,a0,s0
400013aa:	00a7b533          	sltu	a0,a5,a0
400013ae:	95a6                	add	a1,a1,s1
400013b0:	952e                	add	a0,a0,a1
400013b2:	577d                	li	a4,-1
400013b4:	88371073          	csrw	0x883,a4
400013b8:	80379073          	csrw	0x803,a5
400013bc:	88351073          	csrw	0x883,a0
400013c0:	40b2                	lw	ra,12(sp)
400013c2:	4422                	lw	s0,8(sp)
400013c4:	4492                	lw	s1,4(sp)
400013c6:	0141                	addi	sp,sp,16
400013c8:	8082                	ret

400013ca <memcpy>:
400013ca:	4781                	li	a5,0
400013cc:	00c79363          	bne	a5,a2,400013d2 <memcpy+0x8>
400013d0:	8082                	ret
400013d2:	00f58733          	add	a4,a1,a5
400013d6:	00074683          	lbu	a3,0(a4)
400013da:	00f50733          	add	a4,a0,a5
400013de:	0785                	addi	a5,a5,1
400013e0:	00d70023          	sb	a3,0(a4)
400013e4:	b7e5                	j	400013cc <memcpy+0x2>

400013e6 <print_chr>:
400013e6:	800007b7          	lui	a5,0x80000
400013ea:	08a78023          	sb	a0,128(a5) # 80000080 <_etext+0x3fffdf14>
400013ee:	8082                	ret

400013f0 <print_str>:
400013f0:	80000737          	lui	a4,0x80000
400013f4:	00054783          	lbu	a5,0(a0)
400013f8:	e391                	bnez	a5,400013fc <print_str+0xc>
400013fa:	8082                	ret
400013fc:	0505                	addi	a0,a0,1
400013fe:	08f70023          	sb	a5,128(a4) # 80000080 <_etext+0x3fffdf14>
40001402:	bfcd                	j	400013f4 <print_str+0x4>

40001404 <print_dec>:
40001404:	1141                	addi	sp,sp,-16
40001406:	005c                	addi	a5,sp,4
40001408:	86be                	mv	a3,a5
4000140a:	4729                	li	a4,10
4000140c:	e115                	bnez	a0,40001430 <print_dec+0x2c>
4000140e:	02d78163          	beq	a5,a3,40001430 <print_dec+0x2c>
40001412:	80000637          	lui	a2,0x80000
40001416:	17fd                	addi	a5,a5,-1
40001418:	0007c703          	lbu	a4,0(a5)
4000141c:	03070713          	addi	a4,a4,48
40001420:	0ff77713          	andi	a4,a4,255
40001424:	08e60023          	sb	a4,128(a2) # 80000080 <_etext+0x3fffdf14>
40001428:	fed797e3          	bne	a5,a3,40001416 <print_dec+0x12>
4000142c:	0141                	addi	sp,sp,16
4000142e:	8082                	ret
40001430:	02e57633          	remu	a2,a0,a4
40001434:	0785                	addi	a5,a5,1
40001436:	fec78fa3          	sb	a2,-1(a5)
4000143a:	02e55533          	divu	a0,a0,a4
4000143e:	b7f9                	j	4000140c <print_dec+0x8>

40001440 <print_hex>:
40001440:	15fd                	addi	a1,a1,-1
40001442:	40002737          	lui	a4,0x40002
40001446:	058a                	slli	a1,a1,0x2
40001448:	15870713          	addi	a4,a4,344 # 40002158 <errpat+0x588>
4000144c:	800006b7          	lui	a3,0x80000
40001450:	0005d363          	bgez	a1,40001456 <print_hex+0x16>
40001454:	8082                	ret
40001456:	00b557b3          	srl	a5,a0,a1
4000145a:	8bbd                	andi	a5,a5,15
4000145c:	97ba                	add	a5,a5,a4
4000145e:	0007c783          	lbu	a5,0(a5)
40001462:	15f1                	addi	a1,a1,-4
40001464:	08f68023          	sb	a5,128(a3) # 80000080 <_etext+0x3fffdf14>
40001468:	b7e5                	j	40001450 <print_hex+0x10>

4000146a <write_uart0>:
4000146a:	80000737          	lui	a4,0x80000
4000146e:	475c                	lw	a5,12(a4)
40001470:	8b85                	andi	a5,a5,1
40001472:	dff5                	beqz	a5,4000146e <write_uart0+0x4>
40001474:	c348                	sw	a0,4(a4)
40001476:	8082                	ret

40001478 <read_uart0>:
40001478:	80000737          	lui	a4,0x80000
4000147c:	475c                	lw	a5,12(a4)
4000147e:	8b89                	andi	a5,a5,2
40001480:	dff5                	beqz	a5,4000147c <read_uart0+0x4>
40001482:	4308                	lw	a0,0(a4)
40001484:	0ff57513          	andi	a0,a0,255
40001488:	8082                	ret

4000148a <write_uart1>:
4000148a:	80000737          	lui	a4,0x80000
4000148e:	4f5c                	lw	a5,28(a4)
40001490:	8b85                	andi	a5,a5,1
40001492:	dff5                	beqz	a5,4000148e <write_uart1+0x4>
40001494:	cb48                	sw	a0,20(a4)
40001496:	8082                	ret

40001498 <read_uart1>:
40001498:	80000737          	lui	a4,0x80000
4000149c:	4f5c                	lw	a5,28(a4)
4000149e:	8b89                	andi	a5,a5,2
400014a0:	dff5                	beqz	a5,4000149c <read_uart1+0x4>
400014a2:	4b08                	lw	a0,16(a4)
400014a4:	0ff57513          	andi	a0,a0,255
400014a8:	8082                	ret

400014aa <print_str_uart0>:
400014aa:	1141                	addi	sp,sp,-16
400014ac:	c422                	sw	s0,8(sp)
400014ae:	c606                	sw	ra,12(sp)
400014b0:	842a                	mv	s0,a0
400014b2:	00044503          	lbu	a0,0(s0)
400014b6:	e509                	bnez	a0,400014c0 <print_str_uart0+0x16>
400014b8:	40b2                	lw	ra,12(sp)
400014ba:	4422                	lw	s0,8(sp)
400014bc:	0141                	addi	sp,sp,16
400014be:	8082                	ret
400014c0:	0405                	addi	s0,s0,1
400014c2:	3765                	jal	4000146a <write_uart0>
400014c4:	b7fd                	j	400014b2 <print_str_uart0+0x8>

400014c6 <print_str_uart1>:
400014c6:	1141                	addi	sp,sp,-16
400014c8:	c422                	sw	s0,8(sp)
400014ca:	c606                	sw	ra,12(sp)
400014cc:	842a                	mv	s0,a0
400014ce:	00044503          	lbu	a0,0(s0)
400014d2:	e509                	bnez	a0,400014dc <print_str_uart1+0x16>
400014d4:	40b2                	lw	ra,12(sp)
400014d6:	4422                	lw	s0,8(sp)
400014d8:	0141                	addi	sp,sp,16
400014da:	8082                	ret
400014dc:	0405                	addi	s0,s0,1
400014de:	3775                	jal	4000148a <write_uart1>
400014e0:	b7fd                	j	400014ce <print_str_uart1+0x8>

400014e2 <main>:
400014e2:	7159                	addi	sp,sp,-112
400014e4:	d686                	sw	ra,108(sp)
400014e6:	6705                	lui	a4,0x1
400014e8:	d4a2                	sw	s0,104(sp)
400014ea:	d2a6                	sw	s1,100(sp)
400014ec:	d0ca                	sw	s2,96(sp)
400014ee:	cece                	sw	s3,92(sp)
400014f0:	ccd2                	sw	s4,88(sp)
400014f2:	cad6                	sw	s5,84(sp)
400014f4:	c8da                	sw	s6,80(sp)
400014f6:	c6de                	sw	s7,76(sp)
400014f8:	c4e2                	sw	s8,72(sp)
400014fa:	c2e6                	sw	s9,68(sp)
400014fc:	81010113          	addi	sp,sp,-2032
40001500:	0814                	addi	a3,sp,16
40001502:	82070793          	addi	a5,a4,-2016 # 820 <__bss_end+0x7f4>
40001506:	75fd                	lui	a1,0xfffff
40001508:	97b6                	add	a5,a5,a3
4000150a:	7e858613          	addi	a2,a1,2024 # fffff7e8 <_etext+0xbfffd67c>
4000150e:	963e                	add	a2,a2,a5
40001510:	82070793          	addi	a5,a4,-2016
40001514:	97b6                	add	a5,a5,a3
40001516:	7e458593          	addi	a1,a1,2020
4000151a:	95be                	add	a1,a1,a5
4000151c:	05e10513          	addi	a0,sp,94
40001520:	ca02                	sw	zero,20(sp)
40001522:	bceff0ef          	jal	ra,400008f0 <portable_init>
40001526:	4505                	li	a0,1
40001528:	ecaff0ef          	jal	ra,40000bf2 <get_seed_32>
4000152c:	00a11e23          	sh	a0,28(sp)
40001530:	4509                	li	a0,2
40001532:	ec0ff0ef          	jal	ra,40000bf2 <get_seed_32>
40001536:	00a11f23          	sh	a0,30(sp)
4000153a:	450d                	li	a0,3
4000153c:	eb6ff0ef          	jal	ra,40000bf2 <get_seed_32>
40001540:	02a11023          	sh	a0,32(sp)
40001544:	4511                	li	a0,4
40001546:	eacff0ef          	jal	ra,40000bf2 <get_seed_32>
4000154a:	dc2a                	sw	a0,56(sp)
4000154c:	4515                	li	a0,5
4000154e:	ea4ff0ef          	jal	ra,40000bf2 <get_seed_32>
40001552:	38050063          	beqz	a0,400018d2 <main+0x3f0>
40001556:	de2a                	sw	a0,60(sp)
40001558:	6705                	lui	a4,0x1
4000155a:	82070713          	addi	a4,a4,-2016 # 820 <__bss_end+0x7f4>
4000155e:	0814                	addi	a3,sp,16
40001560:	77fd                	lui	a5,0xfffff
40001562:	9736                	add	a4,a4,a3
40001564:	97ba                	add	a5,a5,a4
40001566:	c63e                	sw	a5,12(sp)
40001568:	7ec7a783          	lw	a5,2028(a5) # fffff7ec <_etext+0xbfffd680>
4000156c:	eb91                	bnez	a5,40001580 <main+0x9e>
4000156e:	47b2                	lw	a5,12(sp)
40001570:	7f079783          	lh	a5,2032(a5)
40001574:	e3b1                	bnez	a5,400015b8 <main+0xd6>
40001576:	4732                	lw	a4,12(sp)
40001578:	06600793          	li	a5,102
4000157c:	7ef71823          	sh	a5,2032(a4)
40001580:	6705                	lui	a4,0x1
40001582:	82070713          	addi	a4,a4,-2016 # 820 <__bss_end+0x7f4>
40001586:	0814                	addi	a3,sp,16
40001588:	9736                	add	a4,a4,a3
4000158a:	77fd                	lui	a5,0xfffff
4000158c:	97ba                	add	a5,a5,a4
4000158e:	7ec7a703          	lw	a4,2028(a5) # fffff7ec <_etext+0xbfffd680>
40001592:	c63e                	sw	a5,12(sp)
40001594:	4785                	li	a5,1
40001596:	02f71163          	bne	a4,a5,400015b8 <main+0xd6>
4000159a:	47b2                	lw	a5,12(sp)
4000159c:	7f079783          	lh	a5,2032(a5)
400015a0:	ef81                	bnez	a5,400015b8 <main+0xd6>
400015a2:	4732                	lw	a4,12(sp)
400015a4:	341537b7          	lui	a5,0x34153
400015a8:	41578793          	addi	a5,a5,1045 # 34153415 <__bss_end+0x341533e9>
400015ac:	7ef72623          	sw	a5,2028(a4)
400015b0:	06600793          	li	a5,102
400015b4:	7ef71823          	sh	a5,2032(a4)
400015b8:	6705                	lui	a4,0x1
400015ba:	0814                	addi	a3,sp,16
400015bc:	82070713          	addi	a4,a4,-2016 # 820 <__bss_end+0x7f4>
400015c0:	9736                	add	a4,a4,a3
400015c2:	77fd                	lui	a5,0xfffff
400015c4:	97ba                	add	a5,a5,a4
400015c6:	c63e                	sw	a5,12(sp)
400015c8:	56f2                	lw	a3,60(sp)
400015ca:	4732                	lw	a4,12(sp)
400015cc:	109c                	addi	a5,sp,96
400015ce:	0016f313          	andi	t1,a3,1
400015d2:	7ef72a23          	sw	a5,2036(a4)
400015d6:	04011e23          	sh	zero,92(sp)
400015da:	0026f793          	andi	a5,a3,2
400015de:	851a                	mv	a0,t1
400015e0:	c399                	beqz	a5,400015e6 <main+0x104>
400015e2:	00130513          	addi	a0,t1,1
400015e6:	0046f793          	andi	a5,a3,4
400015ea:	c781                	beqz	a5,400015f2 <main+0x110>
400015ec:	0505                	addi	a0,a0,1
400015ee:	0542                	slli	a0,a0,0x10
400015f0:	8141                	srli	a0,a0,0x10
400015f2:	7d000793          	li	a5,2000
400015f6:	02a7d533          	divu	a0,a5,a0
400015fa:	6485                	lui	s1,0x1
400015fc:	767d                	lui	a2,0xfffff
400015fe:	01010813          	addi	a6,sp,16
40001602:	82048413          	addi	s0,s1,-2016 # 820 <__bss_end+0x7f4>
40001606:	7ec60593          	addi	a1,a2,2028 # fffff7ec <_etext+0xbfffd680>
4000160a:	9442                	add	s0,s0,a6
4000160c:	95a2                	add	a1,a1,s0
4000160e:	82048413          	addi	s0,s1,-2016
40001612:	9442                	add	s0,s0,a6
40001614:	4781                	li	a5,0
40001616:	4701                	li	a4,0
40001618:	4e85                	li	t4,1
4000161a:	9622                	add	a2,a2,s0
4000161c:	4e0d                	li	t3,3
4000161e:	da2a                	sw	a0,52(sp)
40001620:	00fe9833          	sll	a6,t4,a5
40001624:	00d87833          	and	a6,a6,a3
40001628:	00080f63          	beqz	a6,40001646 <main+0x164>
4000162c:	02a70f33          	mul	t5,a4,a0
40001630:	7f462883          	lw	a7,2036(a2)
40001634:	00279813          	slli	a6,a5,0x2
40001638:	0705                	addi	a4,a4,1
4000163a:	982e                	add	a6,a6,a1
4000163c:	0742                	slli	a4,a4,0x10
4000163e:	8341                	srli	a4,a4,0x10
40001640:	98fa                	add	a7,a7,t5
40001642:	01182623          	sw	a7,12(a6)
40001646:	0785                	addi	a5,a5,1
40001648:	fdc79ce3          	bne	a5,t3,40001620 <main+0x13e>
4000164c:	02030163          	beqz	t1,4000166e <main+0x18c>
40001650:	6705                	lui	a4,0x1
40001652:	0814                	addi	a3,sp,16
40001654:	82070713          	addi	a4,a4,-2016 # 820 <__bss_end+0x7f4>
40001658:	9736                	add	a4,a4,a3
4000165a:	77fd                	lui	a5,0xfffff
4000165c:	97ba                	add	a5,a5,a4
4000165e:	7ec79603          	lh	a2,2028(a5) # fffff7ec <_etext+0xbfffd680>
40001662:	7f87a583          	lw	a1,2040(a5)
40001666:	c63e                	sw	a5,12(sp)
40001668:	e37fe0ef          	jal	ra,4000049e <core_list_init>
4000166c:	c0aa                	sw	a0,64(sp)
4000166e:	6705                	lui	a4,0x1
40001670:	82070713          	addi	a4,a4,-2016 # 820 <__bss_end+0x7f4>
40001674:	0814                	addi	a3,sp,16
40001676:	77fd                	lui	a5,0xfffff
40001678:	9736                	add	a4,a4,a3
4000167a:	97ba                	add	a5,a5,a4
4000167c:	c63e                	sw	a5,12(sp)
4000167e:	57f2                	lw	a5,60(sp)
40001680:	8b89                	andi	a5,a5,2
40001682:	cf99                	beqz	a5,400016a0 <main+0x1be>
40001684:	47b2                	lw	a5,12(sp)
40001686:	4732                	lw	a4,12(sp)
40001688:	5552                	lw	a0,52(sp)
4000168a:	7ee79783          	lh	a5,2030(a5) # fffff7ee <_etext+0xbfffd682>
4000168e:	7ec71603          	lh	a2,2028(a4)
40001692:	7fc72583          	lw	a1,2044(a4)
40001696:	07c2                	slli	a5,a5,0x10
40001698:	00d4                	addi	a3,sp,68
4000169a:	8e5d                	or	a2,a2,a5
4000169c:	efbfe0ef          	jal	ra,40000596 <core_init_matrix>
400016a0:	57f2                	lw	a5,60(sp)
400016a2:	777d                	lui	a4,0xfffff
400016a4:	8b91                	andi	a5,a5,4
400016a6:	cf91                	beqz	a5,400016c2 <main+0x1e0>
400016a8:	6785                	lui	a5,0x1
400016aa:	82078793          	addi	a5,a5,-2016 # 820 <__bss_end+0x7f4>
400016ae:	0814                	addi	a3,sp,16
400016b0:	97b6                	add	a5,a5,a3
400016b2:	97ba                	add	a5,a5,a4
400016b4:	5642                	lw	a2,48(sp)
400016b6:	7ec79583          	lh	a1,2028(a5)
400016ba:	5552                	lw	a0,52(sp)
400016bc:	c63e                	sw	a5,12(sp)
400016be:	a58ff0ef          	jal	ra,40000916 <core_init_state>
400016c2:	57e2                	lw	a5,56(sp)
400016c4:	e7a1                	bnez	a5,4000170c <main+0x22a>
400016c6:	4785                	li	a5,1
400016c8:	dc3e                	sw	a5,56(sp)
400016ca:	6785                	lui	a5,0x1
400016cc:	74fd                	lui	s1,0xfffff
400016ce:	82078793          	addi	a5,a5,-2016 # 820 <__bss_end+0x7f4>
400016d2:	0818                	addi	a4,sp,16
400016d4:	7ec48493          	addi	s1,s1,2028 # fffff7ec <_etext+0xbfffd680>
400016d8:	97ba                	add	a5,a5,a4
400016da:	4429                	li	s0,10
400016dc:	94be                	add	s1,s1,a5
400016de:	57e2                	lw	a5,56(sp)
400016e0:	028787b3          	mul	a5,a5,s0
400016e4:	dc3e                	sw	a5,56(sp)
400016e6:	9c0ff0ef          	jal	ra,400008a6 <start_time>
400016ea:	8526                	mv	a0,s1
400016ec:	975fe0ef          	jal	ra,40000060 <iterate>
400016f0:	9d0ff0ef          	jal	ra,400008c0 <stop_time>
400016f4:	9e6ff0ef          	jal	ra,400008da <get_time>
400016f8:	9eeff0ef          	jal	ra,400008e6 <time_in_secs>
400016fc:	d16d                	beqz	a0,400016de <main+0x1fc>
400016fe:	02a45433          	divu	s0,s0,a0
40001702:	5562                	lw	a0,56(sp)
40001704:	0405                	addi	s0,s0,1
40001706:	02a40433          	mul	s0,s0,a0
4000170a:	dc22                	sw	s0,56(sp)
4000170c:	99aff0ef          	jal	ra,400008a6 <start_time>
40001710:	6485                	lui	s1,0x1
40001712:	0818                	addi	a4,sp,16
40001714:	747d                	lui	s0,0xfffff
40001716:	82048793          	addi	a5,s1,-2016 # 820 <__bss_end+0x7f4>
4000171a:	97ba                	add	a5,a5,a4
4000171c:	7ec40513          	addi	a0,s0,2028 # fffff7ec <_etext+0xbfffd680>
40001720:	953e                	add	a0,a0,a5
40001722:	93ffe0ef          	jal	ra,40000060 <iterate>
40001726:	99aff0ef          	jal	ra,400008c0 <stop_time>
4000172a:	9b0ff0ef          	jal	ra,400008da <get_time>
4000172e:	0818                	addi	a4,sp,16
40001730:	82048793          	addi	a5,s1,-2016
40001734:	97ba                	add	a5,a5,a4
40001736:	97a2                	add	a5,a5,s0
40001738:	8b2a                	mv	s6,a0
4000173a:	7ec79503          	lh	a0,2028(a5)
4000173e:	4581                	li	a1,0
40001740:	c63e                	sw	a5,12(sp)
40001742:	d4cff0ef          	jal	ra,40000c8e <crc16>
40001746:	47b2                	lw	a5,12(sp)
40001748:	85aa                	mv	a1,a0
4000174a:	7ee79503          	lh	a0,2030(a5)
4000174e:	d40ff0ef          	jal	ra,40000c8e <crc16>
40001752:	47b2                	lw	a5,12(sp)
40001754:	85aa                	mv	a1,a0
40001756:	7f079503          	lh	a0,2032(a5)
4000175a:	d34ff0ef          	jal	ra,40000c8e <crc16>
4000175e:	85aa                	mv	a1,a0
40001760:	03411503          	lh	a0,52(sp)
40001764:	d2aff0ef          	jal	ra,40000c8e <crc16>
40001768:	67a1                	lui	a5,0x8
4000176a:	b0578793          	addi	a5,a5,-1275 # 7b05 <__bss_end+0x7ad9>
4000176e:	89aa                	mv	s3,a0
40001770:	1cf50163          	beq	a0,a5,40001932 <main+0x450>
40001774:	16a7e263          	bltu	a5,a0,400018d8 <main+0x3f6>
40001778:	6789                	lui	a5,0x2
4000177a:	8f278793          	addi	a5,a5,-1806 # 18f2 <__bss_end+0x18c6>
4000177e:	1cf50a63          	beq	a0,a5,40001952 <main+0x470>
40001782:	6795                	lui	a5,0x5
40001784:	eaf78793          	addi	a5,a5,-337 # 4eaf <__bss_end+0x4e83>
40001788:	1af50d63          	beq	a0,a5,40001942 <main+0x460>
4000178c:	547d                	li	s0,-1
4000178e:	d06ff0ef          	jal	ra,40000c94 <check_data_types>
40001792:	55d2                	lw	a1,52(sp)
40001794:	942a                	add	s0,s0,a0
40001796:	40002537          	lui	a0,0x40002
4000179a:	d7450513          	addi	a0,a0,-652 # 40001d74 <errpat+0x1a4>
4000179e:	eb4ff0ef          	jal	ra,40000e52 <ee_printf>
400017a2:	40002537          	lui	a0,0x40002
400017a6:	85da                	mv	a1,s6
400017a8:	d8c50513          	addi	a0,a0,-628 # 40001d8c <errpat+0x1bc>
400017ac:	ea6ff0ef          	jal	ra,40000e52 <ee_printf>
400017b0:	855a                	mv	a0,s6
400017b2:	934ff0ef          	jal	ra,400008e6 <time_in_secs>
400017b6:	85aa                	mv	a1,a0
400017b8:	40002537          	lui	a0,0x40002
400017bc:	da450513          	addi	a0,a0,-604 # 40001da4 <errpat+0x1d4>
400017c0:	e92ff0ef          	jal	ra,40000e52 <ee_printf>
400017c4:	0442                	slli	s0,s0,0x10
400017c6:	855a                	mv	a0,s6
400017c8:	8041                	srli	s0,s0,0x10
400017ca:	91cff0ef          	jal	ra,400008e6 <time_in_secs>
400017ce:	c10d                	beqz	a0,400017f0 <main+0x30e>
400017d0:	00c02583          	lw	a1,12(zero) # c <default_num_contexts>
400017d4:	54e2                	lw	s1,56(sp)
400017d6:	855a                	mv	a0,s6
400017d8:	02b484b3          	mul	s1,s1,a1
400017dc:	90aff0ef          	jal	ra,400008e6 <time_in_secs>
400017e0:	02a4d5b3          	divu	a1,s1,a0
400017e4:	40002537          	lui	a0,0x40002
400017e8:	dbc50513          	addi	a0,a0,-580 # 40001dbc <errpat+0x1ec>
400017ec:	e66ff0ef          	jal	ra,40000e52 <ee_printf>
400017f0:	855a                	mv	a0,s6
400017f2:	8f4ff0ef          	jal	ra,400008e6 <time_in_secs>
400017f6:	47a5                	li	a5,9
400017f8:	24a7f163          	bgeu	a5,a0,40001a3a <main+0x558>
400017fc:	00c02783          	lw	a5,12(zero) # c <default_num_contexts>
40001800:	55e2                	lw	a1,56(sp)
40001802:	40002537          	lui	a0,0x40002
40001806:	e1450513          	addi	a0,a0,-492 # 40001e14 <errpat+0x244>
4000180a:	02f585b3          	mul	a1,a1,a5
4000180e:	0442                	slli	s0,s0,0x10
40001810:	8441                	srai	s0,s0,0x10
40001812:	e40ff0ef          	jal	ra,40000e52 <ee_printf>
40001816:	400025b7          	lui	a1,0x40002
4000181a:	40002537          	lui	a0,0x40002
4000181e:	e2c58593          	addi	a1,a1,-468 # 40001e2c <errpat+0x25c>
40001822:	e3850513          	addi	a0,a0,-456 # 40001e38 <errpat+0x268>
40001826:	e2cff0ef          	jal	ra,40000e52 <ee_printf>
4000182a:	400025b7          	lui	a1,0x40002
4000182e:	40002537          	lui	a0,0x40002
40001832:	e5058593          	addi	a1,a1,-432 # 40001e50 <errpat+0x280>
40001836:	e7450513          	addi	a0,a0,-396 # 40001e74 <errpat+0x2a4>
4000183a:	e18ff0ef          	jal	ra,40000e52 <ee_printf>
4000183e:	400025b7          	lui	a1,0x40002
40001842:	40002537          	lui	a0,0x40002
40001846:	e8c58593          	addi	a1,a1,-372 # 40001e8c <errpat+0x2bc>
4000184a:	e9450513          	addi	a0,a0,-364 # 40001e94 <errpat+0x2c4>
4000184e:	e04ff0ef          	jal	ra,40000e52 <ee_printf>
40001852:	40002537          	lui	a0,0x40002
40001856:	85ce                	mv	a1,s3
40001858:	eac50513          	addi	a0,a0,-340 # 40001eac <errpat+0x2dc>
4000185c:	df6ff0ef          	jal	ra,40000e52 <ee_printf>
40001860:	57f2                	lw	a5,60(sp)
40001862:	8b85                	andi	a5,a5,1
40001864:	20079663          	bnez	a5,40001a70 <main+0x58e>
40001868:	57f2                	lw	a5,60(sp)
4000186a:	8b89                	andi	a5,a5,2
4000186c:	24079363          	bnez	a5,40001ab2 <main+0x5d0>
40001870:	57f2                	lw	a5,60(sp)
40001872:	8b91                	andi	a5,a5,4
40001874:	28079063          	bnez	a5,40001af4 <main+0x612>
40001878:	6785                	lui	a5,0x1
4000187a:	82078793          	addi	a5,a5,-2016 # 820 <__bss_end+0x7f4>
4000187e:	0818                	addi	a4,sp,16
40001880:	79fd                	lui	s3,0xfffff
40001882:	97ba                	add	a5,a5,a4
40001884:	4481                	li	s1,0
40001886:	99be                	add	s3,s3,a5
40001888:	04400a13          	li	s4,68
4000188c:	6a85                	lui	s5,0x1
4000188e:	40002b37          	lui	s6,0x40002
40001892:	00c02783          	lw	a5,12(zero) # c <default_num_contexts>
40001896:	26f4ed63          	bltu	s1,a5,40001b10 <main+0x62e>
4000189a:	28041a63          	bnez	s0,40001b2e <main+0x64c>
4000189e:	40002537          	lui	a0,0x40002
400018a2:	f3850513          	addi	a0,a0,-200 # 40001f38 <errpat+0x368>
400018a6:	dacff0ef          	jal	ra,40000e52 <ee_printf>
400018aa:	05e10513          	addi	a0,sp,94
400018ae:	862ff0ef          	jal	ra,40000910 <portable_fini>
400018b2:	7f010113          	addi	sp,sp,2032
400018b6:	50b6                	lw	ra,108(sp)
400018b8:	4501                	li	a0,0
400018ba:	5426                	lw	s0,104(sp)
400018bc:	5496                	lw	s1,100(sp)
400018be:	5906                	lw	s2,96(sp)
400018c0:	49f6                	lw	s3,92(sp)
400018c2:	4a66                	lw	s4,88(sp)
400018c4:	4ad6                	lw	s5,84(sp)
400018c6:	4b46                	lw	s6,80(sp)
400018c8:	4bb6                	lw	s7,76(sp)
400018ca:	4c26                	lw	s8,72(sp)
400018cc:	4c96                	lw	s9,68(sp)
400018ce:	6165                	addi	sp,sp,112
400018d0:	8082                	ret
400018d2:	479d                	li	a5,7
400018d4:	de3e                	sw	a5,60(sp)
400018d6:	b149                	j	40001558 <main+0x76>
400018d8:	67a5                	lui	a5,0x9
400018da:	a0278793          	addi	a5,a5,-1534 # 8a02 <__bss_end+0x89d6>
400018de:	00f50f63          	beq	a0,a5,400018fc <main+0x41a>
400018e2:	67bd                	lui	a5,0xf
400018e4:	9f578793          	addi	a5,a5,-1547 # e9f5 <__bss_end+0xe9c9>
400018e8:	eaf512e3          	bne	a0,a5,4000178c <main+0x2aa>
400018ec:	40002537          	lui	a0,0x40002
400018f0:	c8450513          	addi	a0,a0,-892 # 40001c84 <errpat+0xb4>
400018f4:	d5eff0ef          	jal	ra,40000e52 <ee_printf>
400018f8:	478d                	li	a5,3
400018fa:	a801                	j	4000190a <main+0x428>
400018fc:	40002537          	lui	a0,0x40002
40001900:	bf450513          	addi	a0,a0,-1036 # 40001bf4 <errpat+0x24>
40001904:	d4eff0ef          	jal	ra,40000e52 <ee_printf>
40001908:	4781                	li	a5,0
4000190a:	6705                	lui	a4,0x1
4000190c:	82070713          	addi	a4,a4,-2016 # 820 <__bss_end+0x7f4>
40001910:	0814                	addi	a3,sp,16
40001912:	40002a37          	lui	s4,0x40002
40001916:	7bfd                	lui	s7,0xfffff
40001918:	9736                	add	a4,a4,a3
4000191a:	0786                	slli	a5,a5,0x1
4000191c:	b48a0a13          	addi	s4,s4,-1208 # 40001b48 <list_known_crc>
40001920:	4401                	li	s0,0
40001922:	4481                	li	s1,0
40001924:	9bba                	add	s7,s7,a4
40001926:	9a3e                	add	s4,s4,a5
40001928:	40002c37          	lui	s8,0x40002
4000192c:	40002cb7          	lui	s9,0x40002
40001930:	a201                	j	40001a30 <main+0x54e>
40001932:	40002537          	lui	a0,0x40002
40001936:	c2450513          	addi	a0,a0,-988 # 40001c24 <errpat+0x54>
4000193a:	d18ff0ef          	jal	ra,40000e52 <ee_printf>
4000193e:	4785                	li	a5,1
40001940:	b7e9                	j	4000190a <main+0x428>
40001942:	40002537          	lui	a0,0x40002
40001946:	c5050513          	addi	a0,a0,-944 # 40001c50 <errpat+0x80>
4000194a:	d08ff0ef          	jal	ra,40000e52 <ee_printf>
4000194e:	4789                	li	a5,2
40001950:	bf6d                	j	4000190a <main+0x428>
40001952:	40002537          	lui	a0,0x40002
40001956:	cb450513          	addi	a0,a0,-844 # 40001cb4 <errpat+0xe4>
4000195a:	cf8ff0ef          	jal	ra,40000e52 <ee_printf>
4000195e:	4791                	li	a5,4
40001960:	b76d                	j	4000190a <main+0x428>
40001962:	04400a93          	li	s5,68
40001966:	03548ab3          	mul	s5,s1,s5
4000196a:	015b87b3          	add	a5,s7,s5
4000196e:	6a85                	lui	s5,0x1
40001970:	9abe                	add	s5,s5,a5
40001972:	80caa783          	lw	a5,-2036(s5) # 80c <__bss_end+0x7e0>
40001976:	820a9623          	sh	zero,-2004(s5)
4000197a:	8b85                	andi	a5,a5,1
4000197c:	c38d                	beqz	a5,4000199e <main+0x4bc>
4000197e:	826ad603          	lhu	a2,-2010(s5)
40001982:	000a5683          	lhu	a3,0(s4)
40001986:	00d60c63          	beq	a2,a3,4000199e <main+0x4bc>
4000198a:	85a6                	mv	a1,s1
4000198c:	ce0c0513          	addi	a0,s8,-800 # 40001ce0 <errpat+0x110>
40001990:	cc2ff0ef          	jal	ra,40000e52 <ee_printf>
40001994:	82cad783          	lhu	a5,-2004(s5)
40001998:	0785                	addi	a5,a5,1
4000199a:	82fa9623          	sh	a5,-2004(s5)
4000199e:	04400a93          	li	s5,68
400019a2:	03548ab3          	mul	s5,s1,s5
400019a6:	015b87b3          	add	a5,s7,s5
400019aa:	6a85                	lui	s5,0x1
400019ac:	9abe                	add	s5,s5,a5
400019ae:	80caa783          	lw	a5,-2036(s5) # 80c <__bss_end+0x7e0>
400019b2:	8b89                	andi	a5,a5,2
400019b4:	c38d                	beqz	a5,400019d6 <main+0x4f4>
400019b6:	828ad603          	lhu	a2,-2008(s5)
400019ba:	00ca5683          	lhu	a3,12(s4)
400019be:	00d60c63          	beq	a2,a3,400019d6 <main+0x4f4>
400019c2:	85a6                	mv	a1,s1
400019c4:	d10c8513          	addi	a0,s9,-752 # 40001d10 <errpat+0x140>
400019c8:	c8aff0ef          	jal	ra,40000e52 <ee_printf>
400019cc:	82cad783          	lhu	a5,-2004(s5)
400019d0:	0785                	addi	a5,a5,1
400019d2:	82fa9623          	sh	a5,-2004(s5)
400019d6:	04400a93          	li	s5,68
400019da:	03548ab3          	mul	s5,s1,s5
400019de:	015b87b3          	add	a5,s7,s5
400019e2:	6a85                	lui	s5,0x1
400019e4:	9abe                	add	s5,s5,a5
400019e6:	80caa783          	lw	a5,-2036(s5) # 80c <__bss_end+0x7e0>
400019ea:	8b91                	andi	a5,a5,4
400019ec:	c39d                	beqz	a5,40001a12 <main+0x530>
400019ee:	82aad603          	lhu	a2,-2006(s5)
400019f2:	018a5683          	lhu	a3,24(s4)
400019f6:	00d60e63          	beq	a2,a3,40001a12 <main+0x530>
400019fa:	40002537          	lui	a0,0x40002
400019fe:	85a6                	mv	a1,s1
40001a00:	d4450513          	addi	a0,a0,-700 # 40001d44 <errpat+0x174>
40001a04:	c4eff0ef          	jal	ra,40000e52 <ee_printf>
40001a08:	82cad783          	lhu	a5,-2004(s5)
40001a0c:	0785                	addi	a5,a5,1
40001a0e:	82fa9623          	sh	a5,-2004(s5)
40001a12:	04400793          	li	a5,68
40001a16:	02f487b3          	mul	a5,s1,a5
40001a1a:	6705                	lui	a4,0x1
40001a1c:	0485                	addi	s1,s1,1
40001a1e:	04c2                	slli	s1,s1,0x10
40001a20:	80c1                	srli	s1,s1,0x10
40001a22:	97de                	add	a5,a5,s7
40001a24:	97ba                	add	a5,a5,a4
40001a26:	82c7d503          	lhu	a0,-2004(a5)
40001a2a:	942a                	add	s0,s0,a0
40001a2c:	0442                	slli	s0,s0,0x10
40001a2e:	8441                	srai	s0,s0,0x10
40001a30:	00c02783          	lw	a5,12(zero) # c <default_num_contexts>
40001a34:	f2f4e7e3          	bltu	s1,a5,40001962 <main+0x480>
40001a38:	bb99                	j	4000178e <main+0x2ac>
40001a3a:	40002537          	lui	a0,0x40002
40001a3e:	dd450513          	addi	a0,a0,-556 # 40001dd4 <errpat+0x204>
40001a42:	c10ff0ef          	jal	ra,40000e52 <ee_printf>
40001a46:	0405                	addi	s0,s0,1
40001a48:	bb55                	j	400017fc <main+0x31a>
40001a4a:	034487b3          	mul	a5,s1,s4
40001a4e:	85a6                	mv	a1,s1
40001a50:	0485                	addi	s1,s1,1
40001a52:	ec8b0513          	addi	a0,s6,-312 # 40001ec8 <errpat+0x2f8>
40001a56:	04c2                	slli	s1,s1,0x10
40001a58:	80c1                	srli	s1,s1,0x10
40001a5a:	97ce                	add	a5,a5,s3
40001a5c:	97d6                	add	a5,a5,s5
40001a5e:	8267d603          	lhu	a2,-2010(a5)
40001a62:	bf0ff0ef          	jal	ra,40000e52 <ee_printf>
40001a66:	00c02783          	lw	a5,12(zero) # c <default_num_contexts>
40001a6a:	fef4e0e3          	bltu	s1,a5,40001a4a <main+0x568>
40001a6e:	bbed                	j	40001868 <main+0x386>
40001a70:	6785                	lui	a5,0x1
40001a72:	82078793          	addi	a5,a5,-2016 # 820 <__bss_end+0x7f4>
40001a76:	0818                	addi	a4,sp,16
40001a78:	79fd                	lui	s3,0xfffff
40001a7a:	97ba                	add	a5,a5,a4
40001a7c:	4481                	li	s1,0
40001a7e:	99be                	add	s3,s3,a5
40001a80:	04400a13          	li	s4,68
40001a84:	6a85                	lui	s5,0x1
40001a86:	40002b37          	lui	s6,0x40002
40001a8a:	bff1                	j	40001a66 <main+0x584>
40001a8c:	034487b3          	mul	a5,s1,s4
40001a90:	85a6                	mv	a1,s1
40001a92:	0485                	addi	s1,s1,1
40001a94:	ee4b0513          	addi	a0,s6,-284 # 40001ee4 <errpat+0x314>
40001a98:	04c2                	slli	s1,s1,0x10
40001a9a:	80c1                	srli	s1,s1,0x10
40001a9c:	97ce                	add	a5,a5,s3
40001a9e:	97d6                	add	a5,a5,s5
40001aa0:	8287d603          	lhu	a2,-2008(a5)
40001aa4:	baeff0ef          	jal	ra,40000e52 <ee_printf>
40001aa8:	00c02783          	lw	a5,12(zero) # c <default_num_contexts>
40001aac:	fef4e0e3          	bltu	s1,a5,40001a8c <main+0x5aa>
40001ab0:	b3c1                	j	40001870 <main+0x38e>
40001ab2:	6785                	lui	a5,0x1
40001ab4:	82078793          	addi	a5,a5,-2016 # 820 <__bss_end+0x7f4>
40001ab8:	0818                	addi	a4,sp,16
40001aba:	79fd                	lui	s3,0xfffff
40001abc:	97ba                	add	a5,a5,a4
40001abe:	4481                	li	s1,0
40001ac0:	99be                	add	s3,s3,a5
40001ac2:	04400a13          	li	s4,68
40001ac6:	6a85                	lui	s5,0x1
40001ac8:	40002b37          	lui	s6,0x40002
40001acc:	bff1                	j	40001aa8 <main+0x5c6>
40001ace:	034487b3          	mul	a5,s1,s4
40001ad2:	85a6                	mv	a1,s1
40001ad4:	0485                	addi	s1,s1,1
40001ad6:	f00b0513          	addi	a0,s6,-256 # 40001f00 <errpat+0x330>
40001ada:	04c2                	slli	s1,s1,0x10
40001adc:	80c1                	srli	s1,s1,0x10
40001ade:	97ce                	add	a5,a5,s3
40001ae0:	97d6                	add	a5,a5,s5
40001ae2:	82a7d603          	lhu	a2,-2006(a5)
40001ae6:	b6cff0ef          	jal	ra,40000e52 <ee_printf>
40001aea:	00c02783          	lw	a5,12(zero) # c <default_num_contexts>
40001aee:	fef4e0e3          	bltu	s1,a5,40001ace <main+0x5ec>
40001af2:	b359                	j	40001878 <main+0x396>
40001af4:	6785                	lui	a5,0x1
40001af6:	82078793          	addi	a5,a5,-2016 # 820 <__bss_end+0x7f4>
40001afa:	0818                	addi	a4,sp,16
40001afc:	79fd                	lui	s3,0xfffff
40001afe:	97ba                	add	a5,a5,a4
40001b00:	4481                	li	s1,0
40001b02:	99be                	add	s3,s3,a5
40001b04:	04400a13          	li	s4,68
40001b08:	6a85                	lui	s5,0x1
40001b0a:	40002b37          	lui	s6,0x40002
40001b0e:	bff1                	j	40001aea <main+0x608>
40001b10:	034487b3          	mul	a5,s1,s4
40001b14:	85a6                	mv	a1,s1
40001b16:	0485                	addi	s1,s1,1
40001b18:	f1cb0513          	addi	a0,s6,-228 # 40001f1c <errpat+0x34c>
40001b1c:	04c2                	slli	s1,s1,0x10
40001b1e:	80c1                	srli	s1,s1,0x10
40001b20:	97ce                	add	a5,a5,s3
40001b22:	97d6                	add	a5,a5,s5
40001b24:	8247d603          	lhu	a2,-2012(a5)
40001b28:	b2aff0ef          	jal	ra,40000e52 <ee_printf>
40001b2c:	b39d                	j	40001892 <main+0x3b0>
40001b2e:	00805763          	blez	s0,40001b3c <main+0x65a>
40001b32:	40002537          	lui	a0,0x40002
40001b36:	f8450513          	addi	a0,a0,-124 # 40001f84 <errpat+0x3b4>
40001b3a:	b3b5                	j	400018a6 <main+0x3c4>
40001b3c:	40002537          	lui	a0,0x40002
40001b40:	f9850513          	addi	a0,a0,-104 # 40001f98 <errpat+0x3c8>
40001b44:	b38d                	j	400018a6 <main+0x3c4>
	...

40001b48 <list_known_crc>:
40001b48:	d4b0 3340 6a79 e714 e3c1 0000               ..@3yj......

40001b54 <matrix_known_crc>:
40001b54:	be52 1199 5608 1fd7 0747 0000               R....V..G...

40001b60 <state_known_crc>:
40001b60:	5e47 39bf e5a4 8e3a 8d84 0000 0970 4000     G^.9..:.....p..@
40001b70:	0970 4000 0976 4000 0976 4000 097a 4000     p..@v..@v..@z..@
40001b80:	0a20 4000 09fa 4000 0a52 4000 0abe 4000      ..@...@R..@...@
40001b90:	0a78 4000 0a98 4000 0ad2 4000 0ae8 4000     x..@...@...@...@

40001ba0 <intpat>:
40001ba0:	20e0 4000 20e8 4000 20f0 4000 20f8 4000     . .@. .@. .@. .@

40001bb0 <floatpat>:
40001bb0:	20b0 4000 20bc 4000 20c8 4000 20d4 4000     . .@. .@. .@. .@

40001bc0 <scipat>:
40001bc0:	2080 4000 208c 4000 2098 4000 20a4 4000     . .@. .@. .@. .@

40001bd0 <errpat>:
40001bd0:	2050 4000 205c 4000 2068 4000 2074 4000     P .@\ .@h .@t .@
40001be0:	0c0a 4000 0c10 4000 0c16 4000 0c1c 4000     ...@...@...@...@
40001bf0:	0c22 4000 6b36 7020 7265 6f66 6d72 6e61     "..@6k performan
40001c00:	6563 7220 6e75 7020 7261 6d61 7465 7265     ce run parameter
40001c10:	2073 6f66 2072 6f63 6572 616d 6b72 0a2e     s for coremark..
40001c20:	0000 0000 6b36 7620 6c61 6469 7461 6f69     ....6k validatio
40001c30:	206e 7572 206e 6170 6172 656d 6574 7372     n run parameters
40001c40:	6620 726f 6320 726f 6d65 7261 2e6b 000a      for coremark...
40001c50:	7250 666f 6c69 2065 6567 656e 6172 6974     Profile generati
40001c60:	6e6f 7220 6e75 7020 7261 6d61 7465 7265     on run parameter
40001c70:	2073 6f66 2072 6f63 6572 616d 6b72 0a2e     s for coremark..
40001c80:	0000 0000 4b32 7020 7265 6f66 6d72 6e61     ....2K performan
40001c90:	6563 7220 6e75 7020 7261 6d61 7465 7265     ce run parameter
40001ca0:	2073 6f66 2072 6f63 6572 616d 6b72 0a2e     s for coremark..
40001cb0:	0000 0000 4b32 7620 6c61 6469 7461 6f69     ....2K validatio
40001cc0:	206e 7572 206e 6170 6172 656d 6574 7372     n run parameters
40001cd0:	6620 726f 6320 726f 6d65 7261 2e6b 000a      for coremark...
40001ce0:	255b 5d75 5245 4f52 2152 6c20 7369 2074     [%u]ERROR! list 
40001cf0:	7263 2063 7830 3025 7834 2d20 7320 6f68     crc 0x%04x - sho
40001d00:	6c75 2064 6562 3020 2578 3430 0a78 0000     uld be 0x%04x...
40001d10:	255b 5d75 5245 4f52 2152 6d20 7461 6972     [%u]ERROR! matri
40001d20:	2078 7263 2063 7830 3025 7834 2d20 7320     x crc 0x%04x - s
40001d30:	6f68 6c75 2064 6562 3020 2578 3430 0a78     hould be 0x%04x.
40001d40:	0000 0000 255b 5d75 5245 4f52 2152 7320     ....[%u]ERROR! s
40001d50:	6174 6574 6320 6372 3020 2578 3430 2078     tate crc 0x%04x 
40001d60:	202d 6873 756f 646c 6220 2065 7830 3025     - should be 0x%0
40001d70:	7834 000a 6f43 6572 614d 6b72 5320 7a69     4x..CoreMark Siz
40001d80:	2065 2020 3a20 2520 756c 000a 6f54 6174     e    : %lu..Tota
40001d90:	206c 6974 6b63 2073 2020 2020 3a20 2520     l ticks      : %
40001da0:	756c 000a 6f54 6174 206c 6974 656d 2820     lu..Total time (
40001db0:	6573 7363 3a29 2520 0a64 0000 7449 7265     secs): %d...Iter
40001dc0:	7461 6f69 736e 532f 6365 2020 3a20 2520     ations/Sec   : %
40001dd0:	0a64 0000 5245 4f52 2152 4d20 7375 2074     d...ERROR! Must 
40001de0:	7865 6365 7475 2065 6f66 2072 7461 6c20     execute for at l
40001df0:	6165 7473 3120 2030 6573 7363 6620 726f     east 10 secs for
40001e00:	6120 7620 6c61 6469 7220 7365 6c75 2174      a valid result!
40001e10:	000a 0000 7449 7265 7461 6f69 736e 2020     ....Iterations  
40001e20:	2020 2020 3a20 2520 756c 000a 4347 3843          : %lu..GCC8
40001e30:	322e 302e 0000 0000 6f43 706d 6c69 7265     .2.0....Compiler
40001e40:	7620 7265 6973 6e6f 3a20 2520 0a73 0000      version : %s...
40001e50:	4d2d 2044 4f2d 2073 6d2d 6261 3d69 6c69     -MD -Os -mabi=il
40001e60:	3370 2032 6d2d 7261 6863 723d 3376 6932     p32 -march=rv32i
40001e70:	636d 0000 6f43 706d 6c69 7265 6620 616c     mc..Compiler fla
40001e80:	7367 2020 3a20 2520 0a73 0000 5453 4341     gs   : %s...STAC
40001e90:	004b 0000 654d 6f6d 7972 6c20 636f 7461     K...Memory locat
40001ea0:	6f69 206e 3a20 2520 0a73 0000 6573 6465     ion  : %s...seed
40001eb0:	7263 2063 2020 2020 2020 2020 3a20 3020     crc          : 0
40001ec0:	2578 3430 0a78 0000 255b 5d64 7263 6c63     x%04x...[%d]crcl
40001ed0:	7369 2074 2020 2020 2020 203a 7830 3025     ist       : 0x%0
40001ee0:	7834 000a 255b 5d64 7263 6d63 7461 6972     4x..[%d]crcmatri
40001ef0:	2078 2020 2020 203a 7830 3025 7834 000a     x     : 0x%04x..
40001f00:	255b 5d64 7263 7363 6174 6574 2020 2020     [%d]crcstate    
40001f10:	2020 203a 7830 3025 7834 000a 255b 5d64       : 0x%04x..[%d]
40001f20:	7263 6663 6e69 6c61 2020 2020 2020 203a     crcfinal      : 
40001f30:	7830 3025 7834 000a 6f43 7272 6365 2074     0x%04x..Correct 
40001f40:	706f 7265 7461 6f69 206e 6176 696c 6164     operation valida
40001f50:	6574 2e64 5320 6565 5220 4145 4d44 2e45     ted. See README.
40001f60:	646d 6620 726f 7220 6e75 6120 646e 7220     md for run and r
40001f70:	7065 726f 6974 676e 7220 6c75 7365 0a2e     eporting rules..
40001f80:	0000 0000 7245 6f72 7372 6420 7465 6365     ....Errors detec
40001f90:	6574 0a64 0000 0000 6143 6e6e 746f 7620     ted.....Cannot v
40001fa0:	6c61 6469 7461 2065 706f 7265 7461 6f69     alidate operatio
40001fb0:	206e 6f66 2072 6874 7365 2065 6573 6465     n for these seed
40001fc0:	7620 6c61 6575 2c73 7020 656c 7361 2065      values, please 
40001fd0:	6f63 706d 7261 2065 6977 6874 7220 7365     compare with res
40001fe0:	6c75 7374 6f20 206e 2061 6e6b 776f 206e     ults on a known 
40001ff0:	6c70 7461 6f66 6d72 0a2e 0000 7453 7461     platform....Stat
40002000:	6369 0000 6548 7061 0000 0000 7453 6361     ic..Heap....Stac
40002010:	006b 0000 7453 7261 2074 6974 656d 2520     k...Start time %
40002020:	646c 000a 7473 706f 7420 6d69 2065 6c25     ld..stop time %l
40002030:	0a64 0000 7453 7261 6974 676e 4320 524f     d...Starting COR
40002040:	4d45 5241 204b 2e31 2e30 2e2e 000a 0000     EMARK 1.0.......
40002050:	3054 332e 2d65 4631 0000 0000 542d 542e     T0.3e-1F....-T.T
40002060:	2b2b 7154 0000 0000 5431 2e33 6534 7a34     ++Tq....1T3.4e4z
40002070:	0000 0000 3433 302e 2d65 5e54 0000 0000     ....34.0e-T^....
40002080:	2e35 3035 6530 332b 0000 0000 2e2d 3231     5.500e+3....-.12
40002090:	6533 322d 0000 0000 382d 6537 382b 3233     3e-2....-87e+832
400020a0:	0000 0000 302b 362e 2d65 3231 0000 0000     ....+0.6e-12....
400020b0:	3533 352e 3434 3030 0000 0000 312e 3332     35.54400.....123
400020c0:	3534 3030 0000 0000 312d 3031 372e 3030     4500....-110.700
400020d0:	0000 0000 302b 362e 3434 3030 0000 0000     ....+0.64400....
400020e0:	3035 3231 0000 0000 3231 3433 0000 0000     5012....1234....
400020f0:	382d 3437 0000 0000 312b 3232 0000 0000     -874....+122....
40002100:	3130 3332 3534 3736 3938 6261 6463 6665     0123456789abcdef
40002110:	6867 6a69 6c6b 6e6d 706f 7271 7473 7675     ghijklmnopqrstuv
40002120:	7877 7a79 0000 0000 3130 3332 3534 3736     wxyz....01234567
40002130:	3938 4241 4443 4645 4847 4a49 4c4b 4e4d     89ABCDEFGHIJKLMN
40002140:	504f 5251 5453 5655 5857 5a59 0000 0000     OPQRSTUVWXYZ....
40002150:	4e3c 4c55 3e4c 0000 3130 3332 3534 3736     <NULL>..01234567
40002160:	3938 4241 4443 4645 0000 0000               89ABCDEF....
