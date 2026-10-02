# cd-hit CWL Generation Report

## cd-hit

### Tool Description
The provided text does not contain help information for cd-hit; it is a fatal error log from a container runtime (Apptainer/Singularity) indicating a 'no space left on device' error during image extraction.

### Metadata
- **Docker Image**: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
- **Homepage**: https://github.com/weizhongli/cdhit
- **Package**: https://anaconda.org/channels/bioconda/packages/cd-hit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cd-hit/overview
- **Total Downloads**: 203.4K
- **Last updated**: 2025-04-24
- **GitHub**: https://github.com/weizhongli/cdhit
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:15b862e7da93f8f1e54cf68d1707236bf44861d53b60b4411651b75a3769577b: unpack entry: usr/local/lib/libstdc++.so.6.0.33: unpack to regular file: short write: write /tmp/build-temp-3118689322/rootfs/usr/local/lib/libstdc++.so.6.0.33: no space left on device
```


## Metadata
- **Skill**: generated

## cd-hit_cd-hit-est

### Tool Description
The provided text does not contain help information for cd-hit-est; it contains system error logs regarding a failed container build (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
- **Homepage**: https://github.com/weizhongli/cdhit
- **Package**: https://anaconda.org/channels/bioconda/packages/cd-hit/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:15b862e7da93f8f1e54cf68d1707236bf44861d53b60b4411651b75a3769577b: unpack entry: usr/local/lib/libstdc++.so.6.0.33: unpack to regular file: short write: write /tmp/build-temp-1130165529/rootfs/usr/local/lib/libstdc++.so.6.0.33: no space left on device
```

## cd-hit_cd-hit-2d

### Tool Description
The provided text does not contain help information for the tool. It is an error log indicating a failure to build or extract a container image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
- **Homepage**: https://github.com/weizhongli/cdhit
- **Package**: https://anaconda.org/channels/bioconda/packages/cd-hit/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:15b862e7da93f8f1e54cf68d1707236bf44861d53b60b4411651b75a3769577b: unpack entry: usr/local/lib/libstdc++.so.6.0.33: unpack to regular file: short write: write /tmp/build-temp-3924613891/rootfs/usr/local/lib/libstdc++.so.6.0.33: no space left on device
```

## cd-hit_cd-hit-est-2d

### Tool Description
CD-HIT: a fast program for clustering and comparing large sets of protein or nucleotide sequences (nucleotide version for comparing two datasets)

### Metadata
- **Docker Image**: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
- **Homepage**: https://github.com/weizhongli/cdhit
- **Package**: https://anaconda.org/channels/bioconda/packages/cd-hit/overview
- **Validation**: PASS

### Original Help Text
```text
====== CD-HIT version 4.8.1 (built on Apr 24 2025) ======

Usage: /usr/local/bin/cd-hit-est-2d [Options] 

Options

   -i	input filename for db1 in fasta format, required, can be in .gz format
   -i2	input filename for db2 in fasta format, required, can be in .gz format
   -j, -j2	input filename in fasta/fastq format for R2 reads if input are paired end (PE) files
 	 -i db1-R1.fq -j db1-R2.fq -i2 db2-R1.fq -j2 db2-R2.fq -o output_R1 -op output_R2 or
 	 -i db1-R1.fa -j db1-R2.fa -i2 db2-R1.fq -j2 db2-R2.fq -o output_R1 -op output_R2 
   -o	output filename, required
   -op	output filename for R2 reads if input are paired end (PE) files
   -c	sequence identity threshold, default 0.9
 	this is the default cd-hit's "global sequence identity" calculated as:
 	number of identical amino acids or bases in alignment
 	divided by the full length of the shorter sequence
   -G	use global sequence identity, default 1
 	if set to 0, then use local sequence identity, calculated as :
 	number of identical amino acids or bases in alignment
 	divided by the length of the alignment
 	NOTE!!! don't use -G 0 unless you use alignment coverage controls
 	see options -aL, -AL, -aS, -AS
   -b	band_width of alignment, default 20
   -M	memory limit (in MB) for the program, default 800; 0 for unlimitted;
   -T	number of threads, default 1; with 0, all CPUs will be used
   -n	word_length, default 10, see user's guide for choosing it
   -l	length of throw_away_sequences, default 10
   -d	length of description in .clstr file, default 20
 	if set to 0, it takes the fasta defline and stops at first space
   -s	length difference cutoff, default 0.0
 	if set to 0.9, the shorter sequences need to be
 	at least 90% length of the representative of the cluster
   -S	length difference cutoff in amino acid, default 999999
 	if set to 60, the length difference between the shorter sequences
 	and the representative of the cluster can not be bigger than 60
   -s2	length difference cutoff for db1, default 1.0
 	by default, seqs in db1 >= seqs in db2 in a same cluster
 	if set to 0.9, seqs in db1 may just >= 90% seqs in db2
   -S2	length difference cutoff, default 0
 	by default, seqs in db1 >= seqs in db2 in a same cluster
 	if set to 60, seqs in db2 may 60aa longer than seqs in db1
   -aL	alignment coverage for the longer sequence, default 0.0
 	if set to 0.9, the alignment must covers 90% of the sequence
   -AL	alignment coverage control for the longer sequence, default 99999999
 	if set to 60, and the length of the sequence is 400,
 	then the alignment must be >= 340 (400-60) residues
   -aS	alignment coverage for the shorter sequence, default 0.0
 	if set to 0.9, the alignment must covers 90% of the sequence
   -AS	alignment coverage control for the shorter sequence, default 99999999
 	if set to 60, and the length of the sequence is 400,
 	then the alignment must be >= 340 (400-60) residues
   -A	minimal alignment coverage control for the both sequences, default 0
 	alignment must cover >= this value for both sequences 
   -uL	maximum unmatched percentage for the longer sequence, default 1.0
 	if set to 0.1, the unmatched region (excluding leading and tailing gaps)
 	must not be more than 10% of the sequence
   -uS	maximum unmatched percentage for the shorter sequence, default 1.0
 	if set to 0.1, the unmatched region (excluding leading and tailing gaps)
 	must not be more than 10% of the sequence
   -U	maximum unmatched length, default 99999999
 	if set to 10, the unmatched region (excluding leading and tailing gaps)
 	must not be more than 10 bases
   -B	1 or 0, default 0, by default, sequences are stored in RAM
 	if set to 1, sequence are stored on hard drive
 	!! No longer supported !!
   -P	input paired end (PE) reads, default 0, single file
 	if set to 1, please use -i R1 -j R2 to input both PE files
   -cx	length to keep after trimming the tail of sequence, default 0, not trimming
 	if set to 50, the program only uses the first 50 letters of input sequence
   -cy	length to keep after trimming the tail of R2 sequence, default 0, not trimming
 	if set to 50, the program only uses the first 50 letters of input R2 sequence
 	e.g. -cx 100 -cy 80 for paired end reads
   -p	1 or 0, default 0
 	if set to 1, print alignment overlap in .clstr file
   -g	1 or 0, default 0
 	by cd-hit's default algorithm, a sequence is clustered to the first 
 	cluster that meet the threshold (fast cluster). If set to 1, the program
 	will cluster it into the most similar cluster that meet the threshold
 	(accurate but slow mode)
 	but either 1 or 0 won't change the representatives of final clusters
   -r	1 or 0, default 1, by default do both +/+ & +/- alignments
 	if set to 0, only +/+ strand alignment
   -mask	masking letters (e.g. -mask NX, to mask out both 'N' and 'X')
   -match	matching score, default 2 (1 for T-U and N-N)
   -mismatch	mismatching score, default -2
   -gap	gap opening score, default -6
   -gap-ext	gap extension score, default -1
   -bak	write backup cluster file (1 or 0, default 0)
   -h	print this help

   Questions, bugs, contact Weizhong Li at liwz@sdsc.edu
   For updated versions and information, please visit: http://cd-hit.org
                                                    or https://github.com/weizhongli/cdhit

   cd-hit web server is also available from http://cd-hit.org

   If you find cd-hit useful, please kindly cite:

   "CD-HIT: a fast program for clustering and comparing large sets of protein or nucleotide sequences", Weizhong Li & Adam Godzik. Bioinformatics, (2006) 22:1658-1659
   "CD-HIT: accelerated for clustering the next generation sequencing data", Limin Fu, Beifang Niu, Zhengwei Zhu, Sitao Wu & Weizhong Li. Bioinformatics, (2012) 28:3150-3152
```
## cd-hit_psi-cd-hit

### Tool Description
The provided text does not contain help information for the tool. It contains system log messages indicating a failure to build or extract a container image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
- **Homepage**: https://github.com/weizhongli/cdhit
- **Package**: https://anaconda.org/channels/bioconda/packages/cd-hit/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:15b862e7da93f8f1e54cf68d1707236bf44861d53b60b4411651b75a3769577b: unpack entry: usr/local/lib/libstdc++.so.6.0.33: unpack to regular file: short write: write /tmp/build-temp-1415838787/rootfs/usr/local/lib/libstdc++.so.6.0.33: no space left on device
```

## cd-hit_cd-hit-dup

### Tool Description
The provided text does not contain help information for the tool. It contains system error messages related to a container build failure (no space left on device).

### Metadata
- **Docker Image**: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
- **Homepage**: https://github.com/weizhongli/cdhit
- **Package**: https://anaconda.org/channels/bioconda/packages/cd-hit/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:15b862e7da93f8f1e54cf68d1707236bf44861d53b60b4411651b75a3769577b: unpack entry: usr/local/lib/libstdc++.so.6.0.33: unpack to regular file: short write: write /tmp/build-temp-3608599740/rootfs/usr/local/lib/libstdc++.so.6.0.33: no space left on device
```

## cd-hit_cd-hit-otu

### Tool Description
The provided text does not contain help information for the tool. It is an error log indicating a failure to build or extract a container image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
- **Homepage**: https://github.com/weizhongli/cdhit
- **Package**: https://anaconda.org/channels/bioconda/packages/cd-hit/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:15b862e7da93f8f1e54cf68d1707236bf44861d53b60b4411651b75a3769577b: unpack entry: usr/local/lib/libstdc++.so.6.0.33: unpack to regular file: short write: write /tmp/build-temp-1278059704/rootfs/usr/local/lib/libstdc++.so.6.0.33: no space left on device
```

## cd-hit_h-cd-hit

### Tool Description
The provided text does not contain help information for the tool. It is an error log indicating a failure to build or extract a container image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
- **Homepage**: https://github.com/weizhongli/cdhit
- **Package**: https://anaconda.org/channels/bioconda/packages/cd-hit/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:15b862e7da93f8f1e54cf68d1707236bf44861d53b60b4411651b75a3769577b: unpack entry: usr/local/lib/libstdc++.so.6.0.33: unpack to regular file: short write: write /tmp/build-temp-2035508378/rootfs/usr/local/lib/libstdc++.so.6.0.33: no space left on device
```

## cd-hit_clstr2txt.pl

### Tool Description
The provided text does not contain help information for the tool, but rather a system error log indicating a failure to build a container image due to lack of disk space. No arguments could be extracted from the provided text.

### Metadata
- **Docker Image**: quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13
- **Homepage**: https://github.com/weizhongli/cdhit
- **Package**: https://anaconda.org/channels/bioconda/packages/cd-hit/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cd-hit:4.8.1--h5ca1c30_13 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:15b862e7da93f8f1e54cf68d1707236bf44861d53b60b4411651b75a3769577b: unpack entry: usr/local/lib/libstdc++.so.6.0.33: unpack to regular file: short write: write /tmp/build-temp-3689498255/rootfs/usr/local/lib/libstdc++.so.6.0.33: no space left on device
```

