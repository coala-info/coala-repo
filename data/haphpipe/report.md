# haphpipe CWL Generation Report

## haphpipe_sample_reads

### Tool Description
Sample reads from fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Total Downloads**: 12.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gwcbi/haphpipe
- **Stars**: N/A
### Original Help Text
```text
usage: haphpipe sample_reads [-h] [--fq1 FQ1] [--fq2 FQ2] [--fqU FQU]
                             [--outdir OUTDIR] (--nreads NREADS | --frac FRAC)
                             [--seed SEED] [--quiet] [--logfile LOGFILE]
                             [--debug]

optional arguments:
  -h, --help         show this help message and exit

Input/Output:
  --fq1 FQ1          Fastq file with read 1
  --fq2 FQ2          Fastq file with read 2
  --fqU FQU          Fastq file with unpaired reads
  --outdir OUTDIR    Output directory (default: .)

Sample options:
  --nreads NREADS    Number of reads to sample. If greater than the number of
                     reads in file, all reads will be sampled.
  --frac FRAC        Fraction of reads to sample, between 0 and 1. Each read
                     has [frac] probability of being sampled, so number of
                     sampled reads is not precisely [frac * num_reads].
  --seed SEED        Seed for random number generator.

Settings:
  --quiet            Do not write output to console (silence stdout and
                     stderr) (default: False)
  --logfile LOGFILE  Append console output to this file
  --debug            Print commands but do not run (default: False)
```


## haphpipe_trim_reads

### Tool Description
Trims adapter sequences and low-quality bases from FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe trim_reads [-h] [--fq1 FQ1] [--fq2 FQ2] [--fqU FQU]
                           [--outdir OUTDIR] [--adapter_file ADAPTER_FILE]
                           [--trimmers TRIMMERS]
                           [--encoding {Phred+33,Phred+64}] [--ncpu NCPU]
                           [--quiet] [--logfile LOGFILE] [--debug]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --fq1 FQ1             Fastq file with read 1
  --fq2 FQ2             Fastq file with read 1
  --fqU FQU             Fastq file with unpaired reads
  --outdir OUTDIR       Output directory (default: .)

Trimmomatic options:
  --adapter_file ADAPTER_FILE
                        Adapter file
  --trimmers TRIMMERS   Trim commands for trimmomatic (default: ['LEADING:3',
                        'TRAILING:3', 'SLIDINGWINDOW:4:15', 'MINLEN:36'])
  --encoding {Phred+33,Phred+64}
                        Quality score encoding

Settings:
  --ncpu NCPU           Number of CPU to use (default: 1)
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Append console output to this file
  --debug               Print commands but do not run (default: False)
```


## haphpipe_join_reads

### Tool Description
Joins paired-end reads using FLASH.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe join_reads [-h] --fq1 FQ1 --fq2 FQ2 [--outdir OUTDIR]
                           [--min_overlap MIN_OVERLAP]
                           [--max_overlap MAX_OVERLAP] [--allow_outies]
                           [--encoding ENCODING] [--ncpu NCPU] [--keep_tmp]
                           [--quiet] [--logfile LOGFILE] [--debug]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --fq1 FQ1             Fastq file with read 1
  --fq2 FQ2             Fastq file with read 1
  --outdir OUTDIR       Output directory

FLAsh settings:
  --min_overlap MIN_OVERLAP
                        The minimum required overlap length between two reads
                        to provide a confident overlap. (default: 10)
  --max_overlap MAX_OVERLAP
                        Maximum overlap length expected in approximately 90
                        pct of read pairs, longer overlaps are penalized.
  --allow_outies        Also try combining read pairs in the "outie"
                        orientation (default: False)
  --encoding ENCODING   Quality score encoding

Settings:
  --ncpu NCPU           Number of CPU to use
  --keep_tmp            Keep temporary directory (default: False)
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Append console output to this file
  --debug               Print commands but do not run (default: False)
```


## haphpipe_ec_reads

### Tool Description
Extracts reads from FASTQ files based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe ec_reads [-h] [--fq1 FQ1] [--fq2 FQ2] [--fqU FQU]
                         [--outdir OUTDIR] [--ncpu NCPU] [--keep_tmp]
                         [--quiet] [--logfile LOGFILE] [--debug]

optional arguments:
  -h, --help         show this help message and exit

Input/Output:
  --fq1 FQ1          Fastq file with read 1
  --fq2 FQ2          Fastq file with read 2
  --fqU FQU          Fastq file with unpaired reads
  --outdir OUTDIR    Output directory

Settings:
  --ncpu NCPU        Number of CPU to use (default: 1)
  --keep_tmp         Keep temporary directory (default: False)
  --quiet            Do not write output to console (silence stdout and
                     stderr) (default: False)
  --logfile LOGFILE  Append console output to this file
  --debug            Print commands but do not run (default: False)
```


## haphpipe_assemble_denovo

### Tool Description
De novo assembly using Haphpipe

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe assemble_denovo [-h] [--fq1 FQ1] [--fq2 FQ2] [--fqU FQU]
                                [--outdir OUTDIR] [--no_error_correction]
                                [--subsample SUBSAMPLE] [--seed SEED]
                                [--ncpu NCPU] [--keep_tmp] [--quiet]
                                [--logfile LOGFILE] [--debug]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --fq1 FQ1             Fastq file with read 1
  --fq2 FQ2             Fastq file with read 2
  --fqU FQU             Fastq file with unpaired reads
  --outdir OUTDIR       Output directory (default: .)

Assembly options:
  --no_error_correction
                        Do not perform error correction [spades only]
                        (default: False)
  --subsample SUBSAMPLE
                        Use a subsample of reads for assembly.
  --seed SEED           Seed for random number generator (ignored if not
                        subsampling).

Settings:
  --ncpu NCPU           Number of CPU to use (default: 1)
  --keep_tmp            Keep temporary directory (default: False)
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Append console output to this file
  --debug               Print commands but do not run (default: False)
```


## haphpipe_assemble_amplicons

### Tool Description
Assemble amplicons using HAPHPipe.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe assemble_amplicons [-h] --contigs_fa CONTIGS_FA --ref_fa
                                   REF_FA --ref_gtf REF_GTF [--outdir OUTDIR]
                                   [--sample_id SAMPLE_ID] [--padding PADDING]
                                   [--min_contig_len MIN_CONTIG_LEN]
                                   [--keep_tmp] [--quiet] [--logfile LOGFILE]
                                   [--debug]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --contigs_fa CONTIGS_FA
                        Fasta file with assembled contigs
  --ref_fa REF_FA       Fasta file with reference genome to scaffold against
  --ref_gtf REF_GTF     GTF format file containing amplicon regions
  --outdir OUTDIR       Output directory (default: .)

Scaffold options:
  --sample_id SAMPLE_ID
                        Sample ID. (default: sampleXX)
  --padding PADDING     Bases to include outside reference annotation.
                        (default: 50)
  --min_contig_len MIN_CONTIG_LEN
                        Minimum contig length for tiling path (default: 200)

Settings:
  --keep_tmp            Additional options (default: False)
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Append console output to this file
  --debug               Print commands but do not run (default: False)
```


## haphpipe_assemble_scaffold

### Tool Description
Assemble and scaffold contigs using a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe assemble_scaffold [-h] --contigs_fa CONTIGS_FA --ref_fa REF_FA
                                  [--outdir OUTDIR] [--seqname SEQNAME]
                                  [--keep_tmp] [--quiet] [--logfile LOGFILE]
                                  [--debug]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --contigs_fa CONTIGS_FA
                        Fasta file with assembled contigs
  --ref_fa REF_FA       Fasta file with reference genome to scaffold against
  --outdir OUTDIR       Output directory (default: .)

Scaffold options:
  --seqname SEQNAME     Name to append to scaffold sequence. (default:
                        sample01)

Settings:
  --keep_tmp            Additional options (default: False)
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Append console output to this file
  --debug               Print commands but do not run (default: False)
```


## haphpipe_align_reads

### Tool Description
Align reads to a reference genome using Bowtie2.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe align_reads [-h] [--fq1 FQ1] [--fq2 FQ2] [--fqU FQU] --ref_fa
                            REF_FA [--outdir OUTDIR]
                            [--bt2_preset {very-fast,fast,sensitive,very-sensitive,very-fast-local,fast-local,sensitive-local,very-sensitive-local}]
                            [--sample_id SAMPLE_ID] [--no_realign]
                            [--remove_duplicates]
                            [--encoding {Phred+33,Phred+64}] [--ncpu NCPU]
                            [--xmx XMX] [--keep_tmp] [--quiet]
                            [--logfile LOGFILE] [--debug]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --fq1 FQ1             Fastq file with read 1
  --fq2 FQ2             Fastq file with read 2
  --fqU FQU             Fastq file with unpaired reads
  --ref_fa REF_FA       Reference fasta file.
  --outdir OUTDIR       Output directory (default: .)

Alignment options:
  --bt2_preset {very-fast,fast,sensitive,very-sensitive,very-fast-local,fast-local,sensitive-local,very-sensitive-local}
                        Bowtie2 preset (default: sensitive-local)
  --sample_id SAMPLE_ID
                        Sample ID. Used as read group ID in BAM (default:
                        sampleXX)
  --no_realign          Do not realign indels (default: False)
  --remove_duplicates   Remove duplicates from final alignment. Otherwise
                        duplicates are marked but not removed. (default:
                        False)
  --encoding {Phred+33,Phred+64}
                        Quality score encoding

Settings:
  --ncpu NCPU           Number of CPUs to use (default: 1)
  --xmx XMX             Maximum heap size for Java VM, in GB. (default: 32)
  --keep_tmp            Do not delete temporary directory (default: False)
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Append console output to this file
  --debug               Print commands but do not run (default: False)
```


## haphpipe_call_variants

### Tool Description
Call variants using HaplotypeCaller.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe call_variants [-h] --aln_bam ALN_BAM --ref_fa REF_FA
                              [--outdir OUTDIR] [--emit_all]
                              [--min_base_qual MIN_BASE_QUAL] [--ncpu NCPU]
                              [--xmx XMX] [--keep_tmp] [--quiet]
                              [--logfile LOGFILE] [--debug]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --aln_bam ALN_BAM     Alignment file.
  --ref_fa REF_FA       Reference fasta file.
  --outdir OUTDIR       Output directory (default: .)

Variant calling options:
  --emit_all            Output calls for all sites. (default: False)
  --min_base_qual MIN_BASE_QUAL
                        Minimum base quality required to consider a base for
                        calling. (default: 15)

Settings:
  --ncpu NCPU           Number of CPU to use
  --xmx XMX             Maximum heap size for Java VM, in GB. (default: 32)
  --keep_tmp            Do not delete temporary directory (default: False)
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Append console output to this file
  --debug               Print commands but do not run (default: False)
```


## haphpipe_vcf_to_consensus

### Tool Description
Convert VCF to consensus sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe vcf_to_consensus [-h] --vcf VCF [--outdir OUTDIR]
                                 [--sampidx SAMPIDX] [--min_dp MIN_DP]
                                 [--major MAJOR] [--minor MINOR] [--keep_tmp]
                                 [--quiet] [--logfile LOGFILE]

optional arguments:
  -h, --help         show this help message and exit

Input/Output:
  --vcf VCF          VCF file (created with all sites).
  --outdir OUTDIR    Output directory (default: .)
  --sampidx SAMPIDX  Index for sample if multi-sample VCF (default: 0)

Variant options:
  --min_dp MIN_DP    Minimum depth to call site (default: 5)
  --major MAJOR      Allele fraction to make unambiguous call (default: 0.5)
  --minor MINOR      Allele fraction to make ambiguous call (default: 0.2)

Settings:
  --keep_tmp         Do not delete temporary directory (default: False)
  --quiet            Do not write output to console (silence stdout and
                     stderr) (default: False)
  --logfile LOGFILE  Append console output to this file
```


## haphpipe_finalize_assembly

### Tool Description
Finalize assembly by mapping reads to consensus and fixing consensus.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe finalize_assembly [-h] [--fq1 FQ1] [--fq2 FQ2] [--fqU FQU]
                                  --ref_fa REF_FA [--outdir OUTDIR]
                                  [--bt2_preset {very-fast,fast,sensitive,very-sensitive,very-fast-local,fast-local,sensitive-local,very-sensitive-local}]
                                  [--sample_id SAMPLE_ID] [--ncpu NCPU]
                                  [--keep_tmp] [--quiet] [--logfile LOGFILE]
                                  [--debug]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --fq1 FQ1             Fastq file with read 1
  --fq2 FQ2             Fastq file with read 1
  --fqU FQU             Fastq file with unpaired reads
  --ref_fa REF_FA       Consensus fasta file
  --outdir OUTDIR       Output directory (default: .)

Fix consensus options:
  --bt2_preset {very-fast,fast,sensitive,very-sensitive,very-fast-local,fast-local,sensitive-local,very-sensitive-local}
                        Bowtie2 preset to use (default: very-sensitive)
  --sample_id SAMPLE_ID
                        Sample ID (default: sampleXX)

Settings:
  --ncpu NCPU           Number of CPU to use
  --keep_tmp            Do not delete temporary directory (default: False)
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Append console output to this file
  --debug               Print commands but do not run (default: False)
```


## haphpipe_predict_haplo

### Tool Description
Predict haplotypes for a given region.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe predict_haplo [-h] --fq1 FQ1 --fq2 FQ2 --ref_fa REF_FA
                              [--region_txt REGION_TXT] [--outdir OUTDIR]
                              [--min_readlength MIN_READLENGTH] [--keep_tmp]
                              [--quiet] [--logfile LOGFILE] [--debug]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --fq1 FQ1             Fastq file with read 1
  --fq2 FQ2             Fastq file with read 2
  --ref_fa REF_FA       Reference sequence used to align reads (fasta)
  --region_txt REGION_TXT
                        File with regions to perform haplotype reconstruction.
                        Regions should be specified using the samtools region
                        specification format: RNAME[:STARTPOS[-ENDPOS]]
  --outdir OUTDIR       Output directory (default: .)

PredictHaplo Options:
  --min_readlength MIN_READLENGTH
                        Minimum readlength passed to PredictHaplo (default:
                        36)

Settings:
  --keep_tmp            Do not delete temporary directory (default: False)
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Append console output to this file
  --debug               Print commands but do not run (default: False)
```


## haphpipe_ph_parser

### Tool Description
Parses the output of PredictHaplo to create a FASTA file of haplotypes.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe ph_parser [-h] --haplotypes_fa HAPLOTYPES_FA [--outdir OUTDIR]
                          [--prefix PREFIX] [--keep_gaps] [--quiet]
                          [--logfile LOGFILE]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --haplotypes_fa HAPLOTYPES_FA
                        Haplotype file created by PredictHaplo.
  --outdir OUTDIR       Output directory. (default: .)

Parser options:
  --prefix PREFIX       Prefix to add to sequence names
  --keep_gaps           Do not remove gaps from alignment (default: False)

Settings:
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Append console output to this file
```


## haphpipe_cliquesnv

### Tool Description
Haphpipe tool for CliqueSNV analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe cliquesnv [-h] [--fq1 FQ1] [--fq2 FQ2] [--fqU FQU]
                          [--ref_fa REF_FA] [--outdir OUTDIR]
                          [--jardir JARDIR] [--O22min O22MIN]
                          [--O22minfreq O22MINFREQ] [--printlog]
                          [--merging MERGING] [--fasta_format FASTA_FORMAT]
                          [--outputstart OUTPUTSTART] [--outputend OUTPUTEND]
                          [--quiet] [--logfile LOGFILE] [--debug]
                          [--ncpu NCPU] [--keep_tmp]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --fq1 FQ1             Fastq file with read 1
  --fq2 FQ2             Fastq file with read 2
  --fqU FQU             Fastq file with unpaired reads
  --ref_fa REF_FA       Reference FASTA file
  --outdir OUTDIR       Output directory (default: .)

CliqueSNV Options:
  --jardir JARDIR       Path to clique-snv.jar (existing) (Default: current
                        directory) (default: .)
  --O22min O22MIN       minimum threshold for O22 value
  --O22minfreq O22MINFREQ
                        minimum threshold for O22 frequency relative to read
                        coverage
  --printlog            Print log data to console (default: False)
  --merging MERGING     Cliques merging algorithm: accurate or fast
  --fasta_format FASTA_FORMAT
                        Fasta defline format: short or extended, add number at
                        end to adjust precision of frequency (default:
                        extended4)
  --outputstart OUTPUTSTART
                        Output start position
  --outputend OUTPUTEND
                        Output end position

HAPHPIPE Options:
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Name for log file (output)
  --debug               Print commands but do not run (default: False)
  --ncpu NCPU           Number of CPU to use (default: 1)
  --keep_tmp            Do not delete temporary directory (default: False)
```


## haphpipe_pairwise_align

### Tool Description
Perform pairwise alignment of assembled amplicons to a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe pairwise_align [-h] --amplicons_fa AMPLICONS_FA --ref_fa
                               REF_FA --ref_gtf REF_GTF [--outdir OUTDIR]
                               [--keep_tmp] [--quiet] [--logfile LOGFILE]
                               [--debug]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --amplicons_fa AMPLICONS_FA
                        Assembled amplicons (fasta)
  --ref_fa REF_FA       Reference fasta file
  --ref_gtf REF_GTF     GTF format file containing amplicon regions. Primary
                        and alternate coding regions should be provided in the
                        attribute field (for amino acid alignment).
  --outdir OUTDIR       Output directory (default: .)

Settings:
  --keep_tmp            Do not delete temporary directory (default: False)
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Append console output to this file
  --debug               Print commands but do not run (default: False)
```


## haphpipe_extract_pairwise

### Tool Description
Extract pairwise alignment information from a JSON file.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe extract_pairwise [-h] --align_json ALIGN_JSON
                                 [--outfile OUTFILE]
                                 [--outfmt {nuc_fa,aln_fa,amp_gtf,tsv,prot_fa}]
                                 [--refreg REFREG] [--debug]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --align_json ALIGN_JSON
                        JSON file describing alignment (output of
                        pairwise_align stage)
  --outfile OUTFILE     Output file. Default is stdout

Extract pairwise options:
  --outfmt {nuc_fa,aln_fa,amp_gtf,tsv,prot_fa}
                        Format for output (default: nuc_fa)
  --refreg REFREG       Reference region. String format is ref:start-stop. For
                        example, the region string to extract pol when aligned
                        to HXB2 is HIV_B.K03455.HXB2:2085-5096

Settings:
  --debug               Print commands but do not run (default: False)
```


## haphpipe_summary_stats

### Tool Description
Calculate summary statistics for Haplotype Pipeline results.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe summary_stats [-h] [--dir_list DIR_LIST] [--ph_list PH_LIST]
                              [--amplicons] [--outdir OUTDIR] [--quiet]
                              [--logfile LOGFILE] [--debug]

optional arguments:
  -h, --help           show this help message and exit

Input/Output:
  --dir_list DIR_LIST  List of directories which include the required files,
                       one on each line
  --ph_list PH_LIST    List of directories which include haplotype summary
                       files, one on each line
  --amplicons          Amplicons used in assembly (default: False)
  --outdir OUTDIR      Output directory

Settings:
  --quiet              Do not write output to console (silence stdout and
                       stderr) (default: False)
  --logfile LOGFILE    Name for log file (output)
  --debug              Print commands but do not run (default: False)
```


## haphpipe_multiple_align

### Tool Description
Aligns multiple sequences using MAFFT.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe multiple_align [-h] [--seqs SEQS] [--dir_list DIR_LIST]
                               [--ref_gtf REF_GTF] [--out_align OUT_ALIGN]
                               [--nuc] [--amino] [--clustalout] [--phylipout]
                               [--inputorder] [--reorder] [--treeout]
                               [--quiet_mafft] [--outdir OUTDIR] [--algo ALGO]
                               [--auto] [--sixmerpair] [--globalpair]
                               [--localpair] [--genafpair] [--fastapair]
                               [--weighti WEIGHTI] [--retree RETREE]
                               [--maxiterate MAXITERATE] [--noscore]
                               [--memsave] [--parttree] [--dpparttree]
                               [--fastaparttree] [--partsize PARTSIZE]
                               [--groupsize GROUPSIZE] [--lop LOP] [--lep LEP]
                               [--lexp LEXP] [--LOP LOP] [--LEXP LEXP]
                               [--bl BL] [--jtt JTT] [--tm TM]
                               [--aamatrix AAMATRIX] [--fmodel] [--ncpu NCPU]
                               [--quiet] [--logfile LOGFILE] [--debug]
                               [--fastaonly] [--alignall]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --seqs SEQS           FASTA file with sequences to be aligned
  --dir_list DIR_LIST   List of directories which include either a final.fna
                        or ph_haplotypes.fna file, one on each line
  --ref_gtf REF_GTF     Reference GTF file
  --out_align OUT_ALIGN
                        Name for alignment file
  --nuc                 Assume nucleotide (default: False)
  --amino               Assume amino (default: False)
  --clustalout          Clustal output format (default: False)
  --phylipout           PHYLIP output format (default: False)
  --inputorder          Output order same as input (default: False)
  --reorder             Output order aligned (default: False)
  --treeout             Guide tree is output to the input.tree file (default:
                        False)
  --quiet_mafft         Do not report progress (default: False)
  --outdir OUTDIR       Output directory

MAFFT Algorithm Options:
  --algo ALGO           Use different algorithm in command: linsi, ginsi,
                        einsi, fftnsi, fftns, nwns, nwnsi
  --auto                Automatically select algorithm (default: False)
  --sixmerpair          Calculate distance based on shared 6mers, on by
                        default (default: False)
  --globalpair          Use Needleman-Wunsch algorithm (default: False)
  --localpair           Use Smith-Waterman algorithm (default: False)
  --genafpair           Use local algorithm with generalized affine gap cost
                        (default: False)
  --fastapair           Use FASTA for pairwise alignment (default: False)
  --weighti WEIGHTI     Weighting factor for consistency term
  --retree RETREE       Number of times to build guide tree
  --maxiterate MAXITERATE
                        Number of cycles for iterative refinement
  --noscore             Do not check alignment score in iterative alignment
                        (default: False)
  --memsave             Use Myers-Miller algorithm (default: False)
  --parttree            Use fast tree-building method with 6mer distance
                        (default: False)
  --dpparttree          Use PartTree algorithm with distances based on DP
                        (default: False)
  --fastaparttree       Use PartTree algorithm with distances based on FASTA
                        (default: False)
  --partsize PARTSIZE   Number of partitions for PartTree
  --groupsize GROUPSIZE
                        Max number of sequences for PartTree

MAFFT Parameters:
  --lop LOP             Gap opening penalty
  --lep LEP             Offset value
  --lexp LEXP           Gap extension penalty
  --LOP LOP             Gap opening penalty to skip alignment
  --LEXP LEXP           Gap extension penalty to skip alignment
  --bl BL               BLOSUM matrix: 30, 45, 62, or 80
  --jtt JTT             JTT PAM number >0
  --tm TM               Transmembrane PAM number >0
  --aamatrix AAMATRIX   Path to user-defined AA scoring matrix
  --fmodel              Incorporate AA/nuc composition info into scoring
                        matrix (default: False)

Options:
  --ncpu NCPU           Number of CPU to use (default: 1)
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Name for log file (output)
  --debug               Print commands but do not run (default: False)
  --fastaonly           Output fasta files separated by region but do not
                        align (default: False)
  --alignall            Do not separate files by region, align entire file
                        (default: False)
```


## haphpipe_model_test

### Tool Description
ModelTest-NG wrapper for HAPHpipe

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe model_test [-h] [--seqs SEQS] [--run_id RUN_ID]
                           [--outname OUTNAME] [--outdir OUTDIR]
                           [--data_type DATA_TYPE] [--partitions PARTITIONS]
                           [--seed SEED] [--topology TOPOLOGY] [--utree UTREE]
                           [--force] [--asc_bias ASC_BIAS]
                           [--frequencies FREQUENCIES] [--het HET]
                           [--models MODELS] [--schemes SCHEMES]
                           [--template TEMPLATE] [--ncpu NCPU] [--quiet]
                           [--logfile LOGFILE] [--debug] [--keep_tmp]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --seqs SEQS           Alignment in FASTA or PHYLIP format
  --run_id RUN_ID       Prefix for output files
  --outname OUTNAME     Name for output file (Default: modeltest_results)
  --outdir OUTDIR       Output directory (Default: .)

ModelTest-NG Options:
  --data_type DATA_TYPE
                        Data type: nt or aa
  --partitions PARTITIONS
                        Partitions file
  --seed SEED           Seed for random number generator
  --topology TOPOLOGY   Starting topology: ml, mp, fixed-ml-jc, fixed-ml-gtr,
                        fixed-mp, random, or user
  --utree UTREE         User-defined starting tree
  --force               force output overriding (default: False)
  --asc_bias ASC_BIAS   Ascertainment bias correction: lewis, felsenstein, or
                        stamatakis
  --frequencies FREQUENCIES
                        Candidate model frequencies: e (estimated) or f
                        (fixed)
  --het HET             Set rate heterogeneity: u (uniform), i (invariant
                        sites +I), g (gamma +G), or f (both invariant sites
                        and gamma +I+G)
  --models MODELS       Text file with candidate models, one per line
  --schemes SCHEMES     Number of predefined DNA substitution schemes
                        evaluated: 3, 5, 7, 11, or 203
  --template TEMPLATE   Set candidate models according to a specified tool:
                        raxml, phyml, mrbayes, or paup

Options:
  --ncpu NCPU           Number of CPU to use (default: 1)
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Name for log file (output)
  --debug               Print commands but do not run (default: False)
  --keep_tmp            Keep temporary directory (default: False)
```


## haphpipe_build_tree_NG

### Tool Description
Build phylogenetic trees using RAxML-NG

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe build_tree_NG [-h] [--seqs SEQS] [--in_type IN_TYPE]
                              [--output_name OUTPUT_NAME] [--outdir OUTDIR]
                              [--model MODEL] [--all]
                              [--branch_length BRANCH_LENGTH]
                              [--consense CONSENSE] [--rand_tree RAND_TREE]
                              [--pars_tree PARS_TREE] [--user_tree USER_TREE]
                              [--search] [--search_1random]
                              [--constraint_tree CONSTRAINT_TREE]
                              [--outgroup OUTGROUP] [--bsconverge] [--bs_msa]
                              [--bs_trees BS_TREES]
                              [--bs_tree_cutoff BS_TREE_CUTOFF]
                              [--bs_metric BS_METRIC] [--bootstrap] [--check]
                              [--log LOG] [--loglh] [--terrace] [--version]
                              [--seed SEED] [--redo] [--keep_tmp] [--quiet]
                              [--logfile LOGFILE] [--ncpu NCPU] [--debug]

optional arguments:
  -h, --help            show this help message and exit

Input/Output:
  --seqs SEQS           Input alignment in FASTA or PHYLIP format
  --in_type IN_TYPE     File format: FASTA or PHYLIP (Default is FASTA)
  --output_name OUTPUT_NAME
                        Run name for trees
  --outdir OUTDIR       Output directory (default: .)

RAxML-NG Options:
  --model MODEL         Substitution model OR path to partition file
  --all                 Run bootstrap search and find best ML tree (default:
                        False)
  --branch_length BRANCH_LENGTH
                        Branch length estimation mode: linked, scaled,
                        unlinked (partitioned analysis only)
  --consense CONSENSE   Consensus tree building options: STRICT, MR, or MRE
  --rand_tree RAND_TREE
                        Start from a random topology
  --pars_tree PARS_TREE
                        Start from a tree generated by the parsimony-based
                        randomized stepwise addition algorithm
  --user_tree USER_TREE
                        Load a custom starting tree from the NEWICK file
  --search              Find best scoring ML tree (default) (default: False)
  --search_1random      Find best scoring ML tree with 1 random tree (default:
                        False)
  --constraint_tree CONSTRAINT_TREE
                        Specify a constraint tree to e.g. enforce monophyly of
                        certain groups
  --outgroup OUTGROUP   Outgroup(s) for tree
  --bsconverge          A posteriori bootstrap convergence test (default:
                        False)
  --bs_msa              Generate bootstrap replicate alignments (default:
                        False)
  --bs_trees BS_TREES   Number of bootstrap trees OR autoMRE
  --bs_tree_cutoff BS_TREE_CUTOFF
                        Change the bootstopping cutoff value to make the test
                        more or less stringent
  --bs_metric BS_METRIC
                        Options: tbe or fbp,tbe
  --bootstrap           Run non-parametric bootstrap analysis (default: False)
  --check               Check alignment file and remove any columns consisting
                        entirely of gaps (default: False)
  --log LOG             Options for output verbosity: ERROR, WARNING, RESULT,
                        INFO, PROGRESS, VERBOSE, or DEBUG
  --loglh               Compute log-likelihood of a given tree without any
                        optimization (default: False)
  --terrace             Check whether a tree lies on a phylogenetic terrace
                        (default: False)
  --seed SEED           Seed for random numbers (default: 12345)
  --redo                Run even if there are existing files with the same
                        name (use with caution!) (default: False)

Settings:
  --version             Check RAxML-NG version ONLY (default: False)
  --keep_tmp            Keep temporary directory (default: False)
  --quiet               Do not write output to console (silence stdout and
                        stderr) (default: False)
  --logfile LOGFILE     Append console output to this file
  --ncpu NCPU           Number of CPU to use (default: 1)
  --debug               Print commands but do not run (default: False)
```


## haphpipe_demo

### Tool Description
Runs a demo of HAPHPipe.

### Metadata
- **Docker Image**: quay.io/biocontainers/haphpipe:1.0.3--py_0
- **Homepage**: https://github.com/gwcbi/haphpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/haphpipe/overview
- **Validation**: PASS

### Original Help Text
```text
usage: haphpipe demo [-h] [--outdir OUTDIR] [--refonly]

optional arguments:
  -h, --help       show this help message and exit

Input/Output:
  --outdir OUTDIR  Output directory (default: .)
  --refonly        Does not run entire demo, only pulls the reference files
                   (default: False)
```

