# art CWL Generation Report

## art

### Tool Description
FAIL to generate CWL: art not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/art/overview
- **Total Downloads**: 108.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jlevy/the-art-of-command-line
- **Stars**: 159986
### Generation Failed

FAIL to generate CWL: art not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: art not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## art_man

### Tool Description
Display manual page

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: man [-aw] [SECTION] MANPAGE[.SECTION]...

Display manual page

	-a	Display all pages
	-w	Show page locations

$COLUMNS overrides output width
```

## art_less

### Tool Description
Simulation of Illumina next-generation sequencing reads

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
====================ART====================
             ART_Illumina (2008-2016)          
          Q Version 2.5.8 (June 6, 2016)       
     Contact: Weichun Huang <whduke@gmail.com> 
    -------------------------------------------

===== USAGE =====

art_illumina [options] -ss <sequencing_system> -sam -i <seq_ref_file> -l <read_length> -f <fold_coverage> -o <outfile_prefix>
art_illumina [options] -ss <sequencing_system> -sam -i <seq_ref_file> -l <read_length> -c <num_reads_per_sequence> -o <outfile_prefix>
art_illumina [options] -ss <sequencing_system> -sam -i <seq_ref_file> -l <read_length> -f <fold_coverage> -m <mean_fragsize> -s <std_fragsize> -o <outfile_prefix>
art_illumina [options] -ss <sequencing_system> -sam -i <seq_ref_file> -l <read_length> -c <num_reads_per_sequence> -m <mean_fragsize> -s <std_fragsize> -o <outfile_prefix>

===== PARAMETERS =====

  -1   --qprof1   the first-read quality profile
  -2   --qprof2   the second-read quality profile
  -amp --amplicon amplicon sequencing simulation
  -c   --rcount   number of reads/read pairs to be generated per sequence/amplicon (not be used together with -f/--fcov)
  -d   --id       the prefix identification tag for read ID
  -ef  --errfree  indicate to generate the zero sequencing errors SAM file as well the regular one
                  NOTE: the reads in the zero-error SAM file have the same alignment positions
                  as those in the regular SAM file, but have no sequencing errors
  -f   --fcov     the fold of read coverage to be simulated or number of reads/read pairs generated for each amplicon
  -h   --help     print out usage information
  -i   --in       the filename of input DNA/RNA reference
  -ir  --insRate  the first-read insertion rate (default: 0.00009)
  -ir2 --insRate2 the second-read insertion rate (default: 0.00015)
  -dr  --delRate  the first-read deletion rate (default:  0.00011)
  -dr2 --delRate2 the second-read deletion rate (default: 0.00023)
  -k   --maxIndel the maximum total number of insertion and deletion per read (default: up to read length)
  -l   --len      the length of reads to be simulated
  -m   --mflen    the mean size of DNA/RNA fragments for paired-end simulations
  -mp  --matepair indicate a mate-pair read simulation
  -M  --cigarM    indicate to use CIGAR 'M' instead of '=/X' for alignment match/mismatch
  -nf  --maskN    the cutoff frequency of 'N' in a window size of the read length for masking genomic regions
                  NOTE: default: '-nf 1' to mask all regions with 'N'. Use '-nf 0' to turn off masking
  -na  --noALN    do not output ALN alignment file
  -o   --out      the prefix of output filename
  -p   --paired   indicate a paired-end read simulation or to generate reads from both ends of amplicons
                  NOTE: art will automatically switch to a mate-pair simulation if the given mean fragment size >= 2000
  -q   --quiet    turn off end of run summary
  -qL  --minQ     the minimum base quality score
  -qU  --maxQ     the maxiumum base quality score
  -qs  --qShift   the amount to shift every first-read quality score by 
  -qs2 --qShift2  the amount to shift every second-read quality score by
                  NOTE: For -qs/-qs2 option, a positive number will shift up quality scores (the max is 93) 
                  that reduce substitution sequencing errors and a negative number will shift down 
                  quality scores that increase sequencing errors. If shifting scores by x, the error
                  rate will be 1/(10^(x/10)) of the default profile.
  -rs  --rndSeed  the seed for random number generator (default: system time in second)
                  NOTE: using a fixed seed to generate two identical datasets from different runs
  -s   --sdev     the standard deviation of DNA/RNA fragment size for paired-end simulations.
  -sam --samout   indicate to generate SAM alignment file
  -sp  --sepProf  indicate to use separate quality profiles for different bases (ATGC)
  -ss  --seqSys   The name of Illumina sequencing system of the built-in profile used for simulation
       NOTE: sequencing system ID names are:
            GA1 - GenomeAnalyzer I (36bp,44bp), GA2 - GenomeAnalyzer II (50bp, 75bp)
           HS10 - HiSeq 1000 (100bp),          HS20 - HiSeq 2000 (100bp),      HS25 - HiSeq 2500 (125bp, 150bp)
           HSXn - HiSeqX PCR free (150bp),     HSXt - HiSeqX TruSeq (150bp),   MinS - MiniSeq TruSeq (50bp)
           MSv1 - MiSeq v1 (250bp),            MSv3 - MiSeq v3 (250bp),        NS50 - NextSeq500 v2 (75bp)
===== NOTES =====

* ART by default selects a built-in quality score profile according to the read length specified for the run.

* For single-end simulation, ART requires input sequence file, output file prefix, read length, and read count/fold coverage.

* For paired-end simulation (except for amplicon sequencing), ART also requires the parameter values of
  the mean and standard deviation of DNA/RNA fragment lengths

===== EXAMPLES =====

 1) single-end read simulation
 	art_illumina -ss HS25 -sam -i reference.fa -l 150 -f 10 -o single_dat

 2) paired-end read simulation
       art_illumina -ss HS25 -sam -i reference.fa -p -l 150 -f 20 -m 200 -s 10 -o paired_dat

 3) mate-pair read simulation
       art_illumina -ss HS10 -sam -i reference.fa -mp -l 100 -f 20 -m 2500 -s 50 -o matepair_dat

 4) amplicon sequencing simulation with 5' end single-end reads 
 	art_illumina -ss GA2 -amp -sam -na -i amp_reference.fa -l 50 -f 10 -o amplicon_5end_dat

 5) amplicon sequencing simulation with paired-end reads
       art_illumina -ss GA2 -amp -p -sam -na -i amp_reference.fa -l 50 -f 10 -o amplicon_pair_dat

 6) amplicon sequencing simulation with matepair reads
       art_illumina -ss MSv1 -amp -mp -sam -na -i amp_reference.fa -l 150 -f 10 -o amplicon_mate_dat

 7) generate an extra SAM file with zero-sequencing errors for a paired-end read simulation
       art_illumina -ss HSXn -ef -i reference.fa -p -l 150 -f 20 -m 200 -s 10 -o paired_twosam_dat

 8) reduce the substitution error rate to one 10th of the default profile
       art_illumina -i reference.fa -qs 10 -qs2 10 -l 50 -f 10 -p -m 500 -s 10 -sam -o reduce_error

 9) turn off the masking of genomic regions with unknown nucleotides 'N'
       art_illumina -ss HS20 -nf 0  -sam -i reference.fa -p -l 100 -f 20 -m 200 -s 10 -o paired_nomask

 10) masking genomic regions with >=5 'N's within the read length 50
       art_illumina -ss HSXt -nf 5 -sam -i reference.fa -p -l 150 -f 20 -m 200 -s 10 -o paired_maskN5

Fatal Error: -help, is not a valid parameter.
```
## art_tail

### Tool Description
Print last 10 lines of FILEs (or stdin). With more than one FILE, precede each with a filename header.

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: tail [OPTIONS] [FILE]...

Print last 10 lines of FILEs (or stdin) to.
With more than one FILE, precede each with a filename header.

	-c [+]N[bkm]	Print last N bytes
	-n N[bkm]	Print last N lines
	-n +N[bkm]	Start on Nth line and print the rest
			(b:*512 k:*1024 m:*1024^2)
	-q		Never print headers
	-v		Always print headers
	-f		Print data as file grows
	-F		Same as -f, but keep retrying
	-s SECONDS	Wait SECONDS between reads with -f
```

## art_ls

### Tool Description
List available tools, files, and datasets within the environment.

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
100.txt
10x_bamtofastq
2pg_cartesian
3d-dna
3seq
500.txt
501end.txt
a3partitioner
a5-miseq
aacon
aardvark
abacas
abacat
abawaca
abeona
abismal
abnumber
abpoa
abra2
abricate
abritamr
abromics_galaxy_json_extractor
abruijn
absense
abundancebin
abyss
abyss-k128
ac
ac-diamond
accusnv
acdc
acedb-other
acedb-other-belvu
acedb-other-dotter
aci
acms
actc
adam
adapt
adapterremoval
adapterremovalfixprefix
adas
addeam
addrg
admixtools
admixture
adpred
adun-core
adun.app
advntr
aegean
aenum
aeon
aeskulap
aevol
afpdb
afplot
afragmenter
afterqc
afwdist
agat
agc
age-metasv
agfusion
agg
aghermann
agouti
agrvate
agtools
airr
akt
albatradis
alcor
alder
ale
ale-core
alen
aletsch
alevin-fry
alfa
alfred
aliceasm
alien-hunter
alientrimmer
align_it
align_trim
aligncov
alignlib-lite
alignment
alignoth
alignstats
aliscore
aliview
all_tools_filtered.txt
allegro
allelecodes
allhic
allo
alloshp
alphafill
altair-mf
altamisa
alter-sequence-alignment
altex-be
altree
alv
amalgkit
amap
amap-align
amaranth-assembler
amas
ambertools
amdirt
amide
amiga
aminoextract
amira
amos
ampcombi
ampd-up
amplici
amplicon_coverage_plot
ampliconclassifier
ampliconnoise
ampliconsplitter
ampliconsuite
amplicontyper
amplify
ampligone
amplisim
amptk
amrfior
amulety
amused
anadama2
ananse
anansescanpy
anansnake
anarci
ancestry_hmm
ancestry_hmm-s
anchore-cli
anchorwave
ancientmetagenome-hostassociated_samples_v25.12.2.tsv
andi
anfo
anglerfish
angsd
aniclustermap
anise_basil
aniso8601
anndata
anndata2ri
annembed
annonars
annosine2
annotsv
annotwg
anospp-analysis
ansible
ant
antarna
antismash
antismash-lite
anvio
anvio-minimal
any2fasta
aodp
aplanat
apoc
apollo
appspam
apptainer
aprfinder
apscale
apt-probeset-summarize
aptardi
apu-label-propagation
aquamis
aquila
aquila_stlfr
aquila_sv
aquila_umap
aquilasv
aragorn
arb-bio
arb-bio-tools
arborator
arboreto
arborist
arcas-hla
archer
architeuthis
arcs
arcsv
arden
arem
argh
argnorm
argo
argopy
argparse-tui
argparse2tool
args_oap
argutils
aria2
ariba
array-as-vcf
arriba
arrow
art
back
bbmap
bcftools
bedtools
biobloomtools
biobox_add_taxid
biocamlib
biocantor
biocode
biocommons.seqrepo
bioconda-backup
bioconda-repodata-patches
bioconda-utils
bioconda2biocontainer
biocontainers
bioconvert
biodiff
biodigest
bioemu
bioepic
bioexcel_seqqc
biofluff
blast
bowtie2
bwa
curl
cwlagent
cwlagent.tar.gz
diamond
generate-skip-existing.sh
harpy
hmmer
linux_tools.txt
manifest.json
md5sum
meme
picard
samtools
signalp
test1
test2
test3
testdata
top_tools.txt
trash.log
```

## art_chmod

### Tool Description
Change file mode bits (BusyBox version). MODE is octal number or [ugoa]{+|-|=}[rwxXst].

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: chmod [-Rcvf] MODE[,MODE]... FILE...

MODE is octal number (bit pattern sstrwxrwxrwx) or [ugoa]{+|-|=}[rwxXst]

	-R	Recurse
	-c	List changed files
	-v	Verbose
	-f	Hide errors
```

## art_chown

### Tool Description
Change the owner and/or group of FILEs to USER and/or GRP

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: chown [-RhLHPcvf]... USER[:[GRP]] FILE...

Change the owner and/or group of FILEs to USER and/or GRP

	-h	Affect symlinks instead of symlink targets
	-L	Traverse all symlinks to directories
	-H	Traverse symlinks on command line only
	-P	Don't traverse symlinks (default)
	-R	Recurse
	-c	List changed files
	-v	Verbose
	-f	Hide errors
```

## art_du

### Tool Description
Summarize disk space used for FILEs (or directories)

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: du [-aHLdclsxhmk] [FILE]...

Summarize disk space used for FILEs (or directories)

	-a	Show file sizes too
	-b	Apparent size (including holes)
	-L	Follow all symlinks
	-H	Follow symlinks on command line
	-d N	Limit output to directories (and files with -a) of depth < N
	-c	Show grand total
	-l	Count sizes many times if hard linked
	-s	Display only a total for each argument
	-x	Skip directories on different filesystems
	-h	Sizes in human readable format (e.g., 1K 243M 2G)
	-m	Sizes in megabytes
	-k	Sizes in kilobytes (default)
```
## art_df

### Tool Description
Display information about the amount of available disk space on file systems.

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Filesystem           1K-blocks      Used Available Use% Mounted on
overlay                  65536        16     65520   0% /
devtmpfs                  4096         0      4096   0% /dev
tmpfs                 98312592         0  98312592   0% /dev/shm
sysext                98312592        12  98312580   0% /etc/localtime
/dev/sda1            921845792 799750420  75194416  91% /etc/hosts
efivarfs                   304        58       241  20% /sys/firmware/efi/efivars
nfs.vast-coe.ccr.buffalo.edu:/user/qianghu
                      25391104  10151936  15239168  40% /user/qianghu
/dev/sda1            921845792 799750420  75194416  91% /tmp
/dev/sda1            921845792 799750420  75194416  91% /var/tmp
tmpfs                    65536        16     65520   0% /etc/resolv.conf
tmpfs                    65536        16     65520   0% /etc/passwd
tmpfs                    65536        16     65520   0% /etc/group
nfs.vast-coe.ccr.buffalo.edu:/projects/rpci/songliu/qhu/projects/cwlrepo
                     600586914816 564858642432 35728272384  94% /projects/rpci/songliu/qhu/projects/cwlrepo
```

## art_ln

### Tool Description
Create a link LINK or DIR/TARGET to the specified TARGET(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: ln [-sfnbtv] [-S SUF] TARGET... LINK|DIR

Create a link LINK or DIR/TARGET to the specified TARGET(s)

	-s	Make symlinks instead of hardlinks
	-f	Remove existing destinations
	-n	Don't dereference symlinks - treat like normal file
	-b	Make a backup of the target (if exists) before link operation
	-S SUF	Use suffix instead of ~ when making backup files
	-T	Treat LINK as a file, not DIR
	-v	Verbose
```

## art_ip

### Tool Description
Network configuration tool for managing addresses, routes, links, tunnels, neighbors, and rules.

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: ip [OPTIONS] address|route|link|tunnel|neigh|rule [ARGS]

OPTIONS := -f[amily] inet|inet6|link | -o[neline]

ip addr add|del IFADDR dev IFACE | show|flush [dev IFACE] [to PREFIX]
ip route list|flush|add|del|change|append|replace|test ROUTE
ip link set IFACE [up|down] [arp on|off] [multicast on|off]
	[promisc on|off] [mtu NUM] [name NAME] [qlen NUM] [address MAC]
	[master IFACE | nomaster] [netns PID]
ip tunnel add|change|del|show [NAME]
	[mode ipip|gre|sit] [remote ADDR] [local ADDR] [ttl TTL]
ip neigh show|flush [to PREFIX] [dev DEV] [nud STATE]
ip rule [list] | add|del SELECTOR ACTION
```

## art_ifconfig

### Tool Description
Configure a network interface or display information about network interfaces.

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
bootnet   Link encap:Ethernet  HWaddr B4:96:91:8C:13:98  
          inet addr:10.18.85.142  Bcast:10.18.85.255  Mask:255.255.255.0
          inet6 addr: fe80::b696:91ff:fe8c:1398/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:9000  Metric:1
          RX packets:211617811 errors:0 dropped:1511522 overruns:0 frame:0
          TX packets:187460955 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:1272918750782 (1.1 TiB)  TX bytes:1117829773198 (1.0 TiB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:72256565 errors:0 dropped:0 overruns:0 frame:0
          TX packets:72256565 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:691589386695 (644.0 GiB)  TX bytes:691589386695 (644.0 GiB)
```

## art_traceroute

### Tool Description
Trace the route to HOST

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: traceroute [-46IFlnrv] [-f 1ST_TTL] [-m MAXTTL] [-q PROBES] [-p PORT]
	[-t TOS] [-w WAIT_SEC] [-s SRC_IP] [-i IFACE]
	[-z PAUSE_MSEC] HOST [BYTES]

Trace the route to HOST

	-4,-6	Force IP or IPv6 name resolution
	-F	Set don't fragment bit
	-I	Use ICMP ECHO instead of UDP datagrams
	-l	Display TTL value of the returned packet
	-n	Print numeric addresses
	-r	Bypass routing tables, send directly to HOST
	-v	Verbose
	-f N	First number of hops (default 1)
	-m N	Max number of hops
	-q N	Number of probes per hop (default 3)
	-p N	Base UDP port number used in probes
		(default 33434)
	-s IP	Source address
	-i IFACE Source interface
	-t N	Type-of-service in probe packets (default 0)
	-w SEC	Wait for a response (default 3)
	-z MSEC	Wait before each send
```

## art_top

### Tool Description
Show a view of process activity in real time. Read the status of all processes from /proc each SECONDS and show a screenful of them.

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: top [-bmH] [-n COUNT] [-d SECONDS]

Show a view of process activity in real time.
Read the status of all processes from /proc each SECONDS
and show a screenful of them.
Keys:
	N/M/P/T: show CPU usage, sort by pid/mem/cpu/time
	S: show memory
	R: reverse sort
	H: toggle threads, 1: toggle SMP
	Q,^C: exit
Options:
	-b	Batch mode
	-n N	Exit after N iterations
	-d SEC	Delay between updates
	-m	Same as 's' key
	-H	Show threads
```

## art_ps

### Tool Description
A tool that displays a list of currently running processes, including PID, user, time, and command information.

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
PID   USER     TIME  COMMAND
    1 nobody   12:31 /usr/lib/systemd/systemd --switched-root --system --deserialize=40 kernel
    2 nobody    0:00 [kthreadd]
    3 nobody    0:00 [pool_workqueue_]
    4 nobody    0:00 [kworker/R-rcu_g]
    5 nobody    0:00 [kworker/R-rcu_p]
    6 nobody    0:00 [kworker/R-slub_]
    7 nobody    0:00 [kworker/R-netns]
   10 nobody    0:00 [kworker/0:0H-ev]
   12 nobody    0:00 [kworker/R-mm_pe]
   13 nobody    0:00 [rcu_tasks_kthre]
   14 nobody    0:00 [rcu_tasks_rude_]
   15 nobody    0:00 [rcu_tasks_trace]
   16 nobody    0:04 [ksoftirqd/0]
   17 nobody    2:58 [rcu_preempt]
   18 nobody    0:05 [migration/0]
   19 nobody    0:00 [idle_inject/0]
   20 nobody    0:00 [cpuhp/0]
   21 nobody    0:00 [cpuhp/1]
   22 nobody    0:00 [idle_inject/1]
   23 nobody    0:05 [migration/1]
   24 nobody    0:02 [ksoftirqd/1]
   26 nobody    0:00 [kworker/1:0H-ev]
   27 nobody    0:00 [cpuhp/2]
   28 nobody    0:00 [idle_inject/2]
   29 nobody    0:06 [migration/2]
   30 nobody    0:01 [ksoftirqd/2]
   32 nobody    0:00 [kworker/2:0H-ev]
   33 nobody    0:00 [cpuhp/3]
   34 nobody    0:00 [idle_inject/3]
   35 nobody    0:05 [migration/3]
   36 nobody    0:00 [ksoftirqd/3]
   38 nobody    0:00 [kworker/3:0H-ev]
   39 nobody    0:00 [cpuhp/4]
   40 nobody    0:00 [idle_inject/4]
   41 nobody    0:06 [migration/4]
   42 nobody    0:00 [ksoftirqd/4]
   44 nobody    0:00 [kworker/4:0H-ev]
   45 nobody    0:00 [cpuhp/5]
   46 nobody    0:00 [idle_inject/5]
   47 nobody    0:05 [migration/5]
   48 nobody    0:00 [ksoftirqd/5]
   50 nobody    0:00 [kworker/5:0H-ev]
   51 nobody    0:00 [cpuhp/6]
   52 nobody    0:00 [idle_inject/6]
   53 nobody    0:05 [migration/6]
   54 nobody    0:00 [ksoftirqd/6]
   56 nobody    0:00 [kworker/6:0H-ev]
   57 nobody    0:00 [cpuhp/7]
   58 nobody    0:00 [idle_inject/7]
   59 nobody    0:04 [migration/7]
   60 nobody    0:00 [ksoftirqd/7]
   62 nobody    0:00 [kworker/7:0H-ev]
   63 nobody    0:00 [cpuhp/8]
   64 nobody    0:00 [idle_inject/8]
   65 nobody    0:05 [migration/8]
   66 nobody    0:00 [ksoftirqd/8]
   68 nobody    0:00 [kworker/8:0H-ev]
   69 nobody    0:00 [cpuhp/9]
   70 nobody    0:00 [idle_inject/9]
   71 nobody    0:04 [migration/9]
   72 nobody    0:02 [ksoftirqd/9]
   74 nobody    0:00 [kworker/9:0H-ev]
   75 nobody    0:00 [cpuhp/10]
   76 nobody    0:00 [idle_inject/10]
   77 nobody    0:05 [migration/10]
   78 nobody    0:00 [ksoftirqd/10]
   80 nobody    0:00 [kworker/10:0H-e]
   81 nobody    0:00 [cpuhp/11]
   82 nobody    0:00 [idle_inject/11]
   83 nobody    0:04 [migration/11]
   84 nobody    0:00 [ksoftirqd/11]
   86 nobody    0:00 [kworker/11:0H-e]
   87 nobody    0:00 [cpuhp/12]
   88 nobody    0:00 [idle_inject/12]
   89 nobody    0:05 [migration/12]
   90 nobody    0:00 [ksoftirqd/12]
   92 nobody    0:00 [kworker/12:0H-e]
   93 nobody    0:00 [cpuhp/13]
   94 nobody    0:00 [idle_inject/13]
   95 nobody    0:04 [migration/13]
   96 nobody    0:00 [ksoftirqd/13]
   98 nobody    0:00 [kworker/13:0H-e]
   99 nobody    0:00 [cpuhp/14]
  100 nobody    0:00 [idle_inject/14]
  101 nobody    0:05 [migration/14]
  102 nobody    0:00 [ksoftirqd/14]
  104 nobody    0:00 [kworker/14:0H-e]
  105 nobody    0:00 [cpuhp/15]
  106 nobody    0:00 [idle_inject/15]
  107 nobody    0:04 [migration/15]
  108 nobody    0:00 [ksoftirqd/15]
  110 nobody    0:00 [kworker/15:0H-e]
  111 nobody    0:00 [cpuhp/16]
  112 nobody    0:00 [idle_inject/16]
  113 nobody    0:05 [migration/16]
  114 nobody    0:00 [ksoftirqd/16]
  116 nobody    0:00 [kworker/16:0H-e]
  117 nobody    0:00 [cpuhp/17]
  118 nobody    0:00 [idle_inject/17]
  119 nobody    0:04 [migration/17]
  120 nobody    0:00 [ksoftirqd/17]
  122 nobody    0:00 [kworker/17:0H-e]
  123 nobody    0:00 [cpuhp/18]
  124 nobody    0:00 [idle_inject/18]
  125 nobody    0:05 [migration/18]
  126 nobody    0:00 [ksoftirqd/18]
  128 nobody    0:00 [kworker/18:0H-e]
  129 nobody    0:00 [cpuhp/19]
  130 nobody    0:00 [idle_inject/19]
  131 nobody    0:04 [migration/19]
  132 nobody    0:00 [ksoftirqd/19]
  134 nobody    0:00 [kworker/19:0H-e]
  135 nobody    0:00 [cpuhp/20]
  136 nobody    0:00 [idle_inject/20]
  137 nobody    0:05 [migration/20]
  138 nobody    0:00 [ksoftirqd/20]
  140 nobody    0:00 [kworker/20:0H-e]
  141 nobody    0:00 [cpuhp/21]
  142 nobody    0:00 [idle_inject/21]
  143 nobody    0:04 [migration/21]
  144 nobody    0:00 [ksoftirqd/21]
  146 nobody    0:00 [kworker/21:0H-k]
  147 nobody    0:00 [cpuhp/22]
  148 nobody    0:00 [idle_inject/22]
  149 nobody    0:05 [migration/22]
  150 nobody    0:00 [ksoftirqd/22]
  152 nobody    0:00 [kworker/22:0H-e]
  153 nobody    0:00 [cpuhp/23]
  154 nobody    0:00 [idle_inject/23]
  155 nobody    0:04 [migration/23]
  156 nobody    0:00 [ksoftirqd/23]
  158 nobody    0:00 [kworker/23:0H-e]
  159 nobody    0:00 [cpuhp/24]
  160 nobody    0:00 [idle_inject/24]
  161 nobody    0:05 [migration/24]
  162 nobody    0:00 [ksoftirqd/24]
  164 nobody    0:00 [kworker/24:0H-k]
  165 nobody    0:00 [cpuhp/25]
  166 nobody    0:00 [idle_inject/25]
  167 nobody    0:04 [migration/25]
  168 nobody    0:04 [ksoftirqd/25]
  170 nobody    0:00 [kworker/25:0H-e]
  171 nobody    0:00 [cpuhp/26]
  172 nobody    0:00 [idle_inject/26]
  173 nobody    0:05 [migration/26]
  174 nobody    0:00 [ksoftirqd/26]
  176 nobody    0:00 [kworker/26:0H-e]
  177 nobody    0:00 [cpuhp/27]
  178 nobody    0:00 [idle_inject/27]
  179 nobody    0:04 [migration/27]
  180 nobody    0:01 [ksoftirqd/27]
  183 nobody    0:00 [cpuhp/28]
  184 nobody    0:00 [idle_inject/28]
  185 nobody    0:05 [migration/28]
  186 nobody    0:00 [ksoftirqd/28]
  188 nobody    0:00 [kworker/28:0H-e]
  189 nobody    0:00 [cpuhp/29]
  190 nobody    0:00 [idle_inject/29]
  191 nobody    0:04 [migration/29]
  192 nobody    0:00 [ksoftirqd/29]
  194 nobody    0:00 [kworker/29:0H-e]
  195 nobody    0:00 [cpuhp/30]
  196 nobody    0:00 [idle_inject/30]
  197 nobody    0:05 [migration/30]
  198 nobody    0:00 [ksoftirqd/30]
  200 nobody    0:00 [kworker/30:0H-e]
  201 nobody    0:00 [cpuhp/31]
  202 nobody    0:00 [idle_inject/31]
  203 nobody    0:04 [migration/31]
  204 nobody    0:00 [ksoftirqd/31]
  206 nobody    0:00 [kworker/31:0H-e]
  207 nobody    0:00 [cpuhp/32]
  208 nobody    0:00 [idle_inject/32]
  209 nobody    0:05 [migration/32]
  210 nobody    0:00 [ksoftirqd/32]
  212 nobody    0:00 [kworker/32:0H-e]
  213 nobody    0:00 [cpuhp/33]
  214 nobody    0:00 [idle_inject/33]
  215 nobody    0:04 [migration/33]
  216 nobody    0:00 [ksoftirqd/33]
  218 nobody    0:00 [kworker/33:0H-e]
  219 nobody    0:00 [cpuhp/34]
  220 nobody    0:00 [idle_inject/34]
  221 nobody    0:05 [migration/34]
  222 nobody    0:00 [ksoftirqd/34]
  224 nobody    0:00 [kworker/34:0H-e]
  225 nobody    0:00 [cpuhp/35]
  226 nobody    0:00 [idle_inject/35]
  227 nobody    0:04 [migration/35]
  228 nobody    0:00 [ksoftirqd/35]
  230 nobody    0:00 [kworker/35:0H-e]
  231 nobody    0:00 [cpuhp/36]
  232 nobody    0:00 [idle_inject/36]
  233 nobody    0:05 [migration/36]
  234 nobody    0:00 [ksoftirqd/36]
  236 nobody    0:00 [kworker/36:0H-e]
  237 nobody    0:00 [cpuhp/37]
  238 nobody    0:00 [idle_inject/37]
  239 nobody    0:04 [migration/37]
  240 nobody    0:00 [ksoftirqd/37]
  242 nobody    0:00 [kworker/37:0H-e]
  243 nobody    0:00 [cpuhp/38]
  244 nobody    0:00 [idle_inject/38]
  245 nobody    0:05 [migration/38]
  246 nobody    0:00 [ksoftirqd/38]
  248 nobody    0:00 [kworker/38:0H-e]
  249 nobody    0:00 [cpuhp/39]
  250 nobody    0:00 [idle_inject/39]
  251 nobody    0:04 [migration/39]
  252 nobody    0:01 [ksoftirqd/39]
  254 nobody    0:00 [kworker/39:0H-e]
  257 nobody    0:00 [kdevtmpfs]
  258 nobody    0:00 [kworker/R-inet_]
  259 nobody    0:05 [kauditd]
  261 nobody    0:01 [khungtaskd]
  263 nobody    0:05 [oom_reaper]
  265 nobody    0:00 [kworker/R-write]
  266 nobody    1:41 [kcompactd0]
  267 nobody    1:23 [kcompactd1]
  268 nobody    0:00 [ksmd]
  269 nobody    0:11 [khugepaged]
  270 nobody    0:00 [kworker/R-kinte]
  271 nobody    0:00 [kworker/R-kbloc]
  272 nobody    0:00 [kworker/R-blkcg]
  273 nobody    0:00 [irq/9-acpi]
  276 nobody    0:00 [kworker/R-tpm_d]
  277 nobody    0:00 [kworker/R-ata_s]
  278 nobody    0:00 [kworker/R-md]
  279 nobody    0:00 [kworker/R-md_bi]
  280 nobody    0:00 [kworker/R-edac-]
  282 nobody    0:00 [kworker/R-devfr]
  283 nobody    0:00 [watchdogd]
  285 nobody    0:00 [kworker/0:1H-kb]
  290 nobody    1:55 [kswapd0]
  291 nobody    2:00 [kswapd1]
  292 nobody    0:00 [ecryptfs-kthrea]
  293 nobody    0:00 [kworker/R-kthro]
  294 nobody    0:00 [irq/30-pciehp]
  295 nobody    0:00 [irq/31-pciehp]
  296 nobody    0:00 [kworker/R-acpi_]
  308 nobody    0:00 [kworker/R-mld]
  309 nobody    0:00 [kworker/4:1H-kb]
  310 nobody    0:00 [kworker/R-ipv6_]
  344 nobody    0:00 [kworker/R-kstrp]
  346 nobody    0:00 [kworker/u83:0]
  347 nobody    0:00 [kworker/u84:0]
  348 nobody    0:00 [kworker/u85:0]
  354 nobody    0:00 [kworker/R-crypt]
  369 nobody    0:00 [kworker/R-charg]
  371 nobody    0:00 [kworker/6:1H-kb]
  373 nobody    0:00 [kworker/10:1H-k]
  401 nobody    0:00 [kworker/7:1H-kb]
  402 nobody    0:00 [kworker/12:1H-k]
  409 nobody    0:00 [kworker/14:1H-k]
  411 nobody    0:00 [kworker/16:1H-k]
  413 nobody    0:00 [kworker/9:1H-kb]
  416 nobody    0:00 [kworker/1:1H-kb]
  418 nobody    0:00 [kworker/8:1H-kb]
  422 nobody    0:02 [kworker/18:1H-k]
  426 nobody    0:00 [kworker/3:1H-kb]
  429 nobody    0:00 [kworker/2:1H-kb]
  431 nobody    0:00 [kworker/24:1H]
  448 nobody    0:00 [kworker/5:1H-kb]
  472 nobody    0:00 [kworker/13:1H-k]
  476 nobody    0:00 [kworker/17:1H-k]
  478 nobody    0:00 [kworker/15:1H-k]
  483 nobody    0:00 [kworker/21:1H-k]
  484 nobody    0:00 [kworker/11:1H-k]
  485 nobody    0:00 [kworker/23:1H-k]
  488 nobody    0:00 [kworker/27:1H-k]
  489 nobody    0:00 [kworker/29:1H-k]
  491 nobody    0:00 [kworker/25:1H-k]
  492 nobody    0:00 [kworker/31:1H-k]
  494 nobody    0:00 [kworker/33:1H-k]
  496 nobody    0:01 [kworker/35:1H-k]
  499 nobody    0:03 [kworker/39:1H-k]
  500 nobody    0:01 [kworker/37:1H-k]
  518 nobody    0:00 [kworker/32:1H-k]
  519 nobody    0:00 [kworker/26:1H-k]
  520 nobody    0:00 [kworker/28:1H-k]
  522 nobody    0:00 [kworker/30:1H-k]
  523 nobody    0:00 [kworker/22:1H-k]
  524 nobody    0:00 [kworker/20:1H-k]
  526 nobody    0:00 [kworker/34:1H-k]
  528 nobody    0:00 [kworker/36:1H-k]
  537 nobody    0:00 [kworker/38:1H-k]
  588 nobody    0:00 [kworker/R-ipmi-]
  593 nobody    0:00 [scsi_eh_0]
  594 nobody    0:00 [kworker/R-scsi_]
  597 nobody    0:00 [scsi_eh_1]
  598 nobody    0:00 [kworker/R-scsi_]
  600 nobody    0:00 [scsi_eh_2]
  601 nobody    0:00 [kworker/R-scsi_]
  602 nobody    0:00 [scsi_eh_3]
  614 nobody    0:00 [kworker/R-scsi_]
  615 nobody    0:00 [scsi_eh_4]
  616 nobody    0:00 [kworker/R-scsi_]
  618 nobody    0:00 [scsi_eh_5]
  619 nobody    0:00 [kworker/R-scsi_]
  623 nobody    0:00 [kworker/R-ixgbe]
  624 nobody    0:00 [scsi_eh_6]
  625 nobody    0:00 [kworker/R-scsi_]
  628 nobody    0:00 [scsi_eh_7]
  629 nobody    0:00 [kworker/R-scsi_]
  636 nobody    0:00 [scsi_eh_8]
  639 nobody    0:00 [kworker/R-scsi_]
  643 nobody    0:00 [scsi_eh_9]
  644 nobody    0:00 [kworker/R-scsi_]
  645 nobody    0:00 [scsi_eh_10]
  646 nobody    0:00 [kworker/R-scsi_]
  647 nobody    0:00 [scsi_eh_11]
  648 nobody    0:00 [kworker/R-scsi_]
  649 nobody    0:00 [scsi_eh_12]
  650 nobody    0:00 [kworker/R-scsi_]
  651 nobody    0:00 [scsi_eh_13]
  652 nobody    0:00 [kworker/R-scsi_]
  667 nobody    0:00 [kworker/R-nfit]
  672 nobody    0:00 [kworker/R-cfg80]
  748 nobody    0:43 [jbd2/sda1-8]
  749 nobody    0:00 [kworker/R-ext4-]
  917 nobody    2:37 /usr/lib/systemd/systemd-journald
  923 nobody    0:00 [kworker/R-rpcio]
  924 nobody    0:00 [kworker/R-xprti]
  975 nobody    0:04 /usr/lib/systemd/systemd-udevd
  979 nobody    0:01 /sbin/rpcbind -f -w
  983 nobody    6:25 /usr/lib/systemd/systemd-oomd
  984 nobody    1:34 /usr/lib/systemd/systemd-resolved
  985 nobody    0:00 [psimon]
 1007 nobody    0:05 /usr/lib/systemd/systemd-timesyncd
 1109 nobody    0:01 /usr/sbin/rpc.gssd
 1111 nobody    0:16 /usr/lib/systemd/systemd-networkd
 1122 nobody    0:00 [erofs_worker/0]
 1123 nobody    0:00 [erofs_worker/1]
 1124 nobody    0:00 [erofs_worker/2]
 1125 nobody    0:00 [erofs_worker/3]
 1126 nobody    0:00 [erofs_worker/4]
 1127 nobody    0:00 [erofs_worker/5]
 1128 nobody    0:00 [erofs_worker/6]
 1129 nobody    0:00 [erofs_worker/7]
 1130 nobody    0:00 [erofs_worker/8]
 1131 nobody    0:00 [erofs_worker/9]
 1132 nobody    0:00 [erofs_worker/10]
 1133 nobody    0:00 [erofs_worker/11]
 1134 nobody    0:00 [erofs_worker/12]
 1135 nobody    0:00 [erofs_worker/13]
 1136 nobody    0:00 [erofs_worker/14]
 1137 nobody    0:00 [erofs_worker/15]
 1138 nobody    0:00 [erofs_worker/16]
 1139 nobody    0:00 [erofs_worker/17]
 1140 nobody    0:00 [erofs_worker/18]
 1141 nobody    0:00 [erofs_worker/19]
 1142 nobody    0:00 [erofs_worker/20]
 1143 nobody    0:00 [erofs_worker/21]
 1144 nobody    0:00 [erofs_worker/22]
 1145 nobody    0:00 [erofs_worker/23]
 1146 nobody    0:00 [erofs_worker/24]
 1147 nobody    0:00 [erofs_worker/25]
 1148 nobody    0:00 [erofs_worker/26]
 1149 nobody    0:00 [erofs_worker/27]
 1150 nobody    0:00 [erofs_worker/28]
 1151 nobody    0:00 [erofs_worker/29]
 1152 nobody    0:00 [erofs_worker/30]
 1153 nobody    0:00 [erofs_worker/31]
 1154 nobody    0:00 [erofs_worker/32]
 1155 nobody    0:00 [erofs_worker/33]
 1156 nobody    0:00 [erofs_worker/34]
 1157 nobody    0:00 [erofs_worker/35]
 1158 nobody    0:00 [erofs_worker/36]
 1159 nobody    0:00 [erofs_worker/37]
 1160 nobody    0:00 [erofs_worker/38]
 1161 nobody    0:00 [erofs_worker/39]
 1166 nobody    0:00 [kworker/R-dm_bu]
 1168 nobody    0:00 [kworker/R-kdmfl]
 1169 nobody    0:00 [kworker/R-kveri]
 1172 nobody    0:00 [kworker/27:2H-k]
 1173 nobody    0:00 [kworker/19:2H-k]
 1181 nobody    0:00 /usr/bin/dbus-broker-launch --scope system --audit
 1184 nobody   15:23 dbus-broker --log 4 --controller 9 --machine-id 2683a8c4758a4fa5ac690b11fba9b18a --max-bytes 536870912 --max-fds 4096 --max-matches 16384 --audit
 1187 nobody    6:45 /usr/bin/prometheus-ipmi-exporter --freeipmi.path=/usr/bin --config.file=/etc/prometheus/ipmi_exporter.yml
 1189 nobody    2h00 /usr/bin/prometheus-node-exporter
 1200 nobody    0:19 /usr/sbin/rsyslogd -n -iNONE
 1201 nobody    0:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
 1229 nobody    1h01 /usr/bin/cgroup_exporter --collect.fullslurm --web.disable-exporter-metrics
 1236 nobody    0:45 /usr/sbin/munged
 1240 nobody    0:02 /usr/sbin/sssd -i --logger=files
 1248 nobody    0:00 /usr/sbin/rpc.statd
 1251 nobody    1:06 /usr/libexec/sssd/sssd_be --domain cbls.ccr.buffalo.edu --uid 0 --gid 0 --logger=files
 1292 nobody    0:37 /usr/libexec/sssd/sssd_nss --uid 0 --gid 0 --logger=files
 1293 nobody    0:20 /usr/libexec/sssd/sssd_pam --uid 0 --gid 0 --logger=files
 1294 nobody    0:09 /usr/libexec/sssd/sssd_pac --uid 0 --gid 0 --logger=files
 1296 nobody    0:00 [psimon]
 1309 nobody    0:06 /usr/lib/systemd/systemd-logind
 1310 nobody    0:00 [kworker/R-nfsio]
 1315 nobody    0:00 [lockd]
 1341 nobody    0:06 /usr/sbin/automount --pid-file /var/run/autofs.pid
 1353 nobody    0:00 /sbin/agetty -o -p -- \u --noclear - linux
 1354 nobody    0:00 /sbin/agetty -o -p -- \u --keep-baud 115200,57600,38400,9600 - vt220
 1361 nobody    0:00 /usr/sbin/slurmstepd infinity
 1548 nobody    0:45 /usr/sbin/slurmd --systemd --conf-server slurmctl-faculty.core.ccr.buffalo.edu
 5213 nobody    0:00 /usr/bin/cvmfs2 -o rw,system_mount,fsname=cvmfs2,allow_other,grab_mountpoint,uid=107,gid=107 cvmfs-config.ccr.buffalo.edu /cvmfs/cvmfs-config.ccr.buffalo.edu
 5215 nobody    0:49 /usr/bin/cvmfs2 __cachemgr__ . 9 10 4194304000 2097152000 1 3 -1 :
 5219 nobody    0:00 /usr/bin/cvmfs2 __cachemgr__ . 9 10 4194304000 2097152000 1 3 -1 :
 5227 nobody    0:31 /usr/bin/cvmfs2 -o rw,system_mount,fsname=cvmfs2,allow_other,grab_mountpoint,uid=107,gid=107 cvmfs-config.ccr.buffalo.edu /cvmfs/cvmfs-config.ccr.buffalo.edu
 5279 nobody    0:00 /usr/bin/cvmfs2 -o rw,system_mount,fsname=cvmfs2,allow_other,grab_mountpoint,uid=107,gid=107 soft.ccr.buffalo.edu /cvmfs/soft.ccr.buffalo.edu
 5284 nobody    5:44 /usr/bin/cvmfs2 -o rw,system_mount,fsname=cvmfs2,allow_other,grab_mountpoint,uid=107,gid=107 soft.ccr.buffalo.edu /cvmfs/soft.ccr.buffalo.edu
334783 nobody    0:04 slurmstepd: [21763522.extern]
334788 qianghu   0:00 /usr/lib/systemd/systemd --user
334789 nobody    0:00 sleep 100000000
334792 nobody    0:16 slurmstepd: [21763522.interactive]
334799 qianghu   0:00 /bin/bash -l
334800 qianghu   0:00 (sd-pam)
335790 nobody    0:00 newgrp grp-songliu
335791 qianghu   0:00 bash
346765 qianghu   0:00 /usr/libexec/apptainer/bin/squashfuse_ll -f -o allow_other,ro,uid=89201154,gid=104456,offset=40960 /proc/self/fd/3 /var/lib/apptainer/mnt/session/rootfs
346981 nobody    0:00 [kworker/24:0-ev]
350355 qianghu   0:03 /usr/libexec/apptainer/bin/squashfuse_ll -f -o allow_other,ro,uid=89201154,gid=104456,offset=40960 /proc/self/fd/3 /var/lib/apptainer/mnt/session/rootfs
350865 nobody    0:00 [kworker/17:2-rc]
354656 qianghu   0:01 /usr/libexec/apptainer/bin/squashfuse_ll -f -o allow_other,ro,uid=89201154,gid=104456,offset=40960 /proc/self/fd/3 /var/lib/apptainer/mnt/session/rootfs
356265 qianghu   0:00 /usr/libexec/apptainer/bin/squashfuse_ll -f -o allow_other,ro,uid=89201154,gid=104456,offset=40960 /proc/self/fd/3 /var/lib/apptainer/mnt/session/rootfs
357916 qianghu   0:00 /usr/libexec/apptainer/bin/squashfuse_ll -f -o allow_other,ro,uid=89201154,gid=104456,offset=40960 /proc/self/fd/3 /var/lib/apptainer/mnt/session/rootfs
374873 qianghu   0:02 /usr/libexec/apptainer/bin/squashfuse_ll -f -o allow_other,ro,uid=89201154,gid=104456,offset=40960 /proc/self/fd/3 /var/lib/apptainer/mnt/session/rootfs
384764 qianghu   0:00 /usr/libexec/apptainer/bin/squashfuse_ll -f -o allow_other,ro,uid=89201154,gid=104456,offset=40960 /proc/self/fd/3 /var/lib/apptainer/mnt/session/rootfs
409622 qianghu   0:00 bash ./generate-skip-existing.sh
415545 nobody    0:00 [kworker/32:1-mm]
415664 nobody    0:00 [kworker/38:2-mm]
419311 nobody    0:00 [kworker/4:1-rcu]
429572 nobody    0:00 [kworker/28:0-rc]
444421 nobody    0:00 [kworker/18:2-mm]
445273 nobody    0:00 [kworker/22:2-ev]
445634 qianghu   0:01 /usr/libexec/apptainer/bin/squashfuse_ll -f -o allow_other,ro,uid=89201154,gid=104456,offset=40960 /proc/self/fd/3 /var/lib/apptainer/mnt/session/rootfs
446881 nobody    0:00 [kworker/3:1-mm_]
447896 nobody    0:00 [kworker/0:2-eve]
450530 nobody    0:00 [kworker/21:0-mm]
451057 nobody    0:00 [kworker/6:0-mm_]
464467 nobody    0:00 [kworker/19:0-rc]
464643 nobody    0:00 [kworker/8:2-mm_]
465135 nobody    0:00 [kworker/30:1-ev]
468466 nobody    0:00 [kworker/14:2-mm]
468467 nobody    0:00 [kworker/20:1-ev]
468586 nobody    0:00 [kworker/5:2-eve]
468920 nobody    0:00 [kworker/25:0-ev]
479248 nobody    0:00 [kworker/16:0-ev]
480526 nobody    0:00 [kworker/10:0-rc]
483142 nobody    0:00 [kworker/7:2-mm_]
485302 nobody    0:00 [kworker/33:0-rc]
488032 nobody    0:30 [kworker/u80:2-i]
494063 nobody    0:00 [kworker/29:2-ev]
494064 nobody    0:00 [kworker/23:0-mm]
494617 nobody    0:00 [kworker/26:2-ev]
498816 nobody    0:00 [kworker/13:0-ev]
498823 nobody    0:00 [kworker/34:1-mm]
499546 nobody    0:00 [kworker/12:1-rc]
500213 nobody    0:00 [kworker/39:2-mm]
500273 nobody    0:00 [kworker/15:2-ev]
500653 nobody    0:00 [kworker/27:2-ev]
501473 nobody    0:00 [kworker/37:1-ev]
501777 nobody    0:00 [kworker/31:1-ev]
501896 nobody    0:00 [kworker/35:1-ev]
502796 nobody    0:00 [kworker/11:0-ev]
505930 nobody    0:00 [kworker/9:0-rcu]
506407 nobody    0:00 [kworker/1:2-eve]
507140 nobody    0:00 [kworker/22:1-rc]
508791 nobody    0:13 [kworker/u80:0-i]
509612 nobody    0:09 [kworker/u82:2-f]
509646 nobody    0:00 [kworker/14:0-rc]
509710 nobody    0:00 [kworker/37:0-rc]
509770 nobody    0:00 [kworker/7:0-rcu]
509826 nobody    0:00 [kworker/31:0-rc]
509828 nobody    0:00 [kworker/17:1-ev]
509878 nobody    0:00 [kworker/20:2-rc]
509888 nobody    0:00 [kworker/25:1-rc]
510234 nobody    0:00 [kworker/15:1-rc]
510241 nobody    0:00 [kworker/19:1-mm]
510291 nobody    0:00 [kworker/38:0-rc]
510297 nobody    0:00 [kworker/8:0-rcu]
510680 nobody    0:00 [kworker/2:2-mm_]
510742 nobody    0:00 [kworker/23:2-rc]
510944 nobody    0:06 [kworker/u81:13-]
513087 nobody    0:01 [kworker/u81:6-e]
513119 nobody    0:00 [kworker/29:1-rc]
513130 nobody    0:00 [kworker/34:0-rc]
513132 nobody    0:00 [kworker/36:1-mm]
513133 nobody    0:00 [kworker/26:1-rc]
513184 nobody    0:00 [kworker/9:1-rcu]
513193 nobody    0:00 [kworker/10:2-ev]
513197 nobody    0:00 [kworker/0:1-rcu]
513247 nobody    0:00 [kworker/11:1-rc]
513248 nobody    0:00 [kworker/24:1-rc]
513320 nobody    0:00 [kworker/15:0-rc]
513383 nobody    0:00 [kworker/5:1-rcu]
513549 nobody    0:10 [kworker/u82:0-f]
513551 nobody    0:01 [kworker/u82:5-w]
513583 nobody    0:05 [kworker/u81:8-x]
515027 nobody    0:01 [kworker/u81:0-e]
516657 nobody    0:00 [kworker/u81:1-e]
516821 nobody    0:00 [kworker/u81:2-n]
516853 nobody    0:00 [kworker/1:0-rcu]
516854 nobody    0:00 [kworker/30:0-rc]
516860 nobody    0:00 [kworker/2:0-rcu]
516861 nobody    0:00 [kworker/4:2-mm_]
516912 nobody    0:00 [kworker/16:1-rc]
516913 nobody    0:00 [kworker/3:0-rcu]
516920 nobody    0:00 [kworker/36:0-rc]
516921 nobody    0:00 [kworker/39:1-rc]
516922 nobody    0:00 [kworker/33:2-ev]
516978 nobody    0:00 [kworker/12:0-ev]
516979 nobody    0:00 [kworker/6:1-rcu]
517029 nobody    0:00 [kworker/13:1-rc]
517030 nobody    0:00 [kworker/28:1-ev]
517037 nobody    0:00 [kworker/21:1-rc]
517038 nobody    0:00 [kworker/32:2-rc]
517039 nobody    0:00 [kworker/18:1-rc]
517089 nobody    0:00 [kworker/35:0-rc]
517095 nobody    0:00 [kworker/27:0-rc]
517372 nobody    0:00 [kworker/u82:1]
517403 nobody    0:00 [kworker/31:2-rc]
517409 nobody    0:00 [kworker/7:1-rcu]
517410 nobody    0:00 [kworker/29:0-rc]
517412 nobody    0:00 [kworker/34:2-rc]
517466 nobody    0:00 [kworker/19:2]
517468 nobody    0:00 [kworker/11:2-rc]
517518 nobody    0:00 [kworker/9:2-rcu]
517524 nobody    0:00 [kworker/5:0-rcu]
517626 nobody    0:00 [kworker/20:0-rc]
517677 qianghu   0:14 {cwlagent} /projects/rpci/songliu/qhu/miniconda3/bin/python3 /projects/rpci/songliu/qhu/miniconda3/bin/cwlagent regenerate art --singularity
517878 nobody    0:00 [kworker/37:2-rc]
517944 nobody    0:00 [kworker/38:1-rc]
518001 nobody    0:00 [kworker/8:1-rcu]
518003 nobody    0:00 [kworker/25:2-rc]
518060 nobody    0:00 [kworker/24:2-rc]
518061 nobody    0:00 [kworker/14:1-rc]
518281 nobody    0:00 [kworker/23:1-rc]
518557 nobody    0:00 [kworker/17:0]
518910 nobody    0:00 [kworker/26:0-rc]
519422 nobody    0:00 [kworker/22:0-rc]
520223 nobody    0:00 [kworker/10:1-rc]
521925 nobody    0:00 [kworker/32:0-rc]
521933 nobody    0:00 [kworker/36:2-rc]
521982 nobody    0:00 [kworker/28:2]
521990 nobody    0:00 [kworker/18:0]
522049 nobody    0:00 [kworker/12:2-rc]
522100 nobody    0:00 [kworker/2:1-rcu]
522108 nobody    0:00 [kworker/0:0-rcu]
522223 nobody    0:00 [kworker/1:1-rcu]
522224 nobody    0:00 [kworker/35:2-rc]
522267 qianghu   0:00 /usr/libexec/apptainer/bin/squashfuse_ll -f -o allow_other,ro,uid=89201154,gid=104456,offset=40960 /proc/self/fd/3 /var/lib/apptainer/mnt/session/rootfs
522274 nobody    0:00 [kworker/6:2-rcu]
522329 nobody    0:00 (udev-worker)
522333 nobody    0:00 [kworker/21:2-rc]
522340 nobody    0:00 [kworker/39:0-rc]
522342 nobody    0:00 [kworker/4:0-rcu]
522448 nobody    0:00 [kworker/33:1-rc]
522454 nobody    0:00 [kworker/16:2-rc]
522503 nobody    0:00 [kworker/30:2-rc]
522510 nobody    0:00 [kworker/3:2]
522725 nobody    0:00 [kworker/27:1]
522790 qianghu   0:00 {starter} Apptainer runtime parent: 6ff4191dde9f89b6ab0989a30c8e68657880a5c839ede683115c2455fcc34bf6
522818 qianghu   0:00 /usr/bin/ps
522833 qianghu   0:00 /usr/libexec/apptainer/bin/squashfuse_ll -f -o allow_other,ro,uid=89201154,gid=104456,offset=40960 /proc/self/fd/3 /var/lib/apptainer/mnt/session/rootfs
```

## art_xargs

### Tool Description
Run PROG on every item given by stdin

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: xargs [OPTIONS] [PROG ARGS]

Run PROG on every item given by stdin

	-0	NUL terminated input
	-a FILE	Read from FILE instead of stdin
	-o	Reopen stdin as /dev/tty
	-r	Don't run command if input is empty
	-t	Print the command on stderr before execution
	-p	Ask user whether to run each command
	-E STR,-e[STR]	STR stops input processing
	-I STR	Replace STR within PROG ARGS with input line
	-n N	Pass no more than N args to PROG
	-s N	Pass command line of no more than N bytes
	-P N	Run up to N PROGs in parallel
	-x	Exit if size is exceeded
```

## art_grep

### Tool Description
Search for PATTERN in FILEs (or stdin)

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: grep [-HhnlLoqvsrRiwFE] [-m N] [-A|B|C N] { PATTERN | -e PATTERN... | -f FILE... } [FILE]...

Search for PATTERN in FILEs (or stdin)

	-H	Add 'filename:' prefix
	-h	Do not add 'filename:' prefix
	-n	Add 'line_no:' prefix
	-l	Show only names of files that match
	-L	Show only names of files that don't match
	-c	Show only count of matching lines
	-o	Show only the matching part of line
	-q	Quiet. Return 0 if PATTERN is found, 1 otherwise
	-v	Select non-matching lines
	-s	Suppress open and read errors
	-r	Recurse
	-R	Recurse and dereference symlinks
	-i	Ignore case
	-w	Match whole words only
	-x	Match whole lines only
	-F	PATTERN is a literal (not regexp)
	-E	PATTERN is an extended regexp
	-m N	Match up to N times per file
	-A N	Print N lines of trailing context
	-B N	Print N lines of leading context
	-C N	Same as '-A N -B N'
	-e PTRN	Pattern to match
	-f FILE	Read pattern from file
```

## art_find

### Tool Description
Search for files and perform actions on them. First failed action stops processing of current file. Defaults: PATH is current directory, action is '-print'

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
find: unrecognized: -help
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: find [-HL] [PATH]... [OPTIONS] [ACTIONS]

Search for files and perform actions on them.
First failed action stops processing of current file.
Defaults: PATH is current directory, action is '-print'

	-L,-follow	Follow symlinks
	-H		...on command line only
	-xdev		Don't descend directories on other filesystems
	-maxdepth N	Descend at most N levels. -maxdepth 0 applies
			actions to command line arguments only
	-mindepth N	Don't act on first N levels
	-depth		Act on directory *after* traversing it

Actions:
	( ACTIONS )	Group actions for -o / -a
	! ACT		Invert ACT's success/failure
	ACT1 [-a] ACT2	If ACT1 fails, stop, else do ACT2
	ACT1 -o ACT2	If ACT1 succeeds, stop, else do ACT2
			Note: -a has higher priority than -o
	-name PATTERN	Match file name (w/o directory name) to PATTERN
	-iname PATTERN	Case insensitive -name
	-path PATTERN	Match path to PATTERN
	-ipath PATTERN	Case insensitive -path
	-regex PATTERN	Match path to regex PATTERN
	-type X		File type is X (one of: f,d,l,b,c,s,p)
	-executable	File is executable
	-perm MASK	At least one mask bit (+MASK), all bits (-MASK),
			or exactly MASK bits are set in file's mode
	-mtime DAYS	mtime is greater than (+N), less than (-N),
			or exactly N days in the past
	-atime DAYS	atime +N/-N/N days in the past
	-ctime DAYS	ctime +N/-N/N days in the past
	-mmin MINS	mtime is greater than (+N), less than (-N),
			or exactly N minutes in the past
	-amin MINS	atime +N/-N/N minutes in the past
	-cmin MINS	ctime +N/-N/N minutes in the past
	-newer FILE	mtime is more recent than FILE's
	-inum N		File has inode number N
	-samefile FILE	File is same as FILE
	-user NAME/ID	File is owned by given user
	-group NAME/ID	File is owned by given group
	-size N[bck]	File size is N (c:bytes,k:kbytes,b:512 bytes(def.))
			+/-N: file size is bigger/smaller than N
	-links N	Number of links is greater than (+N), less than (-N),
			or exactly N
	-empty		Match empty file/directory
	-prune		If current file is directory, don't descend into it
If none of the following actions is specified, -print is assumed
	-print		Print file name
	-print0		Print file name, NUL terminated
	-exec CMD ARG ;	Run CMD with all instances of {} replaced by
			file name. Fails if CMD exits with nonzero
	-exec CMD ARG + Run CMD with {} replaced by list of file names
	-delete		Delete current file/directory. Turns on -depth option
	-quit		Exit
```
## art_rm

### Tool Description
Remove (unlink) FILEs

### Metadata
- **Docker Image**: quay.io/biocontainers/art:2016.06.05--h0704011_13
- **Homepage**: https://github.com/jlevy/the-art-of-command-line
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: rm [-irf] FILE...

Remove (unlink) FILEs

	-i	Always prompt before removing
	-f	Never prompt
	-R,-r	Recurse
```

