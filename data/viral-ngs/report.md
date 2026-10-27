# viral-ngs CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| viral-ngs_assembly_deambig_fasta | PASS | real SARS-CoV-2 sequence with 2276 N; all N replaced by A/C/G/T, length unchanged |
| viral-ngs_assembly_filter_short_seqs | PASS |  |
| viral-ngs_assembly_trim_fasta | PASS |  |
| viral-ngs_assembly_vcf_to_fasta | PASS | input VCF was made with bcftools mpileup/call from the real nf-core SARS-CoV-2 BAM and genome (viral-ngs needs the AD field); output has the 9 called variants and N elsewhere, ends trimmed |
| viral-ngs_interhost_align_mafft | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing MafftTool' (it ignores the mafft on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_intrahost_vphaser_one_sample | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_bam_to_fastq | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_fastq_to_bam | Failed | image problem: viral-ngs tries to download Picard 2.5.0 into its read-only install folder (conda is not installed in the image), so the command cannot run |
| viral-ngs_read_utils_filter_bam_mapped_only | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_index_fasta_samtools | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_merge_bams | Failed | image problem: viral-ngs tries to download Picard 2.5.0 into its read-only install folder (conda is not installed in the image), so the command cannot run |
| viral-ngs_read_utils_sort_bam | Failed | image problem: viral-ngs tries to download Picard 2.5.0 into its read-only install folder (conda is not installed in the image), so the command cannot run |
| viral-ngs_reports_alignment_summary | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing MuscleTool' (muscle is not found or installable in the image), so the command cannot run |
| viral-ngs_reports_plot_coverage | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |

## viral-ngs_reports_alignment_summary

### Tool Description
Pairwise alignment summary (SNPs, ambiguous bases, indels) for sequences in two FASTA files

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reports.py subcommand alignment_summary [-h]
                                               [--outfileName OUTFILENAME]
                                               [--printCounts]
                                               inFastaFileOne inFastaFileTwo

Write or print pairwise alignment summary information for sequences in two
FASTA files, including SNPs, ambiguous bases, and indels.

positional arguments:
  inFastaFileOne        First fasta file for an alignment
  inFastaFileTwo        First fasta file for an alignment

optional arguments:
  -h, --help            show this help message and exit
  --outfileName OUTFILENAME
                        Output file for counts in TSV format
  --printCounts
```

## viral-ngs_read_utils_sort_bam

### Tool Description
Sort BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand sort_bam [-h] [--index] [--md5]
                                         [--JVMmemory JVMMEMORY]
                                         [--picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]]
                                         [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                         [--version] [--tmp_dir TMP_DIR]
                                         [--tmp_dirKeep]
                                         inBam outBam
                                         {unsorted,queryname,coordinate}

Sort BAM file

positional arguments:
  inBam                 Input bam file.
  outBam                Output bam file, sorted.
  {unsorted,queryname,coordinate}
                        How to sort the reads. [default: coordinate]

optional arguments:
  -h, --help            show this help message and exit
  --index               Index outBam (default: False)
  --md5                 MD5 checksum outBam (default: False)
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 2g)
  --picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]
                        Optional arguments to Picard's SortSam,
                        OPTIONNAME=value ...
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_read_utils_merge_bams

### Tool Description
Merge multiple BAMs into one

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand merge_bams [-h] [--JVMmemory JVMMEMORY]
                                           [--picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]]
                                           [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                           [--version] [--tmp_dir TMP_DIR]
                                           [--tmp_dirKeep]
                                           inBams [inBams ...] outBam

Merge multiple BAMs into one

positional arguments:
  inBams                Input bam files.
  outBam                Output bam file.

optional arguments:
  -h, --help            show this help message and exit
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 2g)
  --picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]
                        Optional arguments to Picard's MergeSamFiles,
                        OPTIONNAME=value ...
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_intrahost_vphaser_one_sample

### Tool Description
Call intrahost variants with V-Phaser 2 for one sample

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: intrahost.py subcommand vphaser_one_sample [-h]
                                                  [--vphaserNumThreads VPHASERNUMTHREADS]
                                                  [--minReadsEach MINREADSEACH]
                                                  [--maxBias MAXBIAS]
                                                  [--removeDoublyMappedReads]
                                                  [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                  [--version]
                                                  inBam inConsFasta outTab

Input: a single BAM file, representing reads from one sample, mapped to its
own consensus assembly. It may contain multiple read groups and libraries.
Output: a tab-separated file with no header containing filtered V Phaser-2
output variants with additional column for sequence/chrom name, and library
counts and p-values appended to the counts for each allele.

positional arguments:
  inBam                 Input Bam file.
  inConsFasta           Consensus assembly fasta.
  outTab                Tab-separated headerless output file.

optional arguments:
  -h, --help            show this help message and exit
  --vphaserNumThreads VPHASERNUMTHREADS
                        Number of threads in call to V-Phaser 2.
  --minReadsEach MINREADSEACH
                        Minimum number of reads on each strand (default: 5).
  --maxBias MAXBIAS     Maximum allowable ratio of number of reads on the two
                        strands (default: 10). Ignored if minReadsEach = 0.
  --removeDoublyMappedReads
                        When calling V-Phaser, remove reads mapping to more
                        than one contig. Default is to keep the reads.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_read_utils_fastq_to_bam

### Tool Description
Convert a pair of fastq paired-end read files and optional text header to a single bam file

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand fastq_to_bam [-h]
                                             (--sampleName SAMPLENAME | --header HEADER)
                                             [--JVMmemory JVMMEMORY]
                                             [--picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]]
                                             [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                             [--version] [--tmp_dir TMP_DIR]
                                             [--tmp_dirKeep]
                                             inFastq1 inFastq2 outBam

Convert a pair of fastq paired-end read files and optional text header to a
single bam file.

positional arguments:
  inFastq1              Input fastq file; 1st end of paired-end reads.
  inFastq2              Input fastq file; 2nd end of paired-end reads.
  outBam                Output bam file.

optional arguments:
  -h, --help            show this help message and exit
  --sampleName SAMPLENAME
                        Sample name to insert into the read group header.
  --header HEADER       Optional text file containing header.
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 2g)
  --picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]
                        Optional arguments to Picard's FastqToSam,
                        OPTIONNAME=value ... Note that header-related options
                        will be overwritten by HEADER if present.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_reports_plot_coverage

### Tool Description
Generate a coverage plot from an aligned bam file

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reports.py subcommand plot_coverage [-h] [--plotFormat]
                                           [--plotDataStyle] [--plotStyle]
                                           [--plotWidth PLOT_WIDTH]
                                           [--plotHeight PLOT_HEIGHT]
                                           [--plotDPI PLOT_DPI]
                                           [--plotTitle PLOT_TITLE]
                                           [-q BASE_Q_THRESHOLD]
                                           [-Q MAPPING_Q_THRESHOLD]
                                           [-m MAX_COVERAGE_DEPTH]
                                           [-l READ_LENGTH_THRESHOLD]
                                           [--outSummary OUT_SUMMARY]
                                           [--plotOnlyNonDuplicates]
                                           [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                           [--version] [--tmp_dir TMP_DIR]
                                           [--tmp_dirKeep]
                                           in_bam out_plot_file

Generate a coverage plot from an aligned bam file

positional arguments:
  in_bam                Input reads, BAM format.
  out_plot_file         The generated chart file

optional arguments:
  -h, --help            show this help message and exit
  --plotFormat          File format of the coverage plot. By default it is
                        inferred from the file extension of out_plot_file, but
                        it can be set explicitly via --plotFormat. Valid
                        formats include: jpg, svg, ps, jpeg, tiff, raw, tif,
                        png, eps, pdf, rgba, pgf, svgz
  --plotDataStyle       The plot data display style. Valid options: filled,
                        line, dots (default: filled)
  --plotStyle           The plot visual style. Valid options: seaborn-dark,
                        seaborn-paper, dark_background, ggplot,
                        fivethirtyeight, bmh, classic, seaborn-talk, seaborn-
                        poster, seaborn-darkgrid, seaborn-colorblind, seaborn-
                        deep, seaborn-bright, seaborn-ticks, grayscale,
                        seaborn-white, seaborn-whitegrid, seaborn-pastel,
                        seaborn-dark-palette, seaborn-notebook, seaborn-muted
                        (default: ggplot)
  --plotWidth PLOT_WIDTH
                        Width of the plot in pixels (default: 1024)
  --plotHeight PLOT_HEIGHT
                        Width of the plot in pixels (default: 768)
  --plotDPI PLOT_DPI    dots per inch for rendered output, more useful for
                        vector modes (default: 80.0)
  --plotTitle PLOT_TITLE
                        The title displayed on the coverage plot (default:
                        'Coverage Plot')
  -q BASE_Q_THRESHOLD   The minimum base quality threshold
  -Q MAPPING_Q_THRESHOLD
                        The minimum mapping quality threshold
  -m MAX_COVERAGE_DEPTH
                        The max coverage depth (default: 1000000)
  -l READ_LENGTH_THRESHOLD
                        Read length threshold
  --outSummary OUT_SUMMARY
                        Coverage summary TSV file. Default is to write to
                        temp.
  --plotOnlyNonDuplicates
                        Plot only non-duplicates (samtools -F 1024)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_assembly_trim_fasta

### Tool Description
Trim continuous sections of N's from the ends of sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assembly.py subcommand trim_fasta [-h]
                                         [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                         [--version]
                                         inFasta outFasta

Take input sequences (fasta) and trim any continuous sections of N's from the
ends of them. Write trimmed sequences to an output fasta file.

positional arguments:
  inFasta               Input fasta file
  outFasta              Output (trimmed) fasta file

optional arguments:
  -h, --help            show this help message and exit
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_read_utils_filter_bam_mapped_only

### Tool Description
Reduce a BAM file to only aligned, non-duplicate reads with non-zero mapping quality

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand filter_bam_mapped_only [-h]
                                                       [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                       [--version]
                                                       [--tmp_dir TMP_DIR]
                                                       [--tmp_dirKeep]
                                                       inBam outBam

Samtools to reduce a BAM file to only reads that are aligned (-F 4) with a
non-zero mapping quality (-q 1) and are not marked as a PCR/optical duplicate
(-F 1024).

positional arguments:
  inBam                 Input aligned reads, BAM format.
  outBam                Output sorted indexed reads, filtered to aligned-only,
                        BAM format.

optional arguments:
  -h, --help            show this help message and exit
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_interhost_align_mafft

### Tool Description
Run the mafft alignment on the input FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: interhost.py subcommand align_mafft [-h] [--localpair | --globalpair]
                                           [--preservecase] [--reorder]
                                           [--gapOpeningPenalty GAPOPENINGPENALTY]
                                           [--ep EP] [--verbose]
                                           [--outputAsClustal]
                                           [--maxiters MAXITERS]
                                           [--threads THREADS]
                                           [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                           [--version] [--tmp_dir TMP_DIR]
                                           [--tmp_dirKeep]
                                           inFastas [inFastas ...] outFile

Run the mafft alignment on the input FASTA file.

positional arguments:
  inFastas              Input FASTA files.
  outFile               Output file containing alignment result (default
                        format: FASTA)

optional arguments:
  -h, --help            show this help message and exit
  --localpair           All pairwise alignments are computed with the Smith-
                        Waterman algorithm.
  --globalpair          All pairwise alignments are computed with the
                        Needleman-Wunsch algorithm.
  --preservecase        Preserve base or aa case, as well as symbols.
  --reorder             Output is ordered aligned rather than in the order of
                        the input (default: None).
  --gapOpeningPenalty GAPOPENINGPENALTY
                        Gap opening penalty (default: 1.53).
  --ep EP               Offset (works like gap extension penalty).
  --verbose             Full output (default: False).
  --outputAsClustal     Write output file in Clustal format rather than FASTA
  --maxiters MAXITERS   Maximum number of refinement iterations (default: 0).
                        Note: if "--localpair" or "--globalpair" is specified
                        this defaults to 1000.
  --threads THREADS     Number of processing threads (default: -1, where -1
                        indicates use of all available cores).
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_assembly_filter_short_seqs

### Tool Description
Retain only sequences that are long enough and have enough unambiguous bases

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assembly.py subcommand filter_short_seqs [-h] [-f FORMAT]
                                                [-of OUTPUT_FORMAT]
                                                [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                [--version]
                                                inFile minLength minUnambig
                                                outFile

Check sequences in inFile, retaining only those that are at least minLength

positional arguments:
  inFile                input sequence file
  minLength             minimum length for contig
  minUnambig            minimum percentage unambiguous bases for contig
  outFile               output file

optional arguments:
  -h, --help            show this help message and exit
  -f FORMAT, --format FORMAT
                        Format for input sequence (default: fasta)
  -of OUTPUT_FORMAT, --output-format OUTPUT_FORMAT
                        Format for output sequence (default: fasta)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_assembly_deambig_fasta

### Tool Description
Replace ambiguity bases with a random unambiguous base

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assembly.py subcommand deambig_fasta [-h]
                                            [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                            [--version]
                                            inFasta outFasta

Take input sequences (fasta) and replace any ambiguity bases with a random
unambiguous base from among the possibilities described by the ambiguity code.
Write output to fasta file.

positional arguments:
  inFasta               Input fasta file
  outFasta              Output fasta file

optional arguments:
  -h, --help            show this help message and exit
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_read_utils_bam_to_fastq

### Tool Description
Convert a bam file to a pair of fastq paired-end read files and optional text header

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand bam_to_fastq [-h] [--outHeader OUTHEADER]
                                             [--JVMmemory JVMMEMORY]
                                             [--picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]]
                                             [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                             [--version] [--tmp_dir TMP_DIR]
                                             [--tmp_dirKeep]
                                             inBam outFastq1 outFastq2

Convert a bam file to a pair of fastq paired-end read files and optional text
header.

positional arguments:
  inBam                 Input bam file.
  outFastq1             Output fastq file; 1st end of paired-end reads.
  outFastq2             Output fastq file; 2nd end of paired-end reads.

optional arguments:
  -h, --help            show this help message and exit
  --outHeader OUTHEADER
                        Optional text file name that will receive bam header.
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 2g)
  --picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]
                        Optional arguments to Picard's SamToFastq,
                        OPTIONNAME=value ...
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_read_utils_index_fasta_samtools

### Tool Description
Index a reference genome for Samtools

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand index_fasta_samtools [-h]
                                                     [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                     [--version]
                                                     inFasta

Index a reference genome for Samtools.

positional arguments:
  inFasta               Reference genome, FASTA format.

optional arguments:
  -h, --help            show this help message and exit
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_assembly_vcf_to_fasta

### Tool Description
Build a consensus sequence from majority-read-count alleles in a VCF

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assembly.py subcommand vcf_to_fasta [-h] [--trim_ends]
                                           [--min_coverage MIN_DP]
                                           [--major_cutoff MAJOR_CUTOFF]
                                           [--min_dp_ratio MIN_DP_RATIO]
                                           [--name [NAME [NAME ...]]]
                                           [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                           [--version]
                                           inVcf outFasta

Take input genotypes (VCF) and construct a consensus sequence (fasta) by using
majority-read-count alleles in the VCF. Genotypes in the VCF will be ignored--
we will use the allele with majority read support (or an ambiguity base if
there is no clear majority). Uncalled positions will be emitted as N's.
Author: dpark.

positional arguments:
  inVcf                 Input VCF file
  outFasta              Output FASTA file

optional arguments:
  -h, --help            show this help message and exit
  --trim_ends           If specified, we will strip off continuous runs of N's
                        from the beginning and end of the sequences before
                        writing to output. Interior N's will not be changed.
  --min_coverage MIN_DP
                        Specify minimum read coverage (with full agreement) to
                        make a call. [default: 3]
  --major_cutoff MAJOR_CUTOFF
                        If the major allele is present at a frequency higher
                        than this cutoff, we will call an unambiguous base at
                        that position. If it is equal to or below this cutoff,
                        we will call an ambiguous base representing all
                        possible alleles at that position. [default: 0.5]
  --min_dp_ratio MIN_DP_RATIO
                        The input VCF file often reports two read depth values
                        (DP)--one for the position as a whole, and one for the
                        sample in question. We can optionally reject calls in
                        which the sample read count is below a specified
                        fraction of the total read count. This filter will not
                        apply to any sites unless both DP values are reported.
                        [default: 0.0]
  --name [NAME [NAME ...]]
                        output sequence names (default: reference names in VCF
                        file)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

