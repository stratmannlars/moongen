cmd_i40e_pf.o = gcc -Wp,-MD,./.i40e_pf.o.d.tmp  -m64 -pthread  -march=native -DRTE_MACHINE_CPUFLAG_SSE -DRTE_MACHINE_CPUFLAG_SSE2 -DRTE_MACHINE_CPUFLAG_SSE3 -DRTE_MACHINE_CPUFLAG_SSSE3 -DRTE_MACHINE_CPUFLAG_SSE4_1 -DRTE_MACHINE_CPUFLAG_SSE4_2 -DRTE_MACHINE_CPUFLAG_AES -DRTE_MACHINE_CPUFLAG_PCLMULQDQ -DRTE_MACHINE_CPUFLAG_AVX -DRTE_MACHINE_CPUFLAG_RDRAND -DRTE_MACHINE_CPUFLAG_FSGSBASE -DRTE_MACHINE_CPUFLAG_F16C -DRTE_MACHINE_CPUFLAG_AVX2  -I/users/lars/MoonGen/MoonGen/libmoon/deps/dpdk/x86_64-native-linuxapp-gcc/include -include /users/lars/MoonGen/MoonGen/libmoon/deps/dpdk/x86_64-native-linuxapp-gcc/include/rte_config.h -O3 -W -Wall -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wold-style-definition -Wpointer-arith -Wcast-align -Wnested-externs -Wcast-qual -Wformat-nonliteral -Wformat-security -Wundef -Wwrite-strings -DPF_DRIVER -DVF_DRIVER -DINTEGRATED_VF -DX722_A0_SUPPORT    -o i40e_pf.o -c /users/lars/MoonGen/MoonGen/libmoon/deps/dpdk/drivers/net/i40e/i40e_pf.c 
