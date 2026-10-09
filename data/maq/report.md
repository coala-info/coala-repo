# maq CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| maq_assemble | PASS |  |
| maq_bfq2fastq | PASS |  |
| maq_cns2fq | PASS |  |
| maq_cns2ref | PASS |  |
| maq_cns2snp | PASS |  |
| maq_cns2view | PASS |  |
| maq_cns2win | PASS |  |
| maq_csmap2nt | PASS | synthetic data: real reads recoded to colour space (maq fasta2csfa reference), mapped with -c, then converted back; 3795 reads |
| maq_fakemut | PASS | synthetic mutations made by fakemut on the SARS-CoV-2 genome; output has the mutated FASTA and the mutation list |
| maq_fasta2bfa | PASS |  |
| maq_fasta2csfa | PASS |  |
| maq_fastq2bfq | PASS |  |
| maq_glfgen | PASS |  |
| maq_indelpe | PASS |  |
| maq_indelsoa | PASS |  |
| maq_map | PASS |  |
| maq_mapass2maq | Not completed | needs a map file from the retired mapass2 program; none is available and none can be made |
| maq_mapcheck | PASS |  |
| maq_mapmerge | PASS |  |
| maq_mapstat | PASS |  |
| maq_mapvalidate | PASS |  |
| maq_mapview | PASS |  |
| maq_pileup | PASS |  |
| maq_rmdup | PASS |  |
| maq_simucns | PASS | synthetic data: consensus from simulated reads checked against the true SNPs; error table is plausible |
| maq_simulate | PASS | synthetic data: reads simulated from the SARS-CoV-2 genome; true SNP list and read files written |
| maq_simustat | Failed | tool bug: maq simustat aborts with 'buffer overflow detected' on valid simulated alignments |
| maq_simutrain | PASS | trained on the real maq example reads; parameter file written |
| maq_snpreg | PASS |  |
| maq_sol2sanger | PASS |  |
| maq_submap | PASS |  |
| maq_subpos | PASS |  |

## maq_fasta2bfa

### Tool Description
N/A

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: https://maq.sourceforge.net/maq-man.shtml
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/maq/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://maq.sourceforge.net/maq-man.shtml
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

## maq_mapstat

### Tool Description
Statistics about a .map file

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: http://maq.sourceforge.net/
- **Package**: https://packages.debian.org/maq
- **Validation**: PASS

### Original Help Text
```text
Usage: maq mapstat <in.map>
```

## maq_cns2snp

### Tool Description
Extract details from a CNS file at the SNP sites

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: http://maq.sourceforge.net/
- **Package**: https://packages.debian.org/maq
- **Validation**: PASS

### Original Help Text
```text
Usage: maq cns2snp <in.cns>
```

## maq_cns2view

### Tool Description
Extract details from a CNS file at all sites

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: http://maq.sourceforge.net/
- **Package**: https://packages.debian.org/maq
- **Validation**: PASS

### Original Help Text
```text
Usage: maq cns2view <in.cns>
```

## maq_cns2ref

### Tool Description
Extract the reference sequences from a CNS file

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: http://maq.sourceforge.net/
- **Package**: https://packages.debian.org/maq
- **Validation**: PASS

### Original Help Text
```text
Usage: maq cns2ref <in.cns>
```

## maq_fasta2csfa

### Tool Description
Convert FASTA to colour-space FASTA

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: http://maq.sourceforge.net/
- **Package**: https://packages.debian.org/maq
- **Validation**: PASS

### Original Help Text
```text
Usage: maq fasta2csfa <in.fasta>
```

## maq_mapvalidate

### Tool Description
Validate a .map file

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: http://maq.sourceforge.net/
- **Package**: https://packages.debian.org/maq
- **Validation**: PASS

### Original Help Text
```text
Usage: maq mapvalidate <in.map>
```

## maq_fakemut

### Tool Description
Simulate references by randomly generating mutations

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: http://maq.sourceforge.net/
- **Package**: https://packages.debian.org/maq
- **Validation**: PASS

### Original Help Text
```text
Usage: maq fakemut [-r 0.001] [-R 0.1] <in.fasta>
```

## maq_simustat

### Tool Description
Evaluate alignment based on simulation

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: http://maq.sourceforge.net/
- **Package**: https://packages.debian.org/maq
- **Validation**: PASS

### Original Help Text
```text
Usage: maq simustat <simu_align.map> [<Q>=100]
```

## maq_subpos

### Tool Description
Extract a subset of positions

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: http://maq.sourceforge.net/
- **Package**: https://packages.debian.org/maq
- **Validation**: PASS

### Original Help Text
```text
Usage: maq subpos <in.cns> <.snp>
```

## maq_submap

### Tool Description
Extract a region from a map file

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: http://maq.sourceforge.net/
- **Package**: https://packages.debian.org/maq
- **Validation**: PASS

### Original Help Text
```text
Usage:   maq submap [options] <out.map> <in.map>

Options: -q INT      minimum mapping quality [10]
         -Q INT      maximum sum of errors [60]
         -m INT      maximum number of mismatches [3]
         -p          correctly paired reads only
```

## maq_simulate

### Tool Description
Simulate reads by randomly generating sequencing errors

### Metadata
- **Docker Image**: biocontainers/maq:v0.7.1-8-deb_cv1
- **Homepage**: http://maq.sourceforge.net/
- **Package**: https://packages.debian.org/maq
- **Validation**: PASS

### Original Help Text
```text
Usage:   maq simulate [options] <read1.out> <read2.out> <ref.fasta> <simupar.dat>

Options: -d INT        outer distance between the two ends [170]
         -s INT        standard deviation [20]
         -N INT        number of read pairs [1000000]
         -1 INT        length of the first read
         -2 INT        length of the second read
         -r FLOAT      rate of mutations [0.001]
         -R FLOAT      fraction of 1bp indels [0.1]
         -h            haploid mode
```

## Metadata
- **Skill**: generated
