cmd_rte_bitrate.o = gcc -Wp,-MD,./.rte_bitrate.o.d.tmp  -m64 -pthread  -march=native -DRTE_MACHINE_CPUFLAG_SSE -DRTE_MACHINE_CPUFLAG_SSE2 -DRTE_MACHINE_CPUFLAG_SSE3 -DRTE_MACHINE_CPUFLAG_SSSE3 -DRTE_MACHINE_CPUFLAG_SSE4_1 -DRTE_MACHINE_CPUFLAG_SSE4_2 -DRTE_MACHINE_CPUFLAG_AES -DRTE_MACHINE_CPUFLAG_PCLMULQDQ -DRTE_MACHINE_CPUFLAG_AVX -DRTE_MACHINE_CPUFLAG_RDRAND -DRTE_MACHINE_CPUFLAG_FSGSBASE -DRTE_MACHINE_CPUFLAG_F16C -DRTE_MACHINE_CPUFLAG_AVX2  -I/users/lars/MoonGen/MoonGen/libmoon/deps/dpdk/x86_64-native-linuxapp-gcc/include -include /users/lars/MoonGen/MoonGen/libmoon/deps/dpdk/x86_64-native-linuxapp-gcc/include/rte_config.h -W -Wall -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wold-style-definition -Wpointer-arith -Wcast-align -Wnested-externs -Wcast-qual -Wformat-nonliteral -Wformat-security -Wundef -Wwrite-strings -I/users/lars/MoonGen/MoonGen/libmoon/deps/dpdk/lib/librte_bitratestats -O3    -o rte_bitrate.o -c /users/lars/MoonGen/MoonGen/libmoon/deps/dpdk/lib/librte_bitratestats/rte_bitrate.c 
