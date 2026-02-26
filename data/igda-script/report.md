# igda-script CWL Generation Report

## igda-script_igda_pipe_detect

### Tool Description
Detects structural variants using IGDA pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/zhixingfeng/shell
- **Stars**: N/A
### Original Help Text
```text
Usage: igda_pipe_detect [options] infile(bam file) reffile contextmodel outdir

Input:
	infile should be sorted aligned bam file. This file should be obtained by igda_align_pb(igda_align_ont) and sam2bam.
	reffile is the reference fasta file.
	contextmodel is the pretrained model for context effect and can be obtained at https://github.com/zhixingfeng/igda_contextmodel.

Options:
	-n	Number of threads. [default = 1]
	-m	Method. "pb" for PacBio and "ont" for Oxford Nanopore. [default = "pb"]
	-f	Is using the fast calculation algorithm. 1 = yes and 0 = no. [default = 1]
	-g	Segment size(bp) to split each genome. [default = 20000]
	-l	Minimal read length (shorter reads will be excluded). [default = 1000]
	-r	Minimal depth for each SNV. [default = 25]
	-c	Minimal maximal conditional substitution rate. [default = 0.65]
	-p	Minimal substitution rate for orphan SNVs. [default = 0.1]
	-q	Number of most similar reads to construct subspaces. [default = 100]
	-x	The file that list the loci to be excluded.
	-s	Seed for permutation test (experimental). [default = 0, i.e. no permutation]
	-d	Minimal depth for each orphan SNV. [default = 15]
	-b	Minimal log-BF for each orphan SNV. [default = 10]
	-a	Is auto select parameters, 1=yes, 0=no. [default = 1]
```


## igda-script_igda_pipe_detect_pb

### Tool Description
Detects potential structural variations in sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
igda_pipe_detect_pb -s seed -n nthread -l min_readlen -r minimal_nreads_in_rsm -c min_condprob -p min_prob -q topn_cmpreads -x exclude_loci_file -f isfast infile(bam or sam file) reffile contextmodel outdir
default:
	-x (empty)
	-c 0.65
	-p 0.1
	-q 100
	-r 25
	-n 1
	-l 1000
	-s 18473
	-f 1
	-d 15
	-b 10
```


## igda-script_igda_pipe_detect_ont

### Tool Description
Detects ONT reads using IGDA pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
igda_pipe_detect_ont -s seed -n nthread -l min_readlen -r minimal_nreads_in_rsm -c min_condprob -p min_prob -q topn_cmpreads -x exclude_loci_file -f isfast infile(bam or sam file) reffile contextmodel outdir
default:
	-x (empty)
	-c 0.65
	-p 0.2
	-q 100
	-r 25
	-n 1
	-l 1000
	-s 18473
	-f 1
```


## igda-script_igda_pipe_phase

### Tool Description
Phase contigs using PacBio or Oxford Nanopore sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: igda_pipe_phase [options] indir reffile outdir

Input:
	indir is the output directory of igda_pipe_detect
	reffile is the reference fasta file.

Options:
	-m	Method. "pb" for PacBio and "ont" for Oxford Nanopore. [default = pb]
	-c	minimal coverage of each contig. [default = 10]
	-t	minimal number of nearest neighbors. [default = 25]
	-r	maximal number of nearest neighbors. [default = 50]
	-j	minimal jaccard index for find_nccontigs and tred. [default = 2.0]
	-b	maximal number of iteration in ANN. [default = 1]
	-n	number of threads. [default = 1]
```


## igda-script_igda_pipe_phase_pb

### Tool Description
Performs phasing of pangenome graphs.

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
igda_pipe_phase_pb -n nthread -b niter -c min_cvg -t min_nn -m max_nn indir reffile outdir
default:
	-c 10, minimal coverage of each contig
	-t 25, minimal number of nearest neighbors
	-m 50, maximal number of nearest neighbors
	-j 2.0, minimal jaccard index for find_nccontigs and tred
	-b maximal number of iteration in ANN, default = 1
	-n number of threads, default = 1
```


## igda-script_igda_pipe_phase_ont

### Tool Description
Phase ONT reads using IGDA

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
igda_pipe_phase_ont -n nthread -b niter -c min_cvg -t min_nn -m max_nn indir reffile outdir
default:
	-c 5, minimal coverage of each contig
	-t 25, minimal number of nearest neighbors
	-m 50, maximal number of nearest neighbors
	-j 2.0, minimal jaccard index for find_nccontigs and tred
	-b maximal number of iteration in ANN, default = 1
	-n number of threads, default = 1
```


## igda-script_igda_pipe_phase_diploid

### Tool Description
Phases diploid genomes using PacBio or Oxford Nanopore sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: igda_pipe_phase [options] indir reffile outdir

Input:
	indir is the output directory of igda_pipe_detect
	reffile is the reference fasta file.

Options:
	-m	Method. "pb" for PacBio and "ont" for Oxford Nanopore. [default = pb]
	-c	minimal coverage of each contig. [default = 10]
	-t	minimal number of nearest neighbors. [default = 25]
	-r	maximal number of nearest neighbors. [default = 50]
	-j	minimal jaccard index for find_nccontigs and tred. [default = 2.0]
	-b	maximal number of iteration in ANN. [default = 1]
	-n	number of threads. [default = 1]
```


## igda-script_igda_pipe_phase_pb_diploid

### Tool Description
Phase diploid genomes using long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
igda_pipe_phase_pb -n nthread -b niter -c min_cvg -t min_nn -m max_nn indir reffile outdir
default:
	-c 10, minimal coverage of each contig
	-t 25, minimal number of nearest neighbors
	-m 50, maximal number of nearest neighbors
	-j 2.0, minimal jaccard index for find_nccontigs and tred
	-b maximal number of iteration in ANN, default = 1
	-n number of threads, default = 1
```


## igda-script_add_gq_to_vcf

### Tool Description
Add GQ (Genotype Quality) to VCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
add_gq_to_vcf in_vcf_file out_vcf_file
```


## igda-script_split_range

### Tool Description
Splits a range into segments.

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
split_range start end segsize
```


## igda-script_getbambyregion

### Tool Description
Extract BAM alignments within a specified genomic region.

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
getbambyregion inbamfile outsamfile chr start end(1-based) nthread
```


## igda-script_getbambyregion_dir

### Tool Description
Get BAM files by region within a directory

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
getbambyregion_dir indir outdir chr start end(1-based) nthread logdir
```


## igda-script_fastq2fasta

### Tool Description
Converts FASTQ format to FASTA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: fastq2fasta fastqfile fastafile
```


## igda-script_est_depth

### Tool Description
only work for single chromosome data

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
est_depth bamfile(or samfile) genome_size outfile
only work for single chromosome data
```


## igda-script_est_depth_dir

### Tool Description
only work for single chromosome data

### Metadata
- **Docker Image**: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/zhixingfeng/shell
- **Package**: https://anaconda.org/channels/bioconda/packages/igda-script/overview
- **Validation**: PASS

### Original Help Text
```text
est_depth indir(has bamfiles) genome_size
only work for single chromosome data
```

