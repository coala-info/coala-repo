# maq CWL Generation Report

## maq_fasta2bfa

### Tool Description
N/A

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/maq/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/maqetta/maqetta
- **Stars**: N/A
### Original Help Text
```text
Usage: maq fasta2bfa <in.fasta> <out.bfa>
```


## maq_fastq2bfq

### Tool Description
Convert FASTQ to bfq format

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
fastq2bfq: invalid option -- '-'
fastq2bfq: invalid option -- 'h'
fastq2bfq: invalid option -- 'e'
fastq2bfq: invalid option -- 'l'
fastq2bfq: invalid option -- 'p'
Usage: maq fastq2bfq [-n nreads] <in.fastq> <out.prefix>|<out.bfq>
```


## maq_map

### Tool Description
Map reads to a reference genome

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   maq map [options] <out.map> <chr.bfa> <reads_1.bfq> [reads_2.bfq]

Options: -1 INT      length of the first read (<=127) [0]
         -2 INT      length of the second read (<=127) [0]
         -m FLOAT    rate of difference between reads and references [0.001]
         -e INT      maximum allowed sum of qualities of mismatches [70]
         -d FILE     adapter sequence file [null]
         -a INT      max distance between two paired reads [250]
         -A INT      max distance between two RF paired reads [0]
         -n INT      number of mismatches in the first 24bp [2]
         -M c|g      methylation alignment mode [null]
         -u FILE     dump unmapped and poorly aligned reads to FILE [null]
         -H FILE     dump multiple/all 01-mismatch hits to FILE [null]
         -C INT      max number of hits to output. >512 for all 01 hits. [250]
         -s INT      seed for random number generator [random]
         -W          disable Smith-Waterman alignment
         -t          trim all reads (usually not recommended)
         -c          match in the colorspace
```


## maq_mapmerge

### Tool Description
Merge multiple map files.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: maq mapmerge <out.map> <in1.map> <in2.map> [...]
```


## maq_rmdup

### Tool Description
Remove duplicate reads from a maq map file.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: maq rmdup <output.map> <input.map>
```


## maq_indelpe

### Tool Description
Estimate indel polymorphism rate

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: maq indelpe <in.ref.bfa> <in.aln.map>
```


## maq_indelsoa

### Tool Description
Detect indel candidates from alignments.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
indelsoa: invalid option -- '-'
indelsoa: invalid option -- 'h'
indelsoa: invalid option -- 'e'
indelsoa: invalid option -- 'l'
indelsoa: invalid option -- 'p'
Usage: maq indelsoa <ref.bfa> <align.map>
```


## maq_assemble

### Tool Description
Assemble genome sequences

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   maq assemble [options] <out.cns> <chr.bfa> <in.map>

Options: -r FLOAT    expected rate of heterozygotes [0.001]
         -t FLOAT    dependency coefficient (theta) [0.85]
         -q INT      minimum mapping quality [0]
         -Q INT      maximum sum of errors [60]
         -m INT      maximum number of mismatches [7]
         -N INT      number of haplotypes (>=2) [2]
         -s          use single-end mapping quality
         -p          discard abnormal pairs
```


## maq_glfgen

### Tool Description
Generate GLF file from maq assembly

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   maq assemble [options] <out.cns> <chr.bfa> <in.map>

Options: -r FLOAT    expected rate of heterozygotes [0.001]
         -t FLOAT    dependency coefficient (theta) [0.85]
         -q INT      minimum mapping quality [0]
         -Q INT      maximum sum of errors [60]
         -m INT      maximum number of mismatches [7]
         -N INT      number of haplotypes (>=2) [2]
         -s          use single-end mapping quality
         -p          discard abnormal pairs
```


## maq_sol2sanger

### Tool Description
Convert Sanger FASTQ to MAQ FASTQ

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: maq sol2sanger <in.fastq> <out.fastq>
```


## maq_mapass2maq

### Tool Description
Convert mapass2.map to maq.map format

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
maq mapass2maq <mapass2.map> <maq.map>
```


## maq_bfq2fastq

### Tool Description
Convert .bfq files to .fastq files

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: maq bfq2fastq <in.bfq> <out.fastq>
```


## maq_mapview

### Tool Description
View alignments in a map file

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
mapview: invalid option -- '-'
mapview: invalid option -- 'h'
mapview: invalid option -- 'e'
mapview: invalid option -- 'l'
mapview: invalid option -- 'p'
Usage: maq mapview [-bN] <in.map>
```


## maq_mapcheck

### Tool Description
Check mapping quality of reads.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   maq mapcheck [options] <chr.bfa> <in.map>
Options: -s         use single-end mapping qualities
         -Q INT     maximum sum of errors [60]
         -m INT     maximum number of mismatches [7]
         -q INT     minimum mapping quality [41]
         -S INT     quality scale [10]
         -P FILE    polymorphic sites [null]
         -c         print count instead of fraction
```


## maq_pileup

### Tool Description
Generate pileup from Maq alignments

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   maq pileup [options] <chr.bfa> <align.map>

Options: -Q INT    maximum sum of errors [60]
         -m INT    maximum number of mismatches [7]
         -q INT    minimum mapping quality [0]
         -l FILE   only output required positions [null]
         -s        use single-end mapping qualities
         -p        discard abnormal pairs
         -d        only show depth
         -v        verbose mode
         -P        print position on the read
```


## maq_cns2fq

### Tool Description
Convert consensus sequence to FASTQ format.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   maq cns2fq [options] <in.cns>

Options: -Q INT    minimum mapping quality [40]
         -n INT    minimum neighbouring quality [20]
         -d INT    minimum read depth [3]
         -D INT    maximum read depth [255]
```


## maq_cns2snp

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
maq: aux_utils.c:199: ma_cns2snp: Assertion `fp' failed.
```


## maq_snpreg

### Tool Description
Call SNPs using consensus and SNP information.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   maq snpreg [options] in.cns [in.snp]

Options: -Q INT    minimum mapping quality [40]
         -d INT    minimum read depth [3]
         -n INT    minimum neighbouring quality [20]
         -D INT    maximum read depth [255]
```


## maq_cns2view

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
maq: aux_utils.c:225: ma_cns2view: Assertion `fp' failed.
```


## maq_cns2ref

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
maq: aux_utils.c:185: ma_cns2ref: Assertion `fp' failed.
```


## maq_cns2win

### Tool Description
Convert consensus sequences to windowed format.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
cns2win: invalid option -- '-'
cns2win: invalid option -- 'h'
Usage: maq cns2win [-w 1000] [-b 0] [-e 0] [-c null] [-q 0] <in.cns>
```


## maq_fasta2csfa

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
maq: fasta2bfa.c:195: ma_fasta2csfa: Assertion `fp_fa' failed.
```


## maq_csmap2nt

### Tool Description
Convert cs.map to nt.map

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: maq csmap2nt <out.nt.map> <in.ref.nt.bfa> <in.cs.map>
```


## maq_simutrain

### Tool Description
Simulate reads from a reference genome.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: maq simutrain <simupars.dat> <known_reads.fastq>
```


## maq_simucns

### Tool Description
Simulate consensus sequences from true SNPs.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: maq simucns <in.cns> <in.true.snp>
```


## maq_simustat

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://github.com/maqetta/maqetta
- **Package**: Not found
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
maq: simulate.c:473: maq_simustat: Assertion `fp' failed.
```


## Metadata
- **Skill**: not generated
