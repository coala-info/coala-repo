# vdjer CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| vdjer | Failed | image problem: vdjer segfaults (exit 139) right after printing its parameters, on the repository demo BAM with the official IGH reference |

## vdjer

### Tool Description
vdjer

### Metadata
- **Docker Image**: quay.io/biocontainers/vdjer:0.12--h5ca1c30_8
- **Homepage**: https://github.com/mozack/vdjer
- **Package**: https://anaconda.org/channels/bioconda/packages/vdjer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vdjer/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mozack/vdjer
- **Stars**: N/A
### Original Help Text
```text
ELAPSED_SECS	START	0	0
PROC_STATUS	START	Name:	vdjer
PROC_STATUS	START	Umask:	0022
PROC_STATUS	START	State:	R (running)
PROC_STATUS	START	Tgid:	1
PROC_STATUS	START	Ngid:	0
PROC_STATUS	START	Pid:	1
PROC_STATUS	START	PPid:	0
PROC_STATUS	START	TracerPid:	0
PROC_STATUS	START	Uid:	0	0	0	0
PROC_STATUS	START	Gid:	0	0	0	0
PROC_STATUS	START	FDSize:	256
PROC_STATUS	START	Groups:	0 
PROC_STATUS	START	NStgid:	1
PROC_STATUS	START	NSpid:	1
PROC_STATUS	START	NSpgid:	1
PROC_STATUS	START	NSsid:	1
PROC_STATUS	START	Kthread:	0
PROC_STATUS	START	VmPeak:	    8296 kB
PROC_STATUS	START	VmSize:	    8296 kB
PROC_STATUS	START	VmLck:	       0 kB
PROC_STATUS	START	VmPin:	       0 kB
PROC_STATUS	START	VmHWM:	    3764 kB
PROC_STATUS	START	VmRSS:	    3764 kB
PROC_STATUS	START	RssAnon:	     328 kB
PROC_STATUS	START	RssFile:	    3436 kB
PROC_STATUS	START	RssShmem:	       0 kB
PROC_STATUS	START	VmData:	    2396 kB
PROC_STATUS	START	VmStk:	     132 kB
PROC_STATUS	START	VmExe:	     404 kB
PROC_STATUS	START	VmLib:	    2776 kB
PROC_STATUS	START	VmPTE:	      64 kB
PROC_STATUS	START	VmSwap:	       0 kB
PROC_STATUS	START	HugetlbPages:	       0 kB
PROC_STATUS	START	CoreDumping:	0
PROC_STATUS	START	THP_enabled:	1
PROC_STATUS	START	untag_mask:	0xffffffffffffffff
PROC_STATUS	START	Threads:	1
PROC_STATUS	START	SigQ:	6/255605
PROC_STATUS	START	SigPnd:	0000000000000000
PROC_STATUS	START	ShdPnd:	0000000000000000
PROC_STATUS	START	SigBlk:	0000000000000000
PROC_STATUS	START	SigIgn:	0000000000000000
PROC_STATUS	START	SigCgt:	0000000000000000
PROC_STATUS	START	CapInh:	0000000000000000
PROC_STATUS	START	CapPrm:	00000000a80425fb
PROC_STATUS	START	CapEff:	00000000a80425fb
PROC_STATUS	START	CapBnd:	00000000a80425fb
PROC_STATUS	START	CapAmb:	0000000000000000
PROC_STATUS	START	NoNewPrivs:	0
PROC_STATUS	START	Seccomp:	2
PROC_STATUS	START	Seccomp_filters:	1
PROC_STATUS	START	Speculation_Store_Bypass:	thread vulnerable
PROC_STATUS	START	SpeculationIndirectBranch:	conditional enabled
PROC_STATUS	START	Cpus_allowed:	fffff
PROC_STATUS	START	Cpus_allowed_list:	0-19
PROC_STATUS	START	Mems_allowed:	00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
PROC_STATUS	START	Mems_allowed_list:	0
PROC_STATUS	START	voluntary_ctxt_switches:	18
PROC_STATUS	START	nonvoluntary_ctxt_switches:	6
PROC_STATUS	START	x86_Thread_features:	
PROC_STATUS	START	x86_Thread_features_locked:	
BUDDY_INFO	START	Node 0, zone      DMA      0      0      0      0      0      0      0      0      1      1      2 
BUDDY_INFO	START	Node 0, zone    DMA32   1054    859    549   1421    815    476    204    107     62      5      3 
BUDDY_INFO	START	Node 0, zone   Normal 421101 123897  60488  39231  15085   8532   6550   3995   1301    605    534 
STAT:1771997968	START	1 (vdjer) R 0 1 1 0 -1 4194560 1321 0 0 0 1 0 0 0 20 0 1 0 3062805 8495104 920 18446744073709551615 99435866427392 99435866839357 140730863939264 0 0 0 0 0 0 0 0 0 17 3 0 0 0 0 0 99435867047784 99435867050040 99436689129472 140730863943414 140730863943420 140730863943420 140730863943651 0
Input BAM must be specified
V anchor file must be specified
J anchor file must be specified
VDJ fasta file must be specified
source_sim_file file must be specified
Conserved J AA must be W or F: 
V region coordinates must be specified
C region coordinates must be specified
insert_len must be specified and > 0
vdjer 
	--in <input_bam>
	--chain <IGH|IGK|IGL>
	--ref-dir </path/to/vdjer/ref/dir>
	--mf <min node frequency (default: 3)>
	--mq <min base quality (default: 90)>
	--mcs <min contig score (default: -5)
	--t <threads (default: 1)
	--am <anchor mismatches (default: 4)
	--miw <min window length between conserved amino acids>
	--maw <max window length between conserved amino acids>
	--jc <conserved J amino acid (W|F)
	--ws <window span (default: 486)
	--jext <J extension (default: 162)
	--vr <V region locus (chr:start-stop)>
	--cr <C region locus>
	--ins <expected / median insert length>
	--rf <read filter floor (default: 1)
	--k <kmer size (default: 35)>
	--vk <vregion kmer size (default: 15)>
	--mrs <min source node homology score (default: 30)
	--rs <read span distance (default: 35)>
	--ms <mate span distance (default: 48)>
	--e0 <start position for contig filtering (default: 52)>
	--e1 <stop position for contig filtering (default: 411)>
	--wo <window overlap check size>
```

