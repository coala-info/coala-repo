# circlator CWL Generation Report

## circlator_all

### Tool Description
Run mapreads, bam2reads, assemble, merge, clean, fixstart

### Metadata
- **Docker Image**: biocontainers/circlator:v1.5.5-3-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/circlator
- **Package**: https://anaconda.org/channels/bioconda/packages/circlator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circlator/overview
- **Total Downloads**: 60.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/circlator
- **Stars**: N/A
### Original Help Text
```text
usage: circlator all [options] <assembly.fasta> <reads.fasta/q> <output directory>

Run mapreads, bam2reads, assemble, merge, clean, fixstart

positional arguments:
  assembly.fasta        Name of original assembly
  reads.fasta/q         Name of corrected reads FASTA or FASTQ file
  output directory      Name of output directory (must not already exist)

optional arguments:
  -h, --help            show this help message and exit
  --threads INT         Number of threads [1]
  --verbose             Be verbose
  --unchanged_code INT  Code to return when the input assembly is not changed
                        [0]
  --assembler {canu,spades}
                        Assembler to use for reassemblies [spades]
  --split_all_reads     By default, reads mapped to shorter contigs are left
                        unchanged. This option splits them into two, broken at
                        the middle of the contig to try to force
                        circularization. May help if the assembler does not
                        detect circular contigs (eg canu)
  --data_type {pacbio-raw,pacbio-corrected,nanopore-raw,nanopore-corrected}
                        String representing one of the 4 type of data analysed
                        (only used for Canu) [pacbio-corrected]
  --assemble_spades_k k1,k2,k3,...
                        Comma separated list of kmers to use when running
                        SPAdes. Max kmer is 127 and each kmer should be an odd
                        integer [127,117,107,97,87,77]
  --assemble_spades_use_first
                        Use the first successful SPAdes assembly. Default is
                        to try all kmers and use the assembly with the largest
                        N50
  --assemble_not_careful
                        Do not use the --careful option with SPAdes (used by
                        default)
  --assemble_not_only_assembler
                        Do not use the --assemble-only option with SPAdes
                        (used by default). Important: with this option, the
                        input reads must be in FASTQ format, otherwise SPAdes
                        will crash because it needs quality scores to correct
                        the reads.

mapreads options:
  --bwa_opts STRING     BWA options, in quotes [-x pacbio]

bam2reads options:
  --b2r_discard_unmapped
                        Use this to not keep unmapped reads
  --b2r_only_contigs FILENAME
                        File of contig names (one per line). Only reads that
                        map to these contigs are kept (and unmapped reads,
                        unless --b2r_discard_unmapped is used). Note: the
                        whole assembly is still used as a reference when
                        mapping
  --b2r_length_cutoff INT
                        All reads mapped to contigs shorter than this will be
                        kept [100000]
  --b2r_min_read_length INT
                        Minimum length of read to output [250]

merge options:
  --merge_diagdiff INT  Nucmer diagdiff option [25]
  --merge_min_id FLOAT  Nucmer minimum percent identity [95]
  --merge_min_length INT
                        Minimum length of hit for nucmer to report [500]
  --merge_min_length_merge INT
                        Minimum length of nucmer hit to use when merging
                        [4000]
  --merge_min_spades_circ_pc FLOAT
                        Min percent of contigs needed to be covered by nucmer
                        hits to spades circular contigs [95]
  --merge_breaklen INT  breaklen option used by nucmer [500]
  --merge_ref_end INT   max distance allowed between nucmer hit and end of
                        input assembly contig [15000]
  --merge_reassemble_end INT
                        max distance allowed between nucmer hit and end of
                        reassembly contig [1000]
  --no_pair_merge       Do not merge pairs of contigs when running merge task

clean options:
  --clean_min_contig_length INT
                        Contigs shorter than this are discarded (unless
                        specified using --keep) [2000]
  --clean_min_contig_percent FLOAT
                        If length of nucmer hit is at least this percentage of
                        length of contig, then contig is removed. (unless
                        specified using --keep) [95]
  --clean_diagdiff INT  Nucmer diagdiff option [25]
  --clean_min_nucmer_id FLOAT
                        Nucmer minimum percent identity [95]
  --clean_min_nucmer_length INT
                        Minimum length of hit for nucmer to report [500]
  --clean_breaklen INT  breaklen option used by nucmer [500]

fixstart options:
  --genes_fa FILENAME   FASTA file of genes to search for to use as start
                        point. If this option is not used, a built-in set of
                        dnaA genes is used
  --fixstart_mincluster INT
                        The -c|mincluster option of promer. If this option is
                        used, it overrides promer's default value
  --fixstart_min_id FLOAT
                        Minimum percent identity of promer match between
                        contigs and gene(s) to use as start point [70]
```


## circlator_mapreads

### Tool Description
Map reads using bwa mem

### Metadata
- **Docker Image**: biocontainers/circlator:v1.5.5-3-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/circlator
- **Package**: https://anaconda.org/channels/bioconda/packages/circlator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: circlator mapreads [options] <reference.fasta> <reads.fasta> <out.bam>

Map reads using bwa mem

positional arguments:
  reference.fasta    Name of input reference FASTA file
  reads.fasta        Name of corrected reads FASTA file
  out.bam            Name of output BAM file

optional arguments:
  -h, --help         show this help message and exit
  --bwa_opts STRING  BWA options, in quotes [-x pacbio]
  --threads INT      Number of threads [1]
  --verbose          Be verbose
```


## circlator_bam2reads

### Tool Description
Make reads from mapping to be reassembled

### Metadata
- **Docker Image**: biocontainers/circlator:v1.5.5-3-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/circlator
- **Package**: https://anaconda.org/channels/bioconda/packages/circlator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: circlator bam2reads [options] <in.bam> <outprefix>

Make reads from mapping to be reassembled

positional arguments:
  in.bam                Name of input bam file
  outprefix             Prefix of output filenames

optional arguments:
  -h, --help            show this help message and exit
  --discard_unmapped    Use this to not keep unmapped reads
  --fastq               Write fastq output (if quality scores are present in
                        input BAM file)
  --only_contigs FILENAME
                        File of contig names (one per line). Only reads that
                        map to these contigs are kept (and unmapped reads,
                        unless --discard_unmapped is used).
  --length_cutoff INT   All reads mapped to contigs shorter than this will be
                        kept [100000]
  --min_read_length INT
                        Minimum length of read to output [250]
  --split_all_reads     By default, reads mapped to shorter contigs are left
                        unchanged. This option splits them into two, broken at
                        the middle of the contig to try to force
                        circularization. May help if the assembler does not
                        detect circular contigs (eg canu)
  --verbose             Be verbose
```


## circlator_assemble

### Tool Description
Assemble reads using SPAdes/Canu

### Metadata
- **Docker Image**: biocontainers/circlator:v1.5.5-3-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/circlator
- **Package**: https://anaconda.org/channels/bioconda/packages/circlator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: circlator assemble [options] <in.reads.fasta> <out_dir>

Assemble reads using SPAdes/Canu

positional arguments:
  in.reads.fasta        Name of input reads FASTA file
  out_dir               Output directory (must not already exist)

optional arguments:
  -h, --help            show this help message and exit
  --not_careful         Do not use the --careful option with SPAdes (used by
                        default)
  --not_only_assembler  Do not use the --assemble-only option with SPAdes
                        (used by default)
  --threads INT         Number of threads [1]
  --verbose             Be verbose
  --spades_k k1,k2,k3,...
                        Comma separated list of kmers to use when running
                        SPAdes. Max kmer is 127 and each kmer should be an odd
                        integer [127,117,107,97,87,77]
  --spades_use_first    Use the first successful SPAdes assembly. Default is
                        to try all kmers and use the assembly with the largest
                        N50
  --assembler {canu,spades}
                        Assembler to use for reassemblies [spades]
  --data_type {pacbio-raw,pacbio-corrected,nanopore-raw,nanopore-corrected}
                        String representing one of the 4 type of data analysed
                        (only used for Canu) [pacbio-corrected]
```


## circlator_merge

### Tool Description
Merge original and new assembly

### Metadata
- **Docker Image**: biocontainers/circlator:v1.5.5-3-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/circlator
- **Package**: https://anaconda.org/channels/bioconda/packages/circlator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: circlator merge [options] <original.fasta> <new.fasta> <outprefix>

Merge original and new assembly

positional arguments:
  original.fasta        Name of original assembly
  new.fasta             Name of new assembly
  outprefix             Prefix of output files

optional arguments:
  -h, --help            show this help message and exit
  --diagdiff INT        Nucmer diagdiff option [25]
  --min_id FLOAT        Nucmer minimum percent identity [95]
  --min_length INT      Minimum length of hit for nucmer to report [500]
  --min_length_merge INT
                        Minimum length of nucmer hit to use when merging
                        [4000]
  --breaklen INT        breaklen option used by nucmer [500]
  --min_spades_circ_pc FLOAT
                        Min percent of contigs needed to be covered by nucmer
                        hits to spades circular contigs [95]
  --assemble_not_careful
                        Do not use the --careful option with SPAdes (used by
                        default)
  --assemble_not_only_assembler
                        Do not use the --assemble-only option with SPAdes
                        (used by default)
  --spades_k k1,k2,k3,...
                        Comma separated list of kmers to use when running
                        SPAdes. Max kmer is 127 and each kmer should be an odd
                        integer [127,117,107,97,87,77]
  --spades_use_first    Use the first successful SPAdes assembly. Default is
                        to try all kmers and use the assembly with the largest
                        N50
  --assembler {canu,spades}
                        Assembler to use for reassemblies [spades]
  --data_type {pacbio-raw,pacbio-corrected,nanopore-raw,nanopore-corrected}
                        String representing one of the 4 type of data analysed
                        (only used for Canu) [pacbio-corrected]
  --b2r_length_cutoff INT
                        All reads mapped to contigs shorter than this will be
                        kept [100000]
  --b2r_split_all_reads
                        By default, reads mapped to shorter contigs are left
                        unchanged. This option splits them into two, broken at
                        the middle of the contig to try to force
                        circularization. May help if the assembler does not
                        detect circular contigs (eg canu)
  --ref_end INT         max distance allowed between nucmer hit and end of
                        input assembly contig [15000]
  --reassemble_end INT  max distance allowed between nucmer hit and end of
                        reassembly contig [1000]
  --threads INT         Number of threads for remapping/assembly (only applies
                        if --reads is used) [1]
  --reads FILENAME      FASTA file of corrected reads that made the new
                        assembly. Using this triggers iterative contig pair
                        merging
  --verbose             Be verbose
```


## circlator_clean

### Tool Description
Clean contigs

### Metadata
- **Docker Image**: biocontainers/circlator:v1.5.5-3-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/circlator
- **Package**: https://anaconda.org/channels/bioconda/packages/circlator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: circlator clean [options] <in.fasta> <outprefix>

Clean contigs

positional arguments:
  in.fasta              Name of input FASTA file
  outprefix             Prefix of output files

optional arguments:
  -h, --help            show this help message and exit
  --min_contig_length INT
                        Contigs shorter than this are discarded (unless
                        specified using --keep) [2000]
  --min_contig_percent FLOAT
                        If length of nucmer hit is at least this percentage of
                        length of contig, then contig is removed. (unless
                        specified using --keep) [95]
  --diagdiff INT        Nucmer diagdiff option [25]
  --min_nucmer_id FLOAT
                        Nucmer minimum percent identity [95]
  --min_nucmer_length INT
                        Minimum length of hit for nucmer to report [500]
  --breaklen INT        breaklen option used by nucmer [500]
  --keep FILENAME       File of contig names to keep in output file
  --verbose             Be verbose
```


## circlator_fixstart

### Tool Description
Change start point of each sequence in assembly

### Metadata
- **Docker Image**: biocontainers/circlator:v1.5.5-3-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/circlator
- **Package**: https://anaconda.org/channels/bioconda/packages/circlator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: circlator fixstart [options] <assembly.fasta> <outprefix>

Change start point of each sequence in assembly

positional arguments:
  assembly.fasta       Name of input FASTA file
  outprefix            Prefix of output files

optional arguments:
  -h, --help           show this help message and exit
  --genes_fa FILENAME  FASTA file of genes to search for to use as start
                       point. If this option is not used, a built-in set of
                       dnaA genes is used
  --ignore FILENAME    Absolute path to file of IDs of contigs to not change
  --mincluster INT     The -c|mincluster option of promer. If this option is
                       used, it overrides promer's default value
  --min_id FLOAT       Minimum percent identity of promer match between
                       contigs and gene(s) to use as start point [70]
  --verbose            Be verbose
```


## circlator_minimus2

### Tool Description
Runs minimus2 circularisation pipeline, see https://github.com/PacificBiosciences/Bioinformatics-Training/wiki/Circularising-and-trimming ... this script is a modified version of that protocol. It first runs minimus2 on the input contigs (unless --no_pre_merge is used). Then it tries to circularise each contig one at a time, by breaking it in the middle and using the two pieces as input to minimus2. If minimus2 outputs one contig, then that new one is assumed to be circularised and is kept, otherwise the original contig is kept.

### Metadata
- **Docker Image**: biocontainers/circlator:v1.5.5-3-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/circlator
- **Package**: https://anaconda.org/channels/bioconda/packages/circlator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: circlator minimus2 [options] <assembly.fasta> <output prefix>

Runs minimus2 circularisation pipeline, see
https://github.com/PacificBiosciences/Bioinformatics-
Training/wiki/Circularizing-and-trimming ... this script is a modified version
of that protocol. It first runs minimus2 on the input contigs (unless
--no_pre_merge is used). Then it tries to circularise each contig one at a
time, by breaking it in the middle and using the two pieces as input to
minimus2. If minimus2 outputs one contig, then that new one is assumed to be
circularised and is kept, otherwise the original contig is kept.

positional arguments:
  assembly.fasta  Name of original assembly
  output prefix   Prefix of output files

optional arguments:
  -h, --help      show this help message and exit
  --no_pre_merge  Do not do initial minimus2 run before trying to circularise
                  each contig
```


## circlator_get_dnaa

### Tool Description
Downloads and filters a file of dnaA (or other) genes from uniprot

### Metadata
- **Docker Image**: biocontainers/circlator:v1.5.5-3-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/circlator
- **Package**: https://anaconda.org/channels/bioconda/packages/circlator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: circlator get_dnaa [options] <output prefix>

Downloads and filters a file of dnaA (or other) genes from uniprot

positional arguments:
  output prefix         Prefix of output files

optional arguments:
  -h, --help            show this help message and exit
  --min_length INT      Minimum length in amino acids [333]
  --max_length INT      Maximum length in amino acids [500]
  --uniprot_search STRING
                        Uniprot search term [dnaa]
  --name_re STRING      Each sequence name must match this regular expression
                        [Chromosomal replication initiat(or|ion)
                        protein.*dnaa]
  --name_re_case_sensitive
                        Do a case-sensitive match to regular expression given
                        by --name_re. Default is to ignore case.
```


## circlator_progcheck

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/circlator:v1.5.5-3-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/circlator
- **Package**: https://anaconda.org/channels/bioconda/packages/circlator/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Circlator version: 1.5.5

External dependencies:
bwa	0.7.17	/usr/bin/bwa
WARNING: Didn't find canu in path. Looked for:canu
nucmer	3.1	/usr/bin/nucmer
prodigal	2.6.3	/usr/bin/prodigal
samtools	1.9	/usr/bin/samtools
spades	3.13.0	/usr/bin/spades.py

Python version:
3.7.3 (default, Apr  3 2019, 05:39:12) 
[GCC 8.3.0]

Python dependencies:
openpyxl	2.4.9	/usr/lib/python3/dist-packages/openpyxl/__init__.py
pyfastaq	3.17.0	/usr/lib/python3/dist-packages/pyfastaq/__init__.py
pymummer	0.10.3	/usr/lib/python3/dist-packages/pymummer/__init__.py
pysam	0.15.2	/usr/lib/python3/dist-packages/pysam/__init__.py
```


## circlator_test

### Tool Description
Run Circlator on a small test dataset

### Metadata
- **Docker Image**: biocontainers/circlator:v1.5.5-3-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/circlator
- **Package**: https://anaconda.org/channels/bioconda/packages/circlator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ariba test [options] <outdir>

Run Circlator on a small test dataset

positional arguments:
  outdir         Name of output directory

optional arguments:
  -h, --help     show this help message and exit
  --threads INT  Number of threads [1]
```


## circlator_version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/circlator:v1.5.5-3-deb_cv1
- **Homepage**: https://github.com/sanger-pathogens/circlator
- **Package**: https://anaconda.org/channels/bioconda/packages/circlator/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
1.5.5
```

