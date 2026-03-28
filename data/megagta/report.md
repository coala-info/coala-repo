# megagta CWL Generation Report

## megagta_buildlib

### Tool Description
Build a library from read files.

### Metadata
- **Docker Image**: quay.io/biocontainers/megagta:0.1_alpha--0
- **Homepage**: https://github.com/HKU-BAL/MegaGTA
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/megagta/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/HKU-BAL/MegaGTA
- **Stars**: N/A
### Original Help Text
```text
Usage buildlib <read_lib_file> <out_prefix>
```


## megagta_buildgraph

### Tool Description
Builds a de Bruijn graph from sequencing reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/megagta:0.1_alpha--0
- **Homepage**: https://github.com/HKU-BAL/MegaGTA
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
buildgraph: option '--host_mem' requires an argument
uknown option
Usage: sdbg_builder read2sdbg --read_lib_file fastx_file -o out
Options:
  -k, --kmer_k arg (=21)                 kmer size
  -m, --min_kmer_frequency arg (=2)      min frequency to output an edge
      --host_mem arg (=0)                Max memory to be used. 90% of the free memory is recommended.
      --gpu_mem arg (=0)                 gpu memory to be used. 0 for auto detect.
      --num_cpu_threads arg (=0)         number of CPU threads. At least 2.
      --num_output_threads arg (=0)      number of threads for output. Must be less than num_cpu_threads
      --read_lib_file arg                input fast[aq] file, can be gzip'ed. "-" for stdin.
      --assist_seq arg                   input assisting fast[aq] file (FILE_NAME.info should exist), can be gzip'ed.
      --output_prefix arg (=out)         output prefix
      --mem_flag arg (=1)                memory options. 0: minimize memory usage; 1: automatically use moderate memory; other: use all available mem specified by '--host_mem'
      --need_mercy                       to add mercy edges.
```


## megagta_denovo

### Tool Description
no succinct de Bruijn graph name!

### Metadata
- **Docker Image**: quay.io/biocontainers/megagta:0.1_alpha--0
- **Homepage**: https://github.com/HKU-BAL/MegaGTA
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
no succinct de Bruijn graph name!
Usage: denovo -s sdbg_name -o output_prefix
options:
  -s, --sdbg_name arg                    succinct de Bruijn graph name
  -o, --output_prefix arg (=out)         output prefix
  -t, --num_cpu_threads arg (=0)         number of cpu threads
      --max_tip_len arg (=-1)            max length for tips to be removed. -1 for 2k
      --no_bubble                        do not remove bubbles
      --min_standalone arg (=400)        min length of a standalone contig to output to final.contigs.fa
      --min_contig arg (=0)              min length of contig to output
```


## megagta_findstart

### Tool Description
Find the start of the first exon in a gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/megagta:0.1_alpha--0
- **Homepage**: https://github.com/HKU-BAL/MegaGTA
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
File --help doesn't exist
```


## megagta_search

### Tool Description
Search for genes in a de Bruijn graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/megagta:0.1_alpha--0
- **Homepage**: https://github.com/HKU-BAL/MegaGTA
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: search <succinct_dbg> <gene_list> <starting_kmers_prefix> <output_prefix> <prune_len> <low_cov_penalty> [num_threads=0]
```


## megagta_dumpversion

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/megagta:0.1_alpha--0
- **Homepage**: https://github.com/HKU-BAL/MegaGTA
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
v0.1-alpha
```


## megagta_readstat

### Tool Description
Reads FASTQ files from standard input.

### Metadata
- **Docker Image**: quay.io/biocontainers/megagta:0.1_alpha--0
- **Homepage**: https://github.com/HKU-BAL/MegaGTA
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: cat *.fq | readstat
```


## megagta_filterbylen

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/megagta:0.1_alpha--0
- **Homepage**: https://github.com/HKU-BAL/MegaGTA
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
0 contigs, total 0 bp, min 0 bp, max 0 bp, avg 0 bp, N50 0 bp
```


## Metadata
- **Skill**: generated
