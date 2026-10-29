# viral-ngs CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| viral-ngs_assembly_assemble_trinity | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_assembly_deambig_fasta | PASS | real SARS-CoV-2 sequence with 2276 N; all N replaced by A/C/G/T, length unchanged |
| viral-ngs_assembly_dpdiff | PASS | real SARS-CoV-2 single-sample VCF (nf-core, bgzip+tabix); 94 rows with dp_info 48 matching INFO DP and dp_sample 0 (no DP in the sample column); note: the tool crashes on VCFs with an INFO flag such as INDEL |
| viral-ngs_assembly_filter_short_seqs | PASS |  |
| viral-ngs_assembly_impute_from_reference | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing MuscleTool' (it ignores the muscle on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_assembly_modify_contig | PASS | two real SARS-CoV-2 sequences from an nf-core alignment; contig renamed, end gaps trimmed to the reference, output length 29884 equals the ungapped contig |
| viral-ngs_assembly_order_and_orient | Failed | image problem: viral-ngs cannot find its MUMmer tool (TypeError: stat can't specify None for path; it ignores nucmer on PATH), so the command cannot run |
| viral-ngs_assembly_refine_assembly | Failed | image problem: viral-ngs tries to download Picard 2.5.0 into its read-only install folder (conda is not installed in the image), so the command cannot run |
| viral-ngs_assembly_trim_fasta | PASS |  |
| viral-ngs_assembly_trim_rmdup_subsamp | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_assembly_vcf_to_fasta | PASS | input VCF was made with bcftools mpileup/call from the real nf-core SARS-CoV-2 BAM and genome (viral-ngs needs the AD field); output has the 9 called variants and N elsewhere, ends trimmed |
| viral-ngs_broad_utils_get_all_names | PASS | synthetic data: a planted run file and barcode file (Broad-internal formats); the sample names were listed correctly |
| viral-ngs_broad_utils_get_bustard_dir | PASS | synthetic data: a planted Picard folder with a run JSON file (Broad-internal format); the run folder path was printed correctly |
| viral-ngs_broad_utils_get_run_date | PASS | synthetic data: a planted Picard folder with a run JSON file (Broad-internal format); the run date was printed correctly |
| viral-ngs_illumina_common_barcodes | Failed | image problem: viral-ngs tries to download Picard 2.5.0 into its read-only install folder (conda is not installed in the image), (with a planted tab sample sheet; the nf-core NovaSeq sample sheet is not readable by the tool) so the command cannot run |
| viral-ngs_illumina_extract_fc_metadata | PASS | MiSeq run folder from the viral-ngs test data (the nf-core NovaSeq folder has a sample sheet the tool cannot read); RunInfo.xml and SampleSheet.csv copied out unchanged; a tar.gz input fails because the image has only BusyBox tar |
| viral-ngs_illumina_illumina_demux | Failed | image problem: the BusyBox tar in the image rejects the options viral-ngs uses to read a tar.gz run folder, and the real nf-core NovaSeq run folder stops on its RunInfo.xml date format (empty Exception) |
| viral-ngs_illumina_miseq_fastq_to_bam | Failed | image problem: viral-ngs tries to download Picard 2.5.0 into its read-only install folder (conda is not installed in the image), so the command cannot run |
| viral-ngs_interhost_align_mafft | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing MafftTool' (it ignores the mafft on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_interhost_multichr_mafft | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing MafftTool' (it ignores the mafft on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_intrahost_merge_to_vcf | PASS | synthetic data: a planted vPhaser2 SNP line and a two-sequence alignment of the real nf-core SARS-CoV-2 genome; the VCF has the SNP (REF C, ALT A) with GT, AF, DP, NL and LB fields |
| viral-ngs_intrahost_tabfile_rename | PASS | real SARS-CoV-2 primer BED file (nf-core) with a planted map file; column 0 renamed on all rows after the header line, as documented |
| viral-ngs_intrahost_vphaser | PASS | real nf-core SARS-CoV-2 paired-end BAM (input staged writable with its index); a headerless table of 2 low-frequency variants was written |
| viral-ngs_intrahost_vphaser_one_sample | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_metagenomics_align_rna | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_metagenomics_diamond | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_metagenomics_kraken | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_metagenomics_krona | Failed | image problem: viral-ngs cannot find its Krona tool (AttributeError on a None path; it ignores ktImportTaxonomy on PATH), so the command cannot run |
| viral-ngs_metagenomics_report_merge | PASS | Kraken per-read report from the viral-ngs test data; the by-query output has all 100 lines; note: --outSummaryReport crashes (image problem: it cannot install Kraken) and --krakenDB must be a file |
| viral-ngs_ncbi_fetch_fastas | PASS | downloaded SARS-CoV-2 MT192765.1 from NCBI (network access); the sequence is identical to the nf-core genome.fasta |
| viral-ngs_ncbi_fetch_feature_tables | PASS | downloaded the feature table of SARS-CoV-2 MT192765.1 from NCBI (network access); it lists the 5'UTR, orf1ab, S and other features |
| viral-ngs_ncbi_fetch_genbank_records | PASS | downloaded the GenBank record of SARS-CoV-2 MT192765.1 from NCBI (network access); it is a valid flat file (LOCUS MT192765, 29829 bp) |
| viral-ngs_ncbi_prep_genbank_files | Failed | image problem: viral-ngs tries to download tbl2asn from the NCBI ftp site into its read-only install folder and the image has no tbl2asn, so the command cannot run |
| viral-ngs_ncbi_prep_sra_table | PASS | synthetic data: planted library, BioSample and md5 files (the md5 is of a real nf-core BAM); the table has the right columns and values |
| viral-ngs_ncbi_tbl_transfer | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing MuscleTool' (it ignores the muscle on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_ncbi_tbl_transfer_prealigned | PASS | synthetic data: a planted pairwise alignment of the real SARS-CoV-2 genome (3 substitutions) and its real NCBI feature table; the transferred table has the features for the new sequence |
| viral-ngs_read_utils_align_and_fix | Failed | image problem: viral-ngs tries to download Picard 2.5.0 into its read-only install folder (conda is not installed in the image), so the command cannot run |
| viral-ngs_read_utils_bam_to_fastq | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_bwamem_idxstats | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_dup_remove_mvicuna | Failed | image problem: the mvicuna program bundled in the image crashes with a floating point exception (exit 136), even on the viral-ngs test reads, so the command cannot run |
| viral-ngs_read_utils_fastq_to_bam | Failed | image problem: viral-ngs tries to download Picard 2.5.0 into its read-only install folder (conda is not installed in the image), so the command cannot run |
| viral-ngs_read_utils_fastq_to_fasta | PASS | real SARS-CoV-2 reads (plain fastq, 100 reads); 100 fasta records, same read names; the tool cannot read gzip input |
| viral-ngs_read_utils_filter_bam | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_filter_bam_mapped_only | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_gatk_realign | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing GATKTool' (the GATK jar is not in the image and it tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_gatk_ug | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing GATKTool' (the GATK jar is not in the image and it tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_index_fasta_picard | Failed | image problem: viral-ngs tries to download Picard 2.5.0 into its read-only install folder (conda is not installed in the image), so the command cannot run |
| viral-ngs_read_utils_index_fasta_samtools | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_merge_bams | Failed | image problem: viral-ngs tries to download Picard 2.5.0 into its read-only install folder (conda is not installed in the image), so the command cannot run |
| viral-ngs_read_utils_mkdup_picard | Failed | image problem: viral-ngs tries to download Picard 2.5.0 into its read-only install folder (conda is not installed in the image), so the command cannot run |
| viral-ngs_read_utils_novoalign | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_novoindex | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing NovoalignTool' (it ignores the novoindex on PATH and tries to download and install its own copy; Novoalign also needs a licence), so the command cannot run |
| viral-ngs_read_utils_picard | Failed | image problem: viral-ngs tries to download Picard 2.5.0 into its read-only install folder (conda is not installed in the image), so the command cannot run |
| viral-ngs_read_utils_purge_unmated | Failed | image problem: viral-ngs cannot find its helper script mergeShuffledFastqSeqs.pl (missing file in the image), so the command cannot run |
| viral-ngs_read_utils_reheader_bam | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_reheader_bams | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_revert_bam_picard | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_rmdup_mvicuna_bam | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_rmdup_prinseq_fastq | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing PrinseqTool' (it ignores the prinseq-lite.pl on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_sort_bam | Failed | image problem: viral-ngs tries to download Picard 2.5.0 into its read-only install folder (conda is not installed in the image), so the command cannot run |
| viral-ngs_read_utils_split_bam | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_read_utils_split_reads | PASS | real SARS-CoV-2 reads; 100 reads split into 2 chunks of 50 reads; chunks joined equal the input |
| viral-ngs_reports_align_and_plot_coverage | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing Bwa' (it ignores the bwa on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_reports_alignment_summary | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing MuscleTool' (muscle is not found or installable in the image), so the command cannot run |
| viral-ngs_reports_assembly_stats | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_reports_consolidate_fastqc | PASS | FastQC summary folders made from the real SARS-CoV-2 BAM files; table has one row per sample with 11 module results |
| viral-ngs_reports_consolidate_spike_count | PASS | synthetic data: two hand-written spike count reports in the tool's format; output has the expected sample, spike and count rows |
| viral-ngs_reports_plot_coverage | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_taxon_filter_blastn_build_db | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing MakeblastdbTool' (it ignores the makeblastdb on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_taxon_filter_bmtagger_build_db | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing BmtoolTool' (it ignores the bmtool on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_taxon_filter_deplete_bam_bmtagger | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_taxon_filter_deplete_blastn | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing BlastnTool' (it ignores the blastn on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_taxon_filter_deplete_blastn_bam | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_taxon_filter_deplete_blastn_paired | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing BlastnTool' (it ignores the blastn on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_taxon_filter_deplete_human | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_taxon_filter_filter_lastal | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing Lastal' (it ignores the lastal on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_taxon_filter_filter_lastal_bam | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing SamtoolsTool' (it ignores the samtools on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_taxon_filter_lastal_build_db | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing Lastdb' (it ignores the lastdb on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_taxon_filter_partition_bmtagger | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing BmtaggerShTool' (it ignores the bmtagger.sh on PATH and tries to download and install its own copy), so the command cannot run |
| viral-ngs_taxon_filter_trim_trimmomatic | Failed | image problem: viral-ngs reports NameError 'unsuccessful in installing TrimmomaticTool' (it ignores the trimmomatic on PATH and tries to download and install its own copy), so the command cannot run |

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

## viral-ngs_read_utils_fastq_to_fasta

### Tool Description
Convert from fastq format to fasta format. Warning: output reads might be split onto multiple lines.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand fastq_to_fasta [-h]
                                               [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                               [--version] [--tmp_dir TMP_DIR]
                                               [--tmp_dirKeep]
                                               inFastq outFasta

Convert from fastq format to fasta format. Warning: output reads might be
split onto multiple lines.

positional arguments:
  inFastq               Input fastq file.
  outFasta              Output fasta file.

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

## viral-ngs_read_utils_split_reads

### Tool Description
Split fasta or fastq file into chunks of maxReads reads or into numChunks chunks named outPrefix01, outPrefix02, etc. If both maxReads and numChunks are None, use defaultMaxReads. The number of characters in file names after outPrefix is indexLen; if not specified, use defaultIndexLen.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand split_reads [-h]
                                            [--maxReads MAXREADS | --numChunks NUMCHUNKS]
                                            [--indexLen INDEXLEN]
                                            [--format {fastq,fasta}]
                                            [--outSuffix OUTSUFFIX]
                                            inFileName outPrefix

Split fasta or fastq file into chunks of maxReads reads or into numChunks
chunks named outPrefix01, outPrefix02, etc. If both maxReads and numChunks are
None, use defaultMaxReads. The number of characters in file names after
outPrefix is indexLen; if not specified, use defaultIndexLen.

positional arguments:
  inFileName            Input fastq or fasta file.
  outPrefix             Output files will be named ${outPrefix}01${outSuffix},
                        ${outPrefix}02${outSuffix}...

optional arguments:
  -h, --help            show this help message and exit
  --maxReads MAXREADS   Maximum number of reads per chunk (default 1000 if
                        neither maxReads nor numChunks is specified).
  --numChunks NUMCHUNKS
                        Number of output files, if maxReads is not specified.
  --indexLen INDEXLEN   Number of characters to append to outputPrefix for
                        each output file (default 2). Number of files must not
                        exceed 10^INDEXLEN.
  --format {fastq,fasta}
                        Input fastq or fasta file (default: fastq).
  --outSuffix OUTSUFFIX
                        Output filename suffix (e.g. .fastq or .fastq.gz). A
                        suffix ending in .gz will cause the output file to be
                        gzip compressed. Default is no suffix.
```

## viral-ngs_read_utils_purge_unmated

### Tool Description
Use mergeShuffledFastqSeqs to purge unmated reads, and put corresponding reads in the same order. Corresponding sequences must have sequence identifiers of the form SEQID/1 and SEQID/2.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand purge_unmated [-h] [--regex REGEX]
                                              [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                              [--version] [--tmp_dir TMP_DIR]
                                              [--tmp_dirKeep]
                                              inFastq1 inFastq2 outFastq1
                                              outFastq2

Use mergeShuffledFastqSeqs to purge unmated reads, and put corresponding reads
in the same order. Corresponding sequences must have sequence identifiers of
the form SEQID/1 and SEQID/2.

positional arguments:
  inFastq1              Input fastq file; 1st end of paired-end reads.
  inFastq2              Input fastq file; 2nd end of paired-end reads.
  outFastq1             Output fastq file; 1st end of paired-end reads.
  outFastq2             Output fastq file; 2nd end of paired-end reads.

optional arguments:
  -h, --help            show this help message and exit
  --regex REGEX         Perl regular expression to parse paired read IDs
                        (default: ^@(\S+)/[1|2]$)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_read_utils_split_bam

### Tool Description
Split BAM file equally into several output BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand split_bam [-h]
                                          [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                          [--version] [--tmp_dir TMP_DIR]
                                          [--tmp_dirKeep]
                                          inBam outBams [outBams ...]

Split BAM file equally into several output BAM files.

positional arguments:
  inBam                 Input BAM file.
  outBams               Output BAM files

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

## viral-ngs_read_utils_reheader_bam

### Tool Description
Copy a BAM file (inBam to outBam) while renaming elements of the BAM header. The mapping file specifies which (key, old value, new value) mappings. For example: LB lib1 lib_one SM sample1 Sample_1 SM sample2 Sample_2 SM sample3 Sample_3 CN broad BI

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand reheader_bam [-h]
                                             [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                             [--version] [--tmp_dir TMP_DIR]
                                             [--tmp_dirKeep]
                                             inBam rgMap outBam

Copy a BAM file (inBam to outBam) while renaming elements of the BAM header.
The mapping file specifies which (key, old value, new value) mappings. For
example: LB lib1 lib_one SM sample1 Sample_1 SM sample2 Sample_2 SM sample3
Sample_3 CN broad BI

positional arguments:
  inBam                 Input reads, BAM format.
  rgMap                 Tabular file containing three columns: field, old,
                        new.
  outBam                Output reads, BAM format.

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

## viral-ngs_read_utils_reheader_bams

### Tool Description
Copy BAM files while renaming elements of the BAM header. The mapping file specifies which (key, old value, new value) mappings. For example: LB lib1 lib_one SM sample1 Sample_1 SM sample2 Sample_2 SM sample3 Sample_3 CN broad BI FN in1.bam out1.bam FN in2.bam out2.bam

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand reheader_bams [-h]
                                              [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                              [--version] [--tmp_dir TMP_DIR]
                                              [--tmp_dirKeep]
                                              rgMap

Copy BAM files while renaming elements of the BAM header. The mapping file
specifies which (key, old value, new value) mappings. For example: LB lib1
lib_one SM sample1 Sample_1 SM sample2 Sample_2 SM sample3 Sample_3 CN broad
BI FN in1.bam out1.bam FN in2.bam out2.bam

positional arguments:
  rgMap                 Tabular file containing three columns: field, old,
                        new.

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

## viral-ngs_reports_consolidate_fastqc

### Tool Description
Consolidate multiple FASTQC reports into one.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reports.py subcommand consolidate_fastqc [-h]
                                                inDirs [inDirs ...] outFile

Consolidate multiple FASTQC reports into one.

positional arguments:
  inDirs      Input FASTQC directories.
  outFile     Output report file.

optional arguments:
  -h, --help  show this help message and exit
```

## viral-ngs_reports_consolidate_spike_count

### Tool Description
Consolidate multiple spike count reports into one.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reports.py subcommand consolidate_spike_count [-h] inDir outFile

Consolidate multiple spike count reports into one.

positional arguments:
  inDir       Input spike count directory.
  outFile     Output report file.

optional arguments:
  -h, --help  show this help message and exit
```

## viral-ngs_read_utils_filter_bam

### Tool Description
Filter BAM file by read name

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand filter_bam [-h] [--exclude]
                                           [--JVMmemory JVMMEMORY]
                                           [--picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]]
                                           [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                           [--version] [--tmp_dir TMP_DIR]
                                           [--tmp_dirKeep]
                                           inBam readList outBam

Filter BAM file by read name

positional arguments:
  inBam                 Input bam file.
  readList              Input file of read IDs.
  outBam                Output bam file.

optional arguments:
  -h, --help            show this help message and exit
  --exclude             If specified, readList is a list of reads to remove
                        from input. Default behavior is to treat readList as
                        an inclusion list (all unnamed reads are removed).
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 4g)
  --picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]
                        Optional arguments to Picard's FilterSamReads,
                        OPTIONNAME=value ...
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_read_utils_revert_bam_picard

### Tool Description
Revert BAM to raw reads

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand revert_bam_picard [-h] [--JVMmemory JVMMEMORY]
                                                  [--picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]]
                                                  [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                  [--version]
                                                  [--tmp_dir TMP_DIR]
                                                  [--tmp_dirKeep]
                                                  inBam outBam

Revert BAM to raw reads

positional arguments:
  inBam                 Input reads, BAM format.
  outBam                Output reads, BAM format.

optional arguments:
  -h, --help            show this help message and exit
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 2g)
  --picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]
                        Optional arguments to Picard's RevertSam,
                        OPTIONNAME=value ...
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_read_utils_rmdup_mvicuna_bam

### Tool Description
Remove duplicate reads from BAM file using M-Vicuna. The primary advantage to this approach over Picard's MarkDuplicates tool is that Picard requires that input reads are aligned to a reference, and M-Vicuna can operate on unaligned reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand rmdup_mvicuna_bam [-h] [--JVMmemory JVMMEMORY]
                                                  [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                  [--version]
                                                  [--tmp_dir TMP_DIR]
                                                  [--tmp_dirKeep]
                                                  inBam outBam

Remove duplicate reads from BAM file using M-Vicuna. The primary advantage to
this approach over Picard's MarkDuplicates tool is that Picard requires that
input reads are aligned to a reference, and M-Vicuna can operate on unaligned
reads.

positional arguments:
  inBam                 Input reads, BAM format.
  outBam                Output reads, BAM format.

optional arguments:
  -h, --help            show this help message and exit
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 4g)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_read_utils_index_fasta_picard

### Tool Description
Create an index file for a reference genome suitable for Picard/GATK.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand index_fasta_picard [-h]
                                                   [--JVMmemory JVMMEMORY]
                                                   [--picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]]
                                                   [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                   [--version]
                                                   [--tmp_dir TMP_DIR]
                                                   [--tmp_dirKeep]
                                                   inFasta

Create an index file for a reference genome suitable for Picard/GATK.

positional arguments:
  inFasta               Input reference genome, FASTA format.

optional arguments:
  -h, --help            show this help message and exit
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 512m)
  --picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]
                        Optional arguments to Picard's
                        CreateSequenceDictionary, OPTIONNAME=value ...
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_read_utils_mkdup_picard

### Tool Description
Mark or remove duplicate reads from BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand mkdup_picard [-h] [--outMetrics OUTMETRICS]
                                             [--remove]
                                             [--JVMmemory JVMMEMORY]
                                             [--picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]]
                                             [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                             [--version] [--tmp_dir TMP_DIR]
                                             [--tmp_dirKeep]
                                             inBams [inBams ...] outBam

Mark or remove duplicate reads from BAM file.

positional arguments:
  inBams                Input reads, BAM format.
  outBam                Output reads, BAM format.

optional arguments:
  -h, --help            show this help message and exit
  --outMetrics OUTMETRICS
                        Output metrics file. Default is to dump to a temp
                        file.
  --remove              Instead of marking duplicates, remove them entirely
                        (default: False)
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 2g)
  --picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]
                        Optional arguments to Picard's MarkDuplicates,
                        OPTIONNAME=value ...
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_read_utils_picard

### Tool Description
Generic Picard runner.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand picard [-h] [--JVMmemory JVMMEMORY]
                                       [--picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]]
                                       [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                       [--version] [--tmp_dir TMP_DIR]
                                       [--tmp_dirKeep]
                                       command

Generic Picard runner.

positional arguments:
  command               picard command

optional arguments:
  -h, --help            show this help message and exit
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 2g)
  --picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]
                        Optional arguments to Picard, OPTIONNAME=value ...
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_read_utils_rmdup_prinseq_fastq

### Tool Description
Run prinseq-lite's duplicate removal operation on paired-end reads. Also removes reads with more than one N.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand rmdup_prinseq_fastq [-h] [--includeUnmated]
                                                    [--unpairedOutFastq1 UNPAIREDOUTFASTQ1]
                                                    [--unpairedOutFastq2 UNPAIREDOUTFASTQ2]
                                                    [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                    [--version]
                                                    [--tmp_dir TMP_DIR]
                                                    [--tmp_dirKeep]
                                                    inFastq1 inFastq2
                                                    outFastq1 outFastq2

Run prinseq-lite's duplicate removal operation on paired-end reads. Also
removes reads with more than one N.

positional arguments:
  inFastq1              Input fastq file; 1st end of paired-end reads.
  inFastq2              Input fastq file; 2nd end of paired-end reads.
  outFastq1             Output fastq file; 1st end of paired-end reads.
  outFastq2             Output fastq file; 2nd end of paired-end reads.

optional arguments:
  -h, --help            show this help message and exit
  --includeUnmated      Include unmated reads in the main output fastq files
                        (default: False)
  --unpairedOutFastq1 UNPAIREDOUTFASTQ1
                        File name of output unpaired reads from 1st end of
                        paired-end reads (independent of --includeUnmated)
  --unpairedOutFastq2 UNPAIREDOUTFASTQ2
                        File name of output unpaired reads from 2nd end of
                        paired-end reads (independent of --includeUnmated)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_read_utils_gatk_realign

### Tool Description
Local realignment of BAM files with GATK IndelRealigner.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand gatk_realign [-h] [--JVMmemory JVMMEMORY]
                                             [--GATK_PATH GATK_PATH]
                                             [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                             [--version] [--tmp_dir TMP_DIR]
                                             [--tmp_dirKeep]
                                             [--threads THREADS]
                                             inBam refFasta outBam

Local realignment of BAM files with GATK IndelRealigner.

positional arguments:
  inBam                 Input reads, BAM format, aligned to refFasta.
  refFasta              Reference genome, FASTA format, pre-indexed by Picard.
  outBam                Realigned reads.

optional arguments:
  -h, --help            show this help message and exit
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 2g)
  --GATK_PATH GATK_PATH
                        A path containing the GATK jar file. This overrides
                        the GATK_ENV environment variable or the GATK conda
                        package. (default: None)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
  --threads THREADS     Number of threads (default: 1)
```

## viral-ngs_read_utils_gatk_ug

### Tool Description
Call genotypes using the GATK UnifiedGenotyper.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand gatk_ug [-h] [--options OPTIONS]
                                        [--JVMmemory JVMMEMORY]
                                        [--GATK_PATH GATK_PATH]
                                        [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                        [--version] [--tmp_dir TMP_DIR]
                                        [--tmp_dirKeep]
                                        inBam refFasta outVcf

Call genotypes using the GATK UnifiedGenotyper.

positional arguments:
  inBam                 Input reads, BAM format.
  refFasta              Reference genome, FASTA format, pre-indexed by Picard.
  outVcf                Output calls in VCF format. If this filename ends with
                        .gz, GATK will BGZIP compress the output and produce a
                        Tabix index file as well.

optional arguments:
  -h, --help            show this help message and exit
  --options OPTIONS     UnifiedGenotyper options (default:
                        --min_base_quality_score 15 -ploidy 4)
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 2g)
  --GATK_PATH GATK_PATH
                        A path containing the GATK jar file. This overrides
                        the GATK_ENV environment variable or the GATK conda
                        package. (default: None)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_read_utils_novoindex

### Tool Description
Index a reference genome with Novoindex (needs a Novoalign licence file).

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand novoindex [-h]
                                          [--NOVOALIGN_LICENSE_PATH NOVOALIGN_LICENSE_PATH]
                                          [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                          [--version]
                                          refFasta

positional arguments:
  refFasta              Reference genome, FASTA format.

optional arguments:
  -h, --help            show this help message and exit
  --NOVOALIGN_LICENSE_PATH NOVOALIGN_LICENSE_PATH
                        A path to the novoalign.lic file. This overrides the
                        NOVOALIGN_LICENSE_PATH environment variable. (default:
                        None)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_read_utils_novoalign

### Tool Description
Align reads with Novoalign. Sort and index BAM output.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand novoalign [-h] [--options OPTIONS]
                                          [--min_qual MIN_QUAL]
                                          [--JVMmemory JVMMEMORY]
                                          [--NOVOALIGN_LICENSE_PATH NOVOALIGN_LICENSE_PATH]
                                          [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                          [--version] [--tmp_dir TMP_DIR]
                                          [--tmp_dirKeep]
                                          inBam refFasta outBam

Align reads with Novoalign. Sort and index BAM output.

positional arguments:
  inBam                 Input reads, BAM format.
  refFasta              Reference genome, FASTA format, pre-indexed by
                        Novoindex.
  outBam                Output reads, BAM format (aligned).

optional arguments:
  -h, --help            show this help message and exit
  --options OPTIONS     Novoalign options (default: -r Random)
  --min_qual MIN_QUAL   Filter outBam to minimum mapping quality (default: 0)
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 2g)
  --NOVOALIGN_LICENSE_PATH NOVOALIGN_LICENSE_PATH
                        A path to the novoalign.lic file. This overrides the
                        NOVOALIGN_LICENSE_PATH environment variable. (default:
                        None)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_reports_align_and_plot_coverage

### Tool Description
Take reads, align to reference with BWA-MEM, and generate a coverage plot

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reports.py subcommand align_and_plot_coverage [-h] [--plotFormat]
                                                     [--plotDataStyle]
                                                     [--plotStyle]
                                                     [--plotWidth PLOT_WIDTH]
                                                     [--plotHeight PLOT_HEIGHT]
                                                     [--plotDPI PLOT_DPI]
                                                     [--plotTitle PLOT_TITLE]
                                                     [-q BASE_Q_THRESHOLD]
                                                     [-Q MAPPING_Q_THRESHOLD]
                                                     [-m MAX_COVERAGE_DEPTH]
                                                     [-l READ_LENGTH_THRESHOLD]
                                                     [--outSummary OUT_SUMMARY]
                                                     [--outBam OUT_BAM]
                                                     [--sensitive]
                                                     [--excludeDuplicates]
                                                     [--JVMmemory JVMMEMORY]
                                                     [--picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]]
                                                     [-T MIN_SCORE_TO_OUTPUT]
                                                     [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                     [--version]
                                                     [--tmp_dir TMP_DIR]
                                                     [--tmp_dirKeep]
                                                     in_bam out_plot_file
                                                     ref_fasta

Take reads, align to reference with BWA-MEM, and generate a coverage plot

positional arguments:
  in_bam                Input reads, BAM format.
  out_plot_file         The generated chart file
  ref_fasta             Reference genome, FASTA format.

optional arguments:
  -h, --help            show this help message and exit
  --plotFormat          File format of the coverage plot. By default it is
                        inferred from the file extension of out_plot_file, but
                        it can be set explicitly via --plotFormat. Valid
                        formats include: svgz, rgba, tif, png, ps, tiff, svg,
                        jpg, pgf, pdf, jpeg, eps, raw
  --plotDataStyle       The plot data display style. Valid options: filled,
                        line, dots (default: filled)
  --plotStyle           The plot visual style. Valid options: fivethirtyeight,
                        seaborn-dark-palette, seaborn-darkgrid, seaborn-
                        bright, seaborn-paper, grayscale, seaborn-pastel,
                        classic, dark_background, seaborn-muted, ggplot,
                        seaborn-colorblind, bmh, seaborn-deep, seaborn-poster,
                        seaborn-ticks, seaborn-white, seaborn-dark, seaborn-
                        notebook, seaborn-whitegrid, seaborn-talk (default:
                        ggplot)
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
  --outBam OUT_BAM      Output aligned, indexed BAM file. Default is to write
                        to temp.
  --sensitive           Equivalent to giving bwa: '-k 12 -A 1 -B 1 -O 1 -E 1'
  --excludeDuplicates   MarkDuplicates with Picard and only plot non-
                        duplicates
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 2g)
  --picardOptions [PICARDOPTIONS [PICARDOPTIONS ...]]
                        Optional arguments to Picard's MarkDuplicates,
                        OPTIONNAME=value ...
  -T MIN_SCORE_TO_OUTPUT
                        The min score to output during alignment (default: 30)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_reports_assembly_stats

### Tool Description
Fetch assembly-level statistics for a given sample

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: reports.py subcommand assembly_stats [-h]
                                            [--cov_thresholds COV_THRESHOLDS [COV_THRESHOLDS ...]]
                                            [--assembly_dir ASSEMBLY_DIR]
                                            [--assembly_tmp ASSEMBLY_TMP]
                                            [--align_dir ALIGN_DIR]
                                            [--reads_dir READS_DIR]
                                            [--raw_reads_dir RAW_READS_DIR]
                                            samples [samples ...] outFile

Fetch assembly-level statistics for a given sample

positional arguments:
  samples               Sample names.
  outFile               Output report file.

optional arguments:
  -h, --help            show this help message and exit
  --cov_thresholds COV_THRESHOLDS [COV_THRESHOLDS ...]
                        Genome coverage thresholds to report on. (default: (1,
                        5, 20, 100))
  --assembly_dir ASSEMBLY_DIR
                        Directory with assembly outputs. (default:
                        data/02_assembly)
  --assembly_tmp ASSEMBLY_TMP
                        Directory with assembly temp files. (default:
                        tmp/02_assembly)
  --align_dir ALIGN_DIR
                        Directory with reads aligned to own assembly.
                        (default: data/02_align_to_self)
  --reads_dir READS_DIR
                        Directory with unaligned filtered read BAMs. (default:
                        data/01_per_sample)
  --raw_reads_dir RAW_READS_DIR
                        Directory with unaligned raw read BAMs. (default:
                        data/00_raw)
```

## viral-ngs_taxon_filter_blastn_build_db

### Tool Description
Create a database for use with blastn from an input reference FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxon_filter.py subcommand blastn_build_db [-h]
                                                  [--outputFilePrefix OUTPUTFILEPREFIX]
                                                  [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                  [--version]
                                                  [--tmp_dir TMP_DIR]
                                                  [--tmp_dirKeep]
                                                  inputFasta outputDirectory

Create a database for use with blastn from an input reference FASTA file

positional arguments:
  inputFasta            Location of the input FASTA file
  outputDirectory       Location for the output files

optional arguments:
  -h, --help            show this help message and exit
  --outputFilePrefix OUTPUTFILEPREFIX
                        Prefix for the output file name (default: inputFasta
                        name, sans ".fasta" extension)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_taxon_filter_bmtagger_build_db

### Tool Description
Create a database for use with Bmtagger from an input FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxon_filter.py subcommand bmtagger_build_db [-h]
                                                    [--outputFilePrefix OUTPUTFILEPREFIX]
                                                    [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                    [--version]
                                                    [--tmp_dir TMP_DIR]
                                                    [--tmp_dirKeep]
                                                    inputFasta outputDirectory

Create a database for use with Bmtagger from an input FASTA file.

positional arguments:
  inputFasta            Location of the input FASTA file
  outputDirectory       Location for the output files (Where *.bitmask and
                        *.srprism files will be stored)

optional arguments:
  -h, --help            show this help message and exit
  --outputFilePrefix OUTPUTFILEPREFIX
                        Prefix for the output file name (default: inputFasta
                        name, sans ".fasta" extension)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_taxon_filter_lastal_build_db

### Tool Description
build a database for use with last based on an input fasta file

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxon_filter.py subcommand lastal_build_db [-h]
                                                  [--outputFilePrefix OUTPUTFILEPREFIX]
                                                  [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                  [--version]
                                                  [--tmp_dir TMP_DIR]
                                                  [--tmp_dirKeep]
                                                  inputFasta outputDirectory

build a database for use with last based on an input fasta file

positional arguments:
  inputFasta            Location of the input FASTA file
  outputDirectory       Location for the output files (default is cwd: None)

optional arguments:
  -h, --help            show this help message and exit
  --outputFilePrefix OUTPUTFILEPREFIX
                        Prefix for the output file name (default: inputFasta
                        name, sans ".fasta" extension)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_taxon_filter_deplete_bam_bmtagger

### Tool Description
Use bmtagger to deplete input reads against several databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxon_filter.py subcommand deplete_bam_bmtagger [-h]
                                                       [--threads THREADS]
                                                       [--JVMmemory JVMMEMORY]
                                                       [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                       [--version]
                                                       [--tmp_dir TMP_DIR]
                                                       [--tmp_dirKeep]
                                                       inBam refDbs
                                                       [refDbs ...] outBam

Use bmtagger to deplete input reads against several databases.

positional arguments:
  inBam                 Input BAM file.
  refDbs                Reference databases (one or more) to deplete from
                        input. For each db, requires prior creation of
                        db.bitmask by bmtool, and db.srprism.idx,
                        db.srprism.map, etc. by srprism mkindex.
  outBam                Output BAM file.

optional arguments:
  -h, --help            show this help message and exit
  --threads THREADS     The number of threads to use in running blastn.
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 4g)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_taxon_filter_deplete_blastn_bam

### Tool Description
Use blastn to remove reads that match at least one of the specified databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxon_filter.py subcommand deplete_blastn_bam [-h] [--threads THREADS]
                                                     [--chunkSize CHUNKSIZE]
                                                     [--JVMmemory JVMMEMORY]
                                                     [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                     [--version]
                                                     [--tmp_dir TMP_DIR]
                                                     [--tmp_dirKeep]
                                                     inBam refDbs [refDbs ...]
                                                     outBam

Use blastn to remove reads that match at least one of the specified databases.

positional arguments:
  inBam                 Input BAM file.
  refDbs                One or more reference databases for blast.
  outBam                Output BAM file with matching reads removed.

optional arguments:
  -h, --help            show this help message and exit
  --threads THREADS     The number of threads to use in running blastn.
  --chunkSize CHUNKSIZE
                        FASTA chunk size (default: 1000000)
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 4g)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_taxon_filter_deplete_human

### Tool Description
Run the entire depletion pipeline: bmtagger, mvicuna, blastn. Optionally, use lastal to select a specific taxon of interest.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxon_filter.py subcommand deplete_human [-h] [--taxfiltBam TAXFILTBAM]
                                                --bmtaggerDbs BMTAGGERDBS
                                                [BMTAGGERDBS ...] --blastDbs
                                                BLASTDBS [BLASTDBS ...]
                                                [--lastDb LASTDB]
                                                [--threads THREADS]
                                                [--JVMmemory JVMMEMORY]
                                                [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                [--version]
                                                [--tmp_dir TMP_DIR]
                                                [--tmp_dirKeep]
                                                inBam [revertBam] bmtaggerBam
                                                rmdupBam blastnBam

Run the entire depletion pipeline: bmtagger, mvicuna, blastn. Optionally, use
lastal to select a specific taxon of interest.

positional arguments:
  inBam                 Input BAM file.
  revertBam             Output BAM: read markup reverted with Picard.
  bmtaggerBam           Output BAM: depleted of human reads with BMTagger.
  rmdupBam              Output BAM: bmtaggerBam run through M-Vicuna duplicate
                        removal.
  blastnBam             Output BAM: rmdupBam run through another depletion of
                        human reads with BLASTN.

optional arguments:
  -h, --help            show this help message and exit
  --taxfiltBam TAXFILTBAM
                        Output BAM: blastnBam run through taxonomic selection
                        via LASTAL.
  --bmtaggerDbs BMTAGGERDBS [BMTAGGERDBS ...]
                        Reference databases (one or more) to deplete from
                        input. For each db, requires prior creation of
                        db.bitmask by bmtool, and db.srprism.idx,
                        db.srprism.map, etc. by srprism mkindex.
  --blastDbs BLASTDBS [BLASTDBS ...]
                        One or more reference databases for blast to deplete
                        from input.
  --lastDb LASTDB       One reference database for last (required if
                        --taxfiltBam is specified).
  --threads THREADS     The number of threads to use in running blastn.
  --JVMmemory JVMMEMORY
                        JVM virtual memory size for Picard FilterSamReads
                        (default: 4g)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_taxon_filter_filter_lastal_bam

### Tool Description
Restrict input reads to those that align to the given reference database using LASTAL.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxon_filter.py subcommand filter_lastal_bam [-h]
                                                    [-n MAX_GAPLESS_ALIGNMENTS_PER_POSITION]
                                                    [-l MIN_LENGTH_FOR_INITIAL_MATCHES]
                                                    [-L MAX_LENGTH_FOR_INITIAL_MATCHES]
                                                    [-m MAX_INITIAL_MATCHES_PER_POSITION]
                                                    [--JVMmemory JVMMEMORY]
                                                    [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                    [--version]
                                                    [--tmp_dir TMP_DIR]
                                                    [--tmp_dirKeep]
                                                    inBam db outBam

Restrict input reads to those that align to the given reference database using
LASTAL.

positional arguments:
  inBam                 Input reads
  db                    Database of taxa we keep
  outBam                Output reads, filtered to refDb

optional arguments:
  -h, --help            show this help message and exit
  -n MAX_GAPLESS_ALIGNMENTS_PER_POSITION
                        maximum gapless alignments per query position
                        (default: 1)
  -l MIN_LENGTH_FOR_INITIAL_MATCHES
                        minimum length for initial matches (default: 5)
  -L MAX_LENGTH_FOR_INITIAL_MATCHES
                        maximum length for initial matches (default: 50)
  -m MAX_INITIAL_MATCHES_PER_POSITION
                        maximum initial matches per query position (default:
                        100)
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 4g)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_taxon_filter_deplete_blastn

### Tool Description
Use blastn to remove reads that match at least one of the databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxon_filter.py subcommand deplete_blastn [-h] [--threads THREADS]
                                                 [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                 [--version]
                                                 [--tmp_dir TMP_DIR]
                                                 [--tmp_dirKeep]
                                                 inFastq outFastq refDbs
                                                 [refDbs ...]

Use blastn to remove reads that match at least one of the databases.

positional arguments:
  inFastq               Input fastq file.
  outFastq              Output fastq file with matching reads removed.
  refDbs                One or more reference databases for blast.

optional arguments:
  -h, --help            show this help message and exit
  --threads THREADS     The number of threads to use in running blastn.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_taxon_filter_deplete_blastn_paired

### Tool Description
Use blastn to remove reads that match at least one of the databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxon_filter.py subcommand deplete_blastn_paired [-h]
                                                        [--threads THREADS]
                                                        [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                        [--version]
                                                        [--tmp_dir TMP_DIR]
                                                        [--tmp_dirKeep]
                                                        infq1 infq2 outfq1
                                                        outfq2 refDbs
                                                        [refDbs ...]

Use blastn to remove reads that match at least one of the databases.

positional arguments:
  infq1                 Input fastq file.
  infq2                 Input fastq file.
  outfq1                Output fastq file with matching reads removed.
  outfq2                Output fastq file with matching reads removed.
  refDbs                One or more reference databases for blast.

optional arguments:
  -h, --help            show this help message and exit
  --threads THREADS     The number of threads to use in running blastn.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_taxon_filter_filter_lastal

### Tool Description
Restrict input reads to those that align to the given reference database using LASTAL. Also, remove duplicates with prinseq.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxon_filter.py subcommand filter_lastal [-h]
                                                [-n MAX_GAPLESS_ALIGNMENTS_PER_POSITION]
                                                [-l MIN_LENGTH_FOR_INITIAL_MATCHES]
                                                [-L MAX_LENGTH_FOR_INITIAL_MATCHES]
                                                [-m MAX_INITIAL_MATCHES_PER_POSITION]
                                                [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                [--version]
                                                [--tmp_dir TMP_DIR]
                                                [--tmp_dirKeep]
                                                inFastq refDb outFastq

Restrict input reads to those that align to the given reference database using
LASTAL. Also, remove duplicates with prinseq.

positional arguments:
  inFastq               Input fastq file
  refDb                 Reference database to retain from input
  outFastq              Output fastq file

optional arguments:
  -h, --help            show this help message and exit
  -n MAX_GAPLESS_ALIGNMENTS_PER_POSITION
                        maximum gapless alignments per query position
                        (default: 1)
  -l MIN_LENGTH_FOR_INITIAL_MATCHES
                        minimum length for initial matches (default: 5)
  -L MAX_LENGTH_FOR_INITIAL_MATCHES
                        maximum length for initial matches (default: 50)
  -m MAX_INITIAL_MATCHES_PER_POSITION
                        maximum initial matches per query position (default:
                        100)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_taxon_filter_partition_bmtagger

### Tool Description
Use bmtagger to partition input reads into ones that match at least one of several databases and ones that don't match any of the databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxon_filter.py subcommand partition_bmtagger [-h]
                                                     [--outMatch OUTMATCH OUTMATCH]
                                                     [--outNoMatch OUTNOMATCH OUTNOMATCH]
                                                     [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                     [--version]
                                                     [--tmp_dir TMP_DIR]
                                                     [--tmp_dirKeep]
                                                     inFastq1 inFastq2 refDbs
                                                     [refDbs ...]

Use bmtagger to partition input reads into ones that match at least one of
several databases and ones that don't match any of the databases.

positional arguments:
  inFastq1              Input fastq file; 1st end of paired-end reads.
  inFastq2              Input fastq file; 2nd end of paired-end reads. Must
                        have same names as inFastq1
  refDbs                Reference databases (one or more) to deplete from
                        input. For each db, requires prior creation of
                        db.bitmask by bmtool, and db.srprism.idx,
                        db.srprism.map, etc. by srprism mkindex.

optional arguments:
  -h, --help            show this help message and exit
  --outMatch OUTMATCH OUTMATCH
                        Filenames for fastq output of matching reads.
  --outNoMatch OUTNOMATCH OUTNOMATCH
                        Filenames for fastq output of unmatched reads.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_taxon_filter_trim_trimmomatic

### Tool Description
Trim read sequences with Trimmomatic.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxon_filter.py subcommand trim_trimmomatic [-h]
                                                   [--unpairedOutFastq1 UNPAIREDOUTFASTQ1]
                                                   [--unpairedOutFastq2 UNPAIREDOUTFASTQ2]
                                                   [--leadingQCutoff LEADING_Q_CUTOFF]
                                                   [--trailingQCutoff TRAILING_Q_CUTOFF]
                                                   [--minlengthToKeep MINLENGTH_TO_KEEP]
                                                   [--slidingWindowSize SLIDING_WINDOW_SIZE]
                                                   [--slidingWindowQCutoff SLIDING_WINDOW_Q_CUTOFF]
                                                   [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                   [--version]
                                                   [--tmp_dir TMP_DIR]
                                                   [--tmp_dirKeep]
                                                   inFastq1 inFastq2
                                                   pairedOutFastq1
                                                   pairedOutFastq2 clipFasta

Trim read sequences with Trimmomatic.

positional arguments:
  inFastq1              Input reads 1
  inFastq2              Input reads 2
  pairedOutFastq1       Paired output 1
  pairedOutFastq2       Paired output 2
  clipFasta             Fasta file with adapters, PCR sequences, etc. to clip
                        off

optional arguments:
  -h, --help            show this help message and exit
  --unpairedOutFastq1 UNPAIREDOUTFASTQ1
                        Unpaired output 1 (default: write to temp and discard)
  --unpairedOutFastq2 UNPAIREDOUTFASTQ2
                        Unpaired output 2 (default: write to temp and discard)
  --leadingQCutoff LEADING_Q_CUTOFF
                        minimum quality required to keep a base on the leading
                        end (default: 15)
  --trailingQCutoff TRAILING_Q_CUTOFF
                        minimum quality required to keep a base on the
                        trailing end (default: 15)
  --minlengthToKeep MINLENGTH_TO_KEEP
                        minimum length of reads to be kept (default: 30)
  --slidingWindowSize SLIDING_WINDOW_SIZE
                        the number of bases to average across (default: 4)
  --slidingWindowQCutoff SLIDING_WINDOW_Q_CUTOFF
                        specifies the average quality required in the sliding
                        window (default: 25)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_assembly_assemble_trinity

### Tool Description
This step runs the Trinity assembler. First trim reads with trimmomatic, rmdup with prinseq, and random subsample to no more than 100k reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assembly.py subcommand assemble_trinity [-h] [--n_reads N_READS]
                                               [--outReads OUTREADS]
                                               [--always_succeed]
                                               [--JVMmemory JVMMEMORY]
                                               [--threads THREADS]
                                               [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                               [--version] [--tmp_dir TMP_DIR]
                                               [--tmp_dirKeep]
                                               inBam clipDb outFasta

This step runs the Trinity assembler. First trim reads with trimmomatic, rmdup
with prinseq, and random subsample to no more than 100k reads.

positional arguments:
  inBam                 Input unaligned reads, BAM format.
  clipDb                Trimmomatic clip DB.
  outFasta              Output assembly.

optional arguments:
  -h, --help            show this help message and exit
  --n_reads N_READS     Subsample reads to no more than this many pairs.
                        (default 100000)
  --outReads OUTREADS   Save the trimmomatic/prinseq/subsamp reads to a BAM
                        file
  --always_succeed      If Trinity fails (usually because insufficient reads
                        to assemble), emit an empty fasta file as output.
                        Default is to throw a DenovoAssemblyError.
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 4g)
  --threads THREADS     Number of threads (default: 1)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_assembly_dpdiff

### Tool Description
Take input VCF files (all with only one sample each) and report on the discrepancies between the two DP fields (one in INFO and one in the sample's genotype column).

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assembly.py subcommand dpdiff [-h]
                                     [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                     [--version]
                                     inVcfs [inVcfs ...] outFile

Take input VCF files (all with only one sample each) and report on the
discrepancies between the two DP fields (one in INFO and one in the sample's
genotype column).

positional arguments:
  inVcfs                Input VCF file
  outFile               Output flat file

optional arguments:
  -h, --help            show this help message and exit
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_assembly_impute_from_reference

### Tool Description
This takes a de novo assembly, aligns against a reference genome, and imputes all missing positions (plus some of the chromosome ends) with the reference genome. This provides an assembly with the proper structure (but potentially wrong sequences in areas) from which we can perform further read-based refinement. Two steps: filter_short_seqs: We then toss out all assemblies that come out to < 15kb or < 95% unambiguous and fail otherwise. modify_contig: Finally, we trim off anything at the end that exceeds the length of the known reference assembly. We also replace all Ns and everything within 55bp of the chromosome ends with the reference sequence. This is clearly incorrect consensus sequence, but it allows downstream steps to map reads in parts of the genome that would otherwise be Ns, and we will correct all of the inferred positions with two steps of read-based refinement (below), and revert positions back to Ns where read support is lacking. FASTA indexing: output assembly is indexed for Picard, Samtools, Novoalign.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assembly.py subcommand impute_from_reference [-h] [--newName NEWNAME]
                                                    [--minLengthFraction MINLENGTHFRACTION]
                                                    [--minUnambig MINUNAMBIG]
                                                    [--replaceLength REPLACELENGTH]
                                                    [--aligner {muscle,mafft,mummer}]
                                                    [--index]
                                                    [--NOVOALIGN_LICENSE_PATH NOVOALIGN_LICENSE_PATH]
                                                    [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                    [--version]
                                                    [--tmp_dir TMP_DIR]
                                                    [--tmp_dirKeep]
                                                    inFasta inReference
                                                    outFasta

This takes a de novo assembly, aligns against a reference genome, and imputes
all missing positions (plus some of the chromosome ends) with the reference
genome. This provides an assembly with the proper structure (but potentially
wrong sequences in areas) from which we can perform further read-based
refinement. Two steps: filter_short_seqs: We then toss out all assemblies that
come out to < 15kb or < 95% unambiguous and fail otherwise. modify_contig:
Finally, we trim off anything at the end that exceeds the length of the known
reference assembly. We also replace all Ns and everything within 55bp of the
chromosome ends with the reference sequence. This is clearly incorrect
consensus sequence, but it allows downstream steps to map reads in parts of
the genome that would otherwise be Ns, and we will correct all of the inferred
positions with two steps of read-based refinement (below), and revert
positions back to Ns where read support is lacking. FASTA indexing: output
assembly is indexed for Picard, Samtools, Novoalign.

positional arguments:
  inFasta               Input assembly/contigs, FASTA format, already ordered,
                        oriented and merged with inReference.
  inReference           Reference genome to impute with, FASTA format.
  outFasta              Output assembly, FASTA format.

optional arguments:
  -h, --help            show this help message and exit
  --newName NEWNAME     rename output chromosome (default: do not rename)
  --minLengthFraction MINLENGTHFRACTION
                        minimum length for contig, as fraction of reference
                        (default: 0.5)
  --minUnambig MINUNAMBIG
                        minimum percentage unambiguous bases for contig
                        (default: 0.5)
  --replaceLength REPLACELENGTH
                        length of ends to be replaced with reference (default:
                        0)
  --aligner {muscle,mafft,mummer}
                        which method to use to align inFasta to inReference.
                        "muscle" = MUSCLE, "mafft" = MAFFT, "mummer" = nucmer.
                        [default: muscle]
  --index               Index outFasta for Picard/GATK, Samtools, and
                        Novoalign.
  --NOVOALIGN_LICENSE_PATH NOVOALIGN_LICENSE_PATH
                        A path to the novoalign.lic file. This overrides the
                        NOVOALIGN_LICENSE_PATH environment variable. (default:
                        None)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_assembly_modify_contig

### Tool Description
Modifies an input contig. Depending on the options selected, can replace N calls with reference calls, replace ambiguous calls with reference calls, trim to the length of the reference, replace contig ends with reference calls, and trim leading and trailing Ns. Author: rsealfon.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assembly.py subcommand modify_contig [-h] [-n NAME] [-cn] [-t] [-r5]
                                            [-r3] [-l REPLACE_LENGTH]
                                            [-f FORMAT] [-r] [-rn] [-ca]
                                            [--tmp_dir TMP_DIR]
                                            [--tmp_dirKeep]
                                            [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                            [--version]
                                            input output ref

Modifies an input contig. Depending on the options selected, can replace N
calls with reference calls, replace ambiguous calls with reference calls, trim
to the length of the reference, replace contig ends with reference calls, and
trim leading and trailing Ns. Author: rsealfon.

positional arguments:
  input                 input alignment of reference and contig (should
                        contain exactly 2 sequences)
  output                Destination file for modified contigs
  ref                   reference sequence name (exact match required)

optional arguments:
  -h, --help            show this help message and exit
  -n NAME, --name NAME  fasta header output name (default: existing header)
  -cn, --call-reference-ns
                        should the reference sequence be called if there is an
                        N in the contig and a more specific base in the
                        reference (default: False)
  -t, --trim-ends       should ends of contig.fasta be trimmed to length of
                        reference (default: False)
  -r5, --replace-5ends  should the 5'-end of contig.fasta be replaced by
                        reference (default: False)
  -r3, --replace-3ends  should the 3'-end of contig.fasta be replaced by
                        reference (default: False)
  -l REPLACE_LENGTH, --replace-length REPLACE_LENGTH
                        length of ends to be replaced (if replace-ends is yes)
                        (default: 10)
  -f FORMAT, --format FORMAT
                        Format for input alignment (default: fasta)
  -r, --replace-end-gaps
                        Replace gaps at the beginning and end of the sequence
                        with reference sequence (default: False)
  -rn, --remove-end-ns  Remove leading and trailing N's in the contig
                        (default: False)
  -ca, --call-reference-ambiguous
                        should the reference sequence be called if the contig
                        seq is ambiguous and the reference sequence is more
                        informative & consistant with the ambiguous base (ie
                        Y->C) (default: False)
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_assembly_order_and_orient

### Tool Description
This step cleans up the de novo assembly with a known reference genome. Uses MUMmer (nucmer or promer) to create a reference-based consensus sequence of aligned contigs (with runs of N's in between the de novo contigs).

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assembly.py subcommand order_and_orient [-h]
                                               [--outAlternateContigs OUTALTERNATECONTIGS]
                                               [--breaklen BREAKLEN]
                                               [--maxgap MAXGAP]
                                               [--minmatch MINMATCH]
                                               [--mincluster MINCLUSTER]
                                               [--min_pct_id MIN_PCT_ID]
                                               [--min_contig_len MIN_CONTIG_LEN]
                                               [--min_pct_contig_aligned MIN_PCT_CONTIG_ALIGNED]
                                               [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                               [--version] [--tmp_dir TMP_DIR]
                                               [--tmp_dirKeep]
                                               inFasta inReference outFasta

This step cleans up the de novo assembly with a known reference genome. Uses
MUMmer (nucmer or promer) to create a reference-based consensus sequence of
aligned contigs (with runs of N's in between the de novo contigs).

positional arguments:
  inFasta               Input de novo assembly/contigs, FASTA format.
  inReference           Reference genome for ordering, orienting, and merging
                        contigs, FASTA format.
  outFasta              Output assembly, FASTA format, with the same number of
                        chromosomes as inReference, and in the same order.

optional arguments:
  -h, --help            show this help message and exit
  --outAlternateContigs OUTALTERNATECONTIGS
                        Output sequences (FASTA format) from alternative
                        contigs that mapped, but were not chosen for the final
                        output.
  --breaklen BREAKLEN, -b BREAKLEN
                        Amount to extend alignment clusters by (if --extend).
                        nucmer default 200, promer default 60.
  --maxgap MAXGAP, -g MAXGAP
                        Maximum gap between two adjacent matches in a cluster.
                        Our default is 200. nucmer default 90, promer default
                        30. Manual suggests going to 1000.
  --minmatch MINMATCH, -l MINMATCH
                        Minimum length of an maximal exact match. Our default
                        is 10. nucmer default 20, promer default 6.
  --mincluster MINCLUSTER, -c MINCLUSTER
                        Minimum cluster length. nucmer default 65, promer
                        default 20.
  --min_pct_id MIN_PCT_ID, -i MIN_PCT_ID
                        show-tiling: minimum percent identity for contig
                        alignment (0.0 - 1.0, default: 0.6)
  --min_contig_len MIN_CONTIG_LEN
                        show-tiling: reject contigs smaller than this
                        (default: 200)
  --min_pct_contig_aligned MIN_PCT_CONTIG_ALIGNED, -v MIN_PCT_CONTIG_ALIGNED
                        show-tiling: minimum percent of contig length in
                        alignment (0.0 - 1.0, default: 0.3)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_assembly_refine_assembly

### Tool Description
This a refinement step where we take a crude assembly, align all reads back to it, and modify the assembly to the majority allele at each position based on read pileups. This step considers both SNPs as well as indels called by GATK and will correct the consensus based on GATK calls. Reads are aligned with Novoalign, then PCR duplicates are removed with Picard (in order to debias the allele counts in the pileups), and realigned with GATK's IndelRealigner (in order to call indels). Output FASTA file is indexed for Picard, Samtools, and Novoalign.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assembly.py subcommand refine_assembly [-h]
                                              [--already_realigned_bam ALREADY_REALIGNED_BAM]
                                              [--outBam OUTBAM]
                                              [--outVcf OUTVCF]
                                              [--min_coverage MIN_COVERAGE]
                                              [--major_cutoff MAJOR_CUTOFF]
                                              [--novo_params NOVO_PARAMS]
                                              [--chr_names [CHR_NAMES [CHR_NAMES ...]]]
                                              [--keep_all_reads]
                                              [--JVMmemory JVMMEMORY]
                                              [--GATK_PATH GATK_PATH]
                                              [--NOVOALIGN_LICENSE_PATH NOVOALIGN_LICENSE_PATH]
                                              [--threads THREADS]
                                              [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                              [--version] [--tmp_dir TMP_DIR]
                                              [--tmp_dirKeep]
                                              inFasta inBam outFasta

This a refinement step where we take a crude assembly, align all reads back to
it, and modify the assembly to the majority allele at each position based on
read pileups. This step considers both SNPs as well as indels called by GATK
and will correct the consensus based on GATK calls. Reads are aligned with
Novoalign, then PCR duplicates are removed with Picard (in order to debias the
allele counts in the pileups), and realigned with GATK's IndelRealigner (in
order to call indels). Output FASTA file is indexed for Picard, Samtools, and
Novoalign.

positional arguments:
  inFasta               Input assembly, FASTA format, pre-indexed for Picard,
                        Samtools, and Novoalign.
  inBam                 Input reads, unaligned BAM format.
  outFasta              Output refined assembly, FASTA format, indexed for
                        Picard, Samtools, and Novoalign.

optional arguments:
  -h, --help            show this help message and exit
  --already_realigned_bam ALREADY_REALIGNED_BAM
                        BAM with reads that are already aligned to inFasta.
                        This bypasses the alignment process by novoalign and
                        instead uses the given BAM to make an assembly. When
                        set, outBam is ignored.
  --outBam OUTBAM       Reads aligned to inFasta. Unaligned and duplicate
                        reads have been removed. GATK indel realigned.
  --outVcf OUTVCF       GATK genotype calls for genome in inFasta coordinate
                        space.
  --min_coverage MIN_COVERAGE
                        Minimum read coverage required to call a position
                        unambiguous.
  --major_cutoff MAJOR_CUTOFF
                        If the major allele is present at a frequency higher
                        than this cutoff, we will call an unambiguous base at
                        that position. If it is equal to or below this cutoff,
                        we will call an ambiguous base representing all
                        possible alleles at that position. [default: 0.5]
  --novo_params NOVO_PARAMS
                        Alignment parameters for Novoalign.
  --chr_names [CHR_NAMES [CHR_NAMES ...]]
                        Rename all output chromosomes (default: retain
                        original chromosome names)
  --keep_all_reads      Retain all reads in BAM file? Default is to remove
                        unaligned and duplicate reads.
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 2g)
  --GATK_PATH GATK_PATH
                        A path containing the GATK jar file. This overrides
                        the GATK_ENV environment variable or the GATK conda
                        package. (default: None)
  --NOVOALIGN_LICENSE_PATH NOVOALIGN_LICENSE_PATH
                        A path to the novoalign.lic file. This overrides the
                        NOVOALIGN_LICENSE_PATH environment variable. (default:
                        None)
  --threads THREADS     Number of threads (default: 1)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_assembly_trim_rmdup_subsamp

### Tool Description
Take reads through Trimmomatic, Prinseq, and subsampling. This should probably move over to read_utils or taxon_filter.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assembly.py subcommand trim_rmdup_subsamp [-h] [--n_reads N_READS]
                                                 [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                 [--version]
                                                 [--tmp_dir TMP_DIR]
                                                 [--tmp_dirKeep]
                                                 inBam clipDb outBam

Take reads through Trimmomatic, Prinseq, and subsampling. This should probably
move over to read_utils or taxon_filter.

positional arguments:
  inBam                 Input reads, unaligned BAM format.
  clipDb                Trimmomatic clip DB.
  outBam                Output reads, unaligned BAM format (currently, read
                        groups and other header information are destroyed in
                        this process).

optional arguments:
  -h, --help            show this help message and exit
  --n_reads N_READS     Subsample reads to no more than this many individual
                        reads. Note that paired reads are given priority, and
                        unpaired reads are included to reach the count if
                        there are too few paired reads to reach n_reads.
                        (default 100000)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_broad_utils_get_all_names

### Tool Description
Get all samples

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: broad_utils.py subcommand get_all_names [-h]
                                               [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                               {samples,libraries,runs}
                                               runfile

Get all samples

positional arguments:
  {samples,libraries,runs}
                        Type of name
  runfile               File with seq run information

optional arguments:
  -h, --help            show this help message and exit
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: ERROR]
```

## viral-ngs_broad_utils_get_bustard_dir

### Tool Description
Find the basecalls directory from a Picard directory

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: broad_utils.py subcommand get_bustard_dir [-h]
                                                 [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                 inDir

Find the basecalls directory from a Picard directory

positional arguments:
  inDir                 Picard directory

optional arguments:
  -h, --help            show this help message and exit
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: ERROR]
```

## viral-ngs_broad_utils_get_run_date

### Tool Description
Find the sequencing run date from a Picard directory

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: broad_utils.py subcommand get_run_date [-h]
                                              [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                              inDir

Find the sequencing run date from a Picard directory

positional arguments:
  inDir                 Picard directory

optional arguments:
  -h, --help            show this help message and exit
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: ERROR]
```

## viral-ngs_illumina_common_barcodes

### Tool Description
Extract Illumina barcodes for a run and write a TSV report of the barcode counts in descending order

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: illumina.py subcommand common_barcodes [-h]
                                              [--truncateToLength TRUNCATETOLENGTH]
                                              [--omitHeader] [--includeNoise]
                                              [--outMetrics OUTMETRICS]
                                              [--sampleSheet SAMPLESHEET]
                                              [--flowcell FLOWCELL]
                                              [--read_structure READ_STRUCTURE]
                                              [--max_mismatches MAX_MISMATCHES]
                                              [--minimum_base_quality MINIMUM_BASE_QUALITY]
                                              [--min_mismatch_delta MIN_MISMATCH_DELTA]
                                              [--max_no_calls MAX_NO_CALLS]
                                              [--minimum_quality MINIMUM_QUALITY]
                                              [--compress_outputs COMPRESS_OUTPUTS]
                                              [--JVMmemory JVMMEMORY]
                                              [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                              [--version] [--tmp_dir TMP_DIR]
                                              [--tmp_dirKeep]
                                              inDir lane outSummary

Extract Illumina barcodes for a run and write a TSV report of the barcode
counts in descending order

positional arguments:
  inDir                 Illumina BCL directory (or tar.gz of BCL directory).
                        This is the top-level run directory.
  lane                  Lane number.
  outSummary            Path to the summary file (.tsv format). It includes
                        two columns: (barcode, count)

optional arguments:
  -h, --help            show this help message and exit
  --truncateToLength TRUNCATETOLENGTH
                        If specified, only this number of barcodes will be
                        returned. Useful if you only want the top N barcodes.
  --omitHeader          If specified, a header will not be added to the
                        outSummary tsv file.
  --includeNoise        If specified, barcodes with periods (".") will be
                        included.
  --outMetrics OUTMETRICS
                        Output ExtractIlluminaBarcodes metrics file. Default
                        is to dump to a temp file.
  --sampleSheet SAMPLESHEET
                        Override SampleSheet. Input tab or CSV file w/header
                        and four named columns: barcode_name, library_name,
                        barcode_sequence_1, barcode_sequence_2. Default is to
                        look for a SampleSheet.csv in the inDir.
  --flowcell FLOWCELL   Override flowcell ID (default: read from RunInfo.xml).
  --read_structure READ_STRUCTURE
                        Override read structure (default: read from
                        RunInfo.xml).
  --max_mismatches MAX_MISMATCHES
                        Picard ExtractIlluminaBarcodes MAX_MISMATCHES
                        (default: 0)
  --minimum_base_quality MINIMUM_BASE_QUALITY
                        Picard ExtractIlluminaBarcodes MINIMUM_BASE_QUALITY
                        (default: 25)
  --min_mismatch_delta MIN_MISMATCH_DELTA
                        Picard ExtractIlluminaBarcodes MIN_MISMATCH_DELTA
                        (default: None)
  --max_no_calls MAX_NO_CALLS
                        Picard ExtractIlluminaBarcodes MAX_NO_CALLS (default:
                        None)
  --minimum_quality MINIMUM_QUALITY
                        Picard ExtractIlluminaBarcodes MINIMUM_QUALITY
                        (default: None)
  --compress_outputs COMPRESS_OUTPUTS
                        Picard ExtractIlluminaBarcodes COMPRESS_OUTPUTS
                        (default: None)
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 8g)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_illumina_extract_fc_metadata

### Tool Description
Extract RunInfo.xml and SampleSheet.csv from the provided Illumina directory

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: illumina.py subcommand extract_fc_metadata [-h]
                                                  [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                  [--version]
                                                  [--tmp_dir TMP_DIR]
                                                  [--tmp_dirKeep]
                                                  flowcell outRunInfo
                                                  outSampleSheet

Extract RunInfo.xml and SampleSheet.csv from the provided Illumina directory

positional arguments:
  flowcell              Illumina directory (possibly tarball)
  outRunInfo            Output RunInfo.xml file.
  outSampleSheet        Output SampleSheet.csv file.

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

## viral-ngs_illumina_illumina_demux

### Tool Description
Demultiplex Illumina runs & produce BAM files, one per sample. Wraps together Picard's ExtractBarcodes and IlluminaBasecallsToSam while handling the various required input formats. Also can read Illumina BCL directories, tar.gz BCL directories. TO DO: read BCL or tar.gz BCL directories from S3 / object store.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: illumina.py subcommand illumina_demux [-h] [--outMetrics OUTMETRICS]
                                             [--commonBarcodes COMMONBARCODES]
                                             [--sampleSheet SAMPLESHEET]
                                             [--flowcell FLOWCELL]
                                             [--read_structure READ_STRUCTURE]
                                             [--max_mismatches MAX_MISMATCHES]
                                             [--minimum_base_quality MINIMUM_BASE_QUALITY]
                                             [--min_mismatch_delta MIN_MISMATCH_DELTA]
                                             [--max_no_calls MAX_NO_CALLS]
                                             [--minimum_quality MINIMUM_QUALITY]
                                             [--compress_outputs COMPRESS_OUTPUTS]
                                             [--sequencing_center SEQUENCING_CENTER]
                                             [--adapters_to_check [ADAPTERS_TO_CHECK [ADAPTERS_TO_CHECK ...]]]
                                             [--platform PLATFORM]
                                             [--max_reads_in_ram_per_tile MAX_READS_IN_RAM_PER_TILE]
                                             [--max_records_in_ram MAX_RECORDS_IN_RAM]
                                             [--num_processors NUM_PROCESSORS]
                                             [--apply_eamss_filter APPLY_EAMSS_FILTER]
                                             [--force_gc FORCE_GC]
                                             [--first_tile FIRST_TILE]
                                             [--tile_limit TILE_LIMIT]
                                             [--include_non_pf_reads INCLUDE_NON_PF_READS]
                                             [--run_start_date RUN_START_DATE]
                                             [--read_group_id READ_GROUP_ID]
                                             [--JVMmemory JVMMEMORY]
                                             [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                             [--version] [--tmp_dir TMP_DIR]
                                             [--tmp_dirKeep]
                                             inDir lane outDir

Demultiplex Illumina runs & produce BAM files, one per sample. Wraps together
Picard's ExtractBarcodes and IlluminaBasecallsToSam while handling the various
required input formats. Also can read Illumina BCL directories, tar.gz BCL
directories. TO DO: read BCL or tar.gz BCL directories from S3 / object store.

positional arguments:
  inDir                 Illumina BCL directory (or tar.gz of BCL directory).
                        This is the top-level run directory.
  lane                  Lane number.
  outDir                Output directory for BAM files.

optional arguments:
  -h, --help            show this help message and exit
  --outMetrics OUTMETRICS
                        Output ExtractIlluminaBarcodes metrics file. Default
                        is to dump to a temp file.
  --commonBarcodes COMMONBARCODES
                        Write a TSV report of all barcode counts, in
                        descending order.
  --sampleSheet SAMPLESHEET
                        Override SampleSheet. Input tab or CSV file w/header
                        and four named columns: barcode_name, library_name,
                        barcode_sequence_1, barcode_sequence_2. Default is to
                        look for a SampleSheet.csv in the inDir.
  --flowcell FLOWCELL   Override flowcell ID (default: read from RunInfo.xml).
  --read_structure READ_STRUCTURE
                        Override read structure (default: read from
                        RunInfo.xml).
  --max_mismatches MAX_MISMATCHES
                        Picard ExtractIlluminaBarcodes MAX_MISMATCHES
                        (default: 0)
  --minimum_base_quality MINIMUM_BASE_QUALITY
                        Picard ExtractIlluminaBarcodes MINIMUM_BASE_QUALITY
                        (default: 25)
  --min_mismatch_delta MIN_MISMATCH_DELTA
                        Picard ExtractIlluminaBarcodes MIN_MISMATCH_DELTA
                        (default: None)
  --max_no_calls MAX_NO_CALLS
                        Picard ExtractIlluminaBarcodes MAX_NO_CALLS (default:
                        None)
  --minimum_quality MINIMUM_QUALITY
                        Picard ExtractIlluminaBarcodes MINIMUM_QUALITY
                        (default: None)
  --compress_outputs COMPRESS_OUTPUTS
                        Picard ExtractIlluminaBarcodes COMPRESS_OUTPUTS
                        (default: None)
  --sequencing_center SEQUENCING_CENTER
                        Picard IlluminaBasecallsToSam SEQUENCING_CENTER
                        (default: None)
  --adapters_to_check [ADAPTERS_TO_CHECK [ADAPTERS_TO_CHECK ...]]
                        Picard IlluminaBasecallsToSam ADAPTERS_TO_CHECK
                        (default: ('PAIRED_END', 'NEXTERA_V1', 'NEXTERA_V2'))
  --platform PLATFORM   Picard IlluminaBasecallsToSam PLATFORM (default: None)
  --max_reads_in_ram_per_tile MAX_READS_IN_RAM_PER_TILE
                        Picard IlluminaBasecallsToSam
                        MAX_READS_IN_RAM_PER_TILE (default: 100000)
  --max_records_in_ram MAX_RECORDS_IN_RAM
                        Picard IlluminaBasecallsToSam MAX_RECORDS_IN_RAM
                        (default: 100000)
  --num_processors NUM_PROCESSORS
                        Picard IlluminaBasecallsToSam NUM_PROCESSORS (default:
                        4)
  --apply_eamss_filter APPLY_EAMSS_FILTER
                        Picard IlluminaBasecallsToSam APPLY_EAMSS_FILTER
                        (default: None)
  --force_gc FORCE_GC   Picard IlluminaBasecallsToSam FORCE_GC (default:
                        False)
  --first_tile FIRST_TILE
                        Picard IlluminaBasecallsToSam FIRST_TILE (default:
                        None)
  --tile_limit TILE_LIMIT
                        Picard IlluminaBasecallsToSam TILE_LIMIT (default:
                        None)
  --include_non_pf_reads INCLUDE_NON_PF_READS
                        Picard IlluminaBasecallsToSam INCLUDE_NON_PF_READS
                        (default: False)
  --run_start_date RUN_START_DATE
                        Picard IlluminaBasecallsToSam RUN_START_DATE (default:
                        None)
  --read_group_id READ_GROUP_ID
                        Picard IlluminaBasecallsToSam READ_GROUP_ID (default:
                        None)
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 54g)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_illumina_miseq_fastq_to_bam

### Tool Description
Convert fastq read files to a single bam file. Fastq file names must conform to patterns emitted by Miseq machines. Sample metadata must be provided in a SampleSheet.csv that corresponds to the fastq filename. Specifically, the _S##_ index in the fastq file name will be used to find the corresponding row in the SampleSheet

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: illumina.py subcommand miseq_fastq_to_bam [-h] [--inFastq2 INFASTQ2]
                                                 [--runInfo RUNINFO]
                                                 [--sequencing_center SEQUENCING_CENTER]
                                                 [--JVMmemory JVMMEMORY]
                                                 [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                 [--version]
                                                 [--tmp_dir TMP_DIR]
                                                 [--tmp_dirKeep]
                                                 outBam sampleSheet inFastq1

Convert fastq read files to a single bam file. Fastq file names must conform
to patterns emitted by Miseq machines. Sample metadata must be provided in a
SampleSheet.csv that corresponds to the fastq filename. Specifically, the
_S##_ index in the fastq file name will be used to find the corresponding row
in the SampleSheet

positional arguments:
  outBam                Output BAM file.
  sampleSheet           Input SampleSheet.csv file.
  inFastq1              Input fastq file; 1st end of paired-end reads if
                        paired.

optional arguments:
  -h, --help            show this help message and exit
  --inFastq2 INFASTQ2   Input fastq file; 2nd end of paired-end reads.
  --runInfo RUNINFO     Input RunInfo.xml file.
  --sequencing_center SEQUENCING_CENTER
                        Name of your sequencing center (default is the
                        sequencing machine ID from the RunInfo.xml)
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 2g)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_interhost_multichr_mafft

### Tool Description
Run the mafft alignment on a series of chromosomes provided in sample- partitioned FASTA files. Output as FASTA. (i.e. file1.fasta would contain chr1, chr2, chr3; file2.fasta would also contain chr1, chr2, chr3)

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: interhost.py subcommand multichr_mafft [-h]
                                              [--localpair | --globalpair]
                                              [--preservecase] [--reorder]
                                              [--gapOpeningPenalty GAPOPENINGPENALTY]
                                              [--ep EP] [--verbose]
                                              [--outputAsClustal]
                                              [--maxiters MAXITERS]
                                              [--threads THREADS]
                                              [--outFilePrefix OUTFILEPREFIX]
                                              [--sampleRelationFile SAMPLERELATIONFILE]
                                              [--sampleNameListFile SAMPLENAMELISTFILE]
                                              [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                              [--version] [--tmp_dir TMP_DIR]
                                              [--tmp_dirKeep]
                                              inFastas [inFastas ...]
                                              outDirectory

Run the mafft alignment on a series of chromosomes provided in sample-
partitioned FASTA files. Output as FASTA. (i.e. file1.fasta would contain
chr1, chr2, chr3; file2.fasta would also contain chr1, chr2, chr3)

positional arguments:
  inFastas              Input FASTA files.
  outDirectory          Location for the output files (default is cwd: None)

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
  --outFilePrefix OUTFILEPREFIX
                        Prefix for the output file name (default: aligned)
  --sampleRelationFile SAMPLERELATIONFILE
                        If the parameter sampleRelationFile is specified (as a
                        file path), a JSON file will be written mapping sample
                        name to sequence position in the output.
  --sampleNameListFile SAMPLENAMELISTFILE
                        If the parameter sampleRelationFile is specified (as a
                        file path), a file will be written mapping sample
                        names in the order of their sequence positions in the
                        output.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_intrahost_merge_to_vcf

### Tool Description
Combine and convert vPhaser2 parsed filtered output text files into VCF format. Assumption: consensus assemblies used in creating alignments do not extend beyond ends of reference. the number of alignment files equals the number of chromosomes / segments

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: intrahost.py subcommand merge_to_vcf [-h] --samples SAMPLES
                                            [SAMPLES ...] --isnvs ISNVS
                                            [ISNVS ...] --alignments
                                            ALIGNMENTS [ALIGNMENTS ...]
                                            [--strip_chr_version]
                                            [--naive_filter]
                                            [--parse_accession]
                                            [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                            [--version]
                                            refFasta outVcf

Combine and convert vPhaser2 parsed filtered output text files into VCF
format. Assumption: consensus assemblies used in creating alignments do not
extend beyond ends of reference. the number of alignment files equals the
number of chromosomes / segments

positional arguments:
  refFasta              The target reference genome. outVcf will use these
                        chromosome names, coordinate spaces, and reference
                        alleles
  outVcf                Output VCF file containing all variants

optional arguments:
  -h, --help            show this help message and exit
  --samples SAMPLES [SAMPLES ...]
                        A list of sample names
  --isnvs ISNVS [ISNVS ...]
                        A list of file names from the output of
                        vphaser_one_sample These must be in the SAME ORDER as
                        samples.
  --alignments ALIGNMENTS [ALIGNMENTS ...]
                        a list of fasta files containing multialignment of
                        input assemblies, with one file per
                        chromosome/segment. Each alignment file will contain a
                        line for each sample, as well as the reference genome
                        to which they were aligned.
  --strip_chr_version   If set, strip any trailing version numbers from the
                        chromosome names. If the chromosome name ends with a
                        period followed by integers, this is interepreted as a
                        version number to be removed. This is because Genbank
                        accession numbers are often used by SnpEff databases
                        downstream, but without the corresponding version
                        number. Default is false (leave chromosome names
                        untouched).
  --naive_filter        If set, keep only the alleles that have at least two
                        independent libraries of support and allele freq >
                        0.005. Default is false (do not filter at this stage).
  --parse_accession     If set, parse only the accession for the chromosome
                        name. Helpful if snpEff has to create its own database
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_intrahost_tabfile_rename

### Tool Description
Take input tab file and copy to an output file while changing the values in a specific column based on a mapping file. The first line will pass through untouched (it is assumed to be a header).

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: intrahost.py subcommand tabfile_rename [-h] [--col_idx COL]
                                              [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                              [--version]
                                              inFile mapFile outFile

Take input tab file and copy to an output file while changing the values in a
specific column based on a mapping file. The first line will pass through
untouched (it is assumed to be a header).

positional arguments:
  inFile                Input flat file
  mapFile               Map file. Two-column headerless file that maps input
                        values to output values. This script will error if
                        there are values in inFile that do not exist in
                        mapFile.
  outFile               Output flat file

optional arguments:
  -h, --help            show this help message and exit
  --col_idx COL         Which column number to replace (0-based index).
                        [default: 0]
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_intrahost_vphaser

### Tool Description
Run V-Phaser 2 on the input file without any additional filtering. Combine the non-header lines of the CHROM.var.raw.txt files it produces, adding CHROM as the first field on each line.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: intrahost.py subcommand vphaser [-h] [--numThreads NUMTHREADS]
                                       [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                       [--version]
                                       inBam outTab

Run V-Phaser 2 on the input file without any additional filtering. Combine the
non-header lines of the CHROM.var.raw.txt files it produces, adding CHROM as
the first field on each line.

positional arguments:
  inBam                 Input Bam file.
  outTab                Tab-separated headerless output file.

optional arguments:
  -h, --help            show this help message and exit
  --numThreads NUMTHREADS
                        Number of threads in call to V-Phaser 2.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_metagenomics_align_rna

### Tool Description
Align to metagenomics bwa index, mark duplicates, and generate LCA report

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metagenomics.py subcommand align_rna [-h] [--dupeReport DUPEREPORT]
                                            [--noSensitive] [--outBam OUTBAM]
                                            [--outLca OUTLCA]
                                            [--dupeLca DUPELCA]
                                            [--numThreads NUMTHREADS]
                                            [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                            [--version] [--tmp_dir TMP_DIR]
                                            [--tmp_dirKeep]
                                            inBam db taxDb outReport

Align to metagenomics bwa index, mark duplicates, and generate LCA report

positional arguments:
  inBam                 Input unaligned reads, BAM format.
  db                    Bwa index prefix.
  taxDb                 Taxonomy database directory.
  outReport             Output taxonomy report.

optional arguments:
  -h, --help            show this help message and exit
  --dupeReport DUPEREPORT
                        Generate report including duplicates.
  --noSensitive         Use default BWA mem options instead of sensitive
                        options.
  --outBam OUTBAM       Output aligned, indexed BAM file. Default is to write
                        to temp.
  --outLca OUTLCA       Output LCA assignments for each read.
  --dupeLca DUPELCA     Output LCA assignments for each read including
                        duplicates.
  --numThreads NUMTHREADS
                        Number of threads (default: 1)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_metagenomics_diamond

### Tool Description
Classify reads by the taxon of the Lowest Common Ancestor (LCA)

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metagenomics.py subcommand diamond [-h] [--outM8 OUTM8]
                                          [--outLca OUTLCA]
                                          [--numThreads NUMTHREADS]
                                          [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                          [--version] [--tmp_dir TMP_DIR]
                                          [--tmp_dirKeep]
                                          inBam db taxDb outReport

Classify reads by the taxon of the Lowest Common Ancestor (LCA)

positional arguments:
  inBam                 Input unaligned reads, BAM format.
  db                    Diamond database directory.
  taxDb                 Taxonomy database directory.
  outReport             Output taxonomy report.

optional arguments:
  -h, --help            show this help message and exit
  --outM8 OUTM8         Blast m8 formatted output file.
  --outLca OUTLCA       Output LCA assignments for each read.
  --numThreads NUMTHREADS
                        Number of threads (default: 1)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_metagenomics_kraken

### Tool Description
Classify reads by taxon using Kraken

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metagenomics.py subcommand kraken [-h] [--outReport OUTREPORT]
                                         [--outReads OUTREADS]
                                         [--filterThreshold FILTERTHRESHOLD]
                                         [--numThreads NUMTHREADS]
                                         [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                         [--version] [--tmp_dir TMP_DIR]
                                         [--tmp_dirKeep]
                                         inBam db

Classify reads by taxon using Kraken

positional arguments:
  inBam                 Input unaligned reads, BAM format.
  db                    Kraken database directory.

optional arguments:
  -h, --help            show this help message and exit
  --outReport OUTREPORT
                        Kraken report output file.
  --outReads OUTREADS   Kraken per read output file.
  --filterThreshold FILTERTHRESHOLD
                        Kraken filter threshold (default 0.05)
  --numThreads NUMTHREADS
                        Number of threads to run. (default 1)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_metagenomics_krona

### Tool Description
Create an interactive HTML report from a tabular metagenomic report

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metagenomics.py subcommand krona [-h] [--queryColumn QUERYCOLUMN]
                                        [--taxidColumn TAXIDCOLUMN]
                                        [--scoreColumn SCORECOLUMN] [--noHits]
                                        [--noRank]
                                        [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                        [--version]
                                        inTsv db outHtml

Create an interactive HTML report from a tabular metagenomic report

positional arguments:
  inTsv                 Input tab delimited file.
  db                    Krona taxonomy database directory.
  outHtml               Output html report.

optional arguments:
  -h, --help            show this help message and exit
  --queryColumn QUERYCOLUMN
                        Column of query id. (default 2)
  --taxidColumn TAXIDCOLUMN
                        Column of taxonomy id. (default 3)
  --scoreColumn SCORECOLUMN
                        Column of score. (default None)
  --noHits              Include wedge for no hits.
  --noRank              Include no rank assignments.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_metagenomics_report_merge

### Tool Description
Merge multiple metegenomic reports into a single metagenomic report. Any Krona input files created by this

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: metagenomics.py subcommand report_merge [-h]
                                               [--outSummaryReport OUT_KRAKEN_SUMMARY]
                                               [--krakenDB KRAKEN_DB]
                                               [--outByQueryToTaxonID OUT_KRONA_INPUT]
                                               [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                               [--version] [--tmp_dir TMP_DIR]
                                               [--tmp_dirKeep]
                                               metagenomic_reports
                                               [metagenomic_reports ...]

Merge multiple metegenomic reports into a single metagenomic report. Any Krona
input files created by this

positional arguments:
  metagenomic_reports   Input metagenomic reports with the query ID and taxon
                        ID in the 2nd and 3rd columns (Kraken format)

optional arguments:
  -h, --help            show this help message and exit
  --outSummaryReport OUT_KRAKEN_SUMMARY
                        Path of human-readable metagenomic summary report,
                        created by kraken-report
  --krakenDB KRAKEN_DB  Kraken database (needed for outSummaryReport)
  --outByQueryToTaxonID OUT_KRONA_INPUT
                        Output metagenomic report suitable for Krona input.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_ncbi_fetch_fastas

### Tool Description
This function downloads and saves the FASTA files from the Genbank CoreNucleotide database given a given list of accession IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ncbi.py subcommand fetch_fastas [-h] [--forceOverwrite]
                                       [--combinedFilePrefix COMBINEDFILEPREFIX]
                                       [--fileExt FILEEXT]
                                       [--removeSeparateFiles]
                                       [--chunkSize CHUNKSIZE]
                                       [--tmp_dir TMP_DIR] [--tmp_dirKeep]
                                       [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                       [--version]
                                       emailAddress destinationDir
                                       accession_IDs [accession_IDs ...]

This function downloads and saves the FASTA files from the Genbank
CoreNucleotide database given a given list of accession IDs.

positional arguments:
  emailAddress          Your email address. To access the Genbank
                        CoreNucleotide database, NCBI requires you to specify
                        your email address with each request. In case of
                        excessive usage of the E-utilities, NCBI will attempt
                        to contact a user at the email address provided before
                        blocking access. This email address should be
                        registered with NCBI. To register an email address,
                        simply send an email to eutilities@ncbi.nlm.nih.gov
                        including your email address and the tool name
                        (tool='https://github.com/broadinstitute/viral-ngs').
  destinationDir        Output directory with where .fasta and .tbl files will
                        be saved
  accession_IDs         List of Genbank nuccore accession IDs

optional arguments:
  -h, --help            show this help message and exit
  --forceOverwrite      Overwrite existing files, if present.
  --combinedFilePrefix COMBINEDFILEPREFIX
                        The prefix of the file containing the combined
                        concatenated results returned by the list of accession
                        IDs, in the order provided.
  --fileExt FILEEXT     The extension to use for the downloaded files
  --removeSeparateFiles
                        If specified, remove the individual files and leave
                        only the combined file.
  --chunkSize CHUNKSIZE
                        Causes files to be downloaded from GenBank in chunks
                        of N accessions. Each chunk will be its own combined
                        file, separate from any combined file created via
                        --combinedFilePrefix (default: 1). If chunkSize is
                        unspecified and >500 accessions are provided,
                        chunkSize will be set to 500 to adhere to the NCBI
                        guidelines on information retreival.
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_ncbi_fetch_feature_tables

### Tool Description
This function downloads and saves feature tables from the Genbank CoreNucleotide database given a given list of accession IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ncbi.py subcommand fetch_feature_tables [-h] [--forceOverwrite]
                                               [--combinedFilePrefix COMBINEDFILEPREFIX]
                                               [--fileExt FILEEXT]
                                               [--removeSeparateFiles]
                                               [--chunkSize CHUNKSIZE]
                                               [--tmp_dir TMP_DIR]
                                               [--tmp_dirKeep]
                                               [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                               [--version]
                                               emailAddress destinationDir
                                               accession_IDs
                                               [accession_IDs ...]

This function downloads and saves feature tables from the Genbank
CoreNucleotide database given a given list of accession IDs.

positional arguments:
  emailAddress          Your email address. To access the Genbank
                        CoreNucleotide database, NCBI requires you to specify
                        your email address with each request. In case of
                        excessive usage of the E-utilities, NCBI will attempt
                        to contact a user at the email address provided before
                        blocking access. This email address should be
                        registered with NCBI. To register an email address,
                        simply send an email to eutilities@ncbi.nlm.nih.gov
                        including your email address and the tool name
                        (tool='https://github.com/broadinstitute/viral-ngs').
  destinationDir        Output directory with where .fasta and .tbl files will
                        be saved
  accession_IDs         List of Genbank nuccore accession IDs

optional arguments:
  -h, --help            show this help message and exit
  --forceOverwrite      Overwrite existing files, if present.
  --combinedFilePrefix COMBINEDFILEPREFIX
                        The prefix of the file containing the combined
                        concatenated results returned by the list of accession
                        IDs, in the order provided.
  --fileExt FILEEXT     The extension to use for the downloaded files
  --removeSeparateFiles
                        If specified, remove the individual files and leave
                        only the combined file.
  --chunkSize CHUNKSIZE
                        Causes files to be downloaded from GenBank in chunks
                        of N accessions. Each chunk will be its own combined
                        file, separate from any combined file created via
                        --combinedFilePrefix (default: 1). If chunkSize is
                        unspecified and >500 accessions are provided,
                        chunkSize will be set to 500 to adhere to the NCBI
                        guidelines on information retreival.
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_ncbi_fetch_genbank_records

### Tool Description
This function downloads and saves full flat text records from Genbank CoreNucleotide database given a given list of accession IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ncbi.py subcommand fetch_genbank_records [-h] [--forceOverwrite]
                                                [--combinedFilePrefix COMBINEDFILEPREFIX]
                                                [--fileExt FILEEXT]
                                                [--removeSeparateFiles]
                                                [--chunkSize CHUNKSIZE]
                                                [--tmp_dir TMP_DIR]
                                                [--tmp_dirKeep]
                                                [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                [--version]
                                                emailAddress destinationDir
                                                accession_IDs
                                                [accession_IDs ...]

This function downloads and saves full flat text records from Genbank
CoreNucleotide database given a given list of accession IDs.

positional arguments:
  emailAddress          Your email address. To access the Genbank
                        CoreNucleotide database, NCBI requires you to specify
                        your email address with each request. In case of
                        excessive usage of the E-utilities, NCBI will attempt
                        to contact a user at the email address provided before
                        blocking access. This email address should be
                        registered with NCBI. To register an email address,
                        simply send an email to eutilities@ncbi.nlm.nih.gov
                        including your email address and the tool name
                        (tool='https://github.com/broadinstitute/viral-ngs').
  destinationDir        Output directory with where .fasta and .tbl files will
                        be saved
  accession_IDs         List of Genbank nuccore accession IDs

optional arguments:
  -h, --help            show this help message and exit
  --forceOverwrite      Overwrite existing files, if present.
  --combinedFilePrefix COMBINEDFILEPREFIX
                        The prefix of the file containing the combined
                        concatenated results returned by the list of accession
                        IDs, in the order provided.
  --fileExt FILEEXT     The extension to use for the downloaded files
  --removeSeparateFiles
                        If specified, remove the individual files and leave
                        only the combined file.
  --chunkSize CHUNKSIZE
                        Causes files to be downloaded from GenBank in chunks
                        of N accessions. Each chunk will be its own combined
                        file, separate from any combined file created via
                        --combinedFilePrefix (default: 1). If chunkSize is
                        unspecified and >500 accessions are provided,
                        chunkSize will be set to 500 to adhere to the NCBI
                        guidelines on information retreival.
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_ncbi_prep_genbank_files

### Tool Description
Prepare genbank submission files. Requires .fasta and .tbl files as input, as well as numerous other metadata files for the submission. Creates a directory full of files (.sqn in particular) that can be sent to GenBank.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ncbi.py subcommand prep_genbank_files [-h] [--comment COMMENT]
                                             [--sequencing_tech SEQUENCING_TECH]
                                             [--master_source_table MASTER_SOURCE_TABLE]
                                             [--biosample_map BIOSAMPLE_MAP]
                                             [--coverage_table COVERAGE_TABLE]
                                             [--tmp_dir TMP_DIR]
                                             [--tmp_dirKeep]
                                             [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                             [--version]
                                             templateFile fasta_files
                                             [fasta_files ...] annotDir

Prepare genbank submission files. Requires .fasta and .tbl files as input, as
well as numerous other metadata files for the submission. Creates a directory
full of files (.sqn in particular) that can be sent to GenBank.

positional arguments:
  templateFile          Submission template file (.sbt) including author and
                        contact info
  fasta_files           Input fasta files
  annotDir              Output directory with genbank submission files (.tbl
                        files must already be there)

optional arguments:
  -h, --help            show this help message and exit
  --comment COMMENT     comment field
  --sequencing_tech SEQUENCING_TECH
                        sequencing technology (e.g. Illumina HiSeq 2500)
  --master_source_table MASTER_SOURCE_TABLE
                        source modifier table
  --biosample_map BIOSAMPLE_MAP
                        A file with two columns and a header: sample and
                        BioSample. This file may refer to samples that are not
                        included in this submission.
  --coverage_table COVERAGE_TABLE
                        A genome coverage report file with a header row. The
                        table must have at least two columns named sample and
                        aln2self_cov_median. All other columns are ignored.
                        Rows referring to samples not in this submission are
                        ignored.
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_ncbi_prep_sra_table

### Tool Description
This is a very lazy hack that creates a basic table that can be pasted into various columns of an SRA submission spreadsheet. It probably doesn't work in all cases.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ncbi.py subcommand prep_sra_table [-h]
                                         [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                         [--version]
                                         lib_fname biosampleFile md5_fname
                                         outFile

This is a very lazy hack that creates a basic table that can be pasted into
various columns of an SRA submission spreadsheet. It probably doesn't work in
all cases.

positional arguments:
  lib_fname             A file that lists all of the library IDs that will be
                        submitted in this batch
  biosampleFile         A file with two columns and a header: sample and
                        BioSample. This file may refer to samples that are not
                        included in this submission.
  md5_fname             A file with two columns and no header. Two columns are
                        MD5 checksum and filename. Should contain an entry for
                        every bam file being submitted in this batch. This is
                        typical output from "md5sum *.cleaned.bam".
  outFile               Output table that contains most of the variable
                        columns needed for SRA submission.

optional arguments:
  -h, --help            show this help message and exit
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_ncbi_tbl_transfer

### Tool Description
This function takes an NCBI TBL file describing features on a genome (genes, etc) and transfers them to a new genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ncbi.py subcommand tbl_transfer [-h] [--oob_clip] [--tmp_dir TMP_DIR]
                                       [--tmp_dirKeep]
                                       [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                       [--version]
                                       ref_fasta ref_tbl alt_fasta out_tbl

This function takes an NCBI TBL file describing features on a genome (genes,
etc) and transfers them to a new genome.

positional arguments:
  ref_fasta             Input sequence of reference genome
  ref_tbl               Input reference annotations (NCBI TBL format)
  alt_fasta             Input sequence of new genome
  out_tbl               Output file with transferred annotations

optional arguments:
  -h, --help            show this help message and exit
  --oob_clip            Out of bounds feature behavior. False: drop all
                        features that are completely or partly out of bounds
                        True: drop all features completely out of bounds but
                        truncate any features that are partly out of bounds
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_ncbi_tbl_transfer_prealigned

### Tool Description
This breaks out the ref and alt sequences into separate fasta files, and then creates unified files containing the reference sequence first and the alt second. Each of these unified files is then passed as a cmap to tbl_transfer_common. This function expects to receive one fasta file containing a multialignment of a single segment/chromosome along with the respective reference sequence for that segment/chromosome. It also expects a reference containing all reference segments/chromosomes, so that the reference sequence can be identified in the input file by name. It also expects a list of reference tbl files, where each file is named according to the ID present for its corresponding sequence in the refFasta. For each non-reference sequence present in the inputFasta, two files are written: a fasta containing the segment/chromosome for the same, along with its corresponding feature table as created by tbl_transfer_common.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ncbi.py subcommand tbl_transfer_prealigned [-h] [--oob_clip]
                                                  [--tmp_dir TMP_DIR]
                                                  [--tmp_dirKeep]
                                                  [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                  [--version]
                                                  inputFasta refFasta
                                                  refAnnotTblFiles
                                                  [refAnnotTblFiles ...]
                                                  outputDir

This breaks out the ref and alt sequences into separate fasta files, and then
creates unified files containing the reference sequence first and the alt
second. Each of these unified files is then passed as a cmap to
tbl_transfer_common. This function expects to receive one fasta file
containing a multialignment of a single segment/chromosome along with the
respective reference sequence for that segment/chromosome. It also expects a
reference containing all reference segments/chromosomes, so that the reference
sequence can be identified in the input file by name. It also expects a list
of reference tbl files, where each file is named according to the ID present
for its corresponding sequence in the refFasta. For each non-reference
sequence present in the inputFasta, two files are written: a fasta containing
the segment/chromosome for the same, along with its corresponding feature
table as created by tbl_transfer_common.

positional arguments:
  inputFasta            FASTA file containing input sequences, including pre-
                        made alignments and reference sequence
  refFasta              FASTA file containing the reference genome
  refAnnotTblFiles      Name of the reference feature tables, each of which
                        should have a filename comrised of [refId].tbl so they
                        can be matched against the reference sequences
  outputDir             The output directory

optional arguments:
  -h, --help            show this help message and exit
  --oob_clip            Out of bounds feature behavior. False: drop all
                        features that are completely or partly out of bounds
                        True: drop all features completely out of bounds but
                        truncate any features that are partly out of bounds
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
```

## viral-ngs_read_utils_align_and_fix

### Tool Description
Take reads, align to reference with Novoalign, mark duplicates with Picard, realign indels with GATK, and optionally filter final file to mapped/non-dupe reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand align_and_fix [-h] [--outBamAll OUTBAMALL]
                                              [--outBamFiltered OUTBAMFILTERED]
                                              [--aligner_options ALIGNER_OPTIONS]
                                              [--aligner {novoalign,bwa}]
                                              [--JVMmemory JVMMEMORY]
                                              [--threads THREADS]
                                              [--GATK_PATH GATK_PATH]
                                              [--NOVOALIGN_LICENSE_PATH NOVOALIGN_LICENSE_PATH]
                                              [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                              [--version] [--tmp_dir TMP_DIR]
                                              [--tmp_dirKeep]
                                              inBam refFasta

Take reads, align to reference with Novoalign, mark duplicates with Picard,
realign indels with GATK, and optionally filter final file to mapped/non-dupe
reads.

positional arguments:
  inBam                 Input unaligned reads, BAM format.
  refFasta              Reference genome, FASTA format; will be indexed by
                        Picard and Novoalign.

optional arguments:
  -h, --help            show this help message and exit
  --outBamAll OUTBAMALL
                        Aligned, sorted, and indexed reads. Unmapped reads are
                        retained and duplicate reads are marked, not removed.
  --outBamFiltered OUTBAMFILTERED
                        Aligned, sorted, and indexed reads. Unmapped reads and
                        duplicate reads are removed from this file.
  --aligner_options ALIGNER_OPTIONS
                        aligner options (default for novoalign: "-r Random",
                        bwa: "-T 30"
  --aligner {novoalign,bwa}
                        aligner (default: novoalign)
  --JVMmemory JVMMEMORY
                        JVM virtual memory size (default: 4g)
  --threads THREADS     Number of threads (default: 1)
  --GATK_PATH GATK_PATH
                        A path containing the GATK jar file. This overrides
                        the GATK_ENV environment variable or the GATK conda
                        package. (default: None)
  --NOVOALIGN_LICENSE_PATH NOVOALIGN_LICENSE_PATH
                        A path to the novoalign.lic file. This overrides the
                        NOVOALIGN_LICENSE_PATH environment variable. (default:
                        None)
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_read_utils_bwamem_idxstats

### Tool Description
Take reads, align to reference with BWA-MEM and perform samtools idxstats.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand bwamem_idxstats [-h] [--outBam OUTBAM]
                                                [--outStats OUTSTATS]
                                                [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                [--version]
                                                [--tmp_dir TMP_DIR]
                                                [--tmp_dirKeep]
                                                inBam refFasta

Take reads, align to reference with BWA-MEM and perform samtools idxstats.

positional arguments:
  inBam                 Input unaligned reads, BAM format.
  refFasta              Reference genome, FASTA format, pre-indexed by Picard
                        and Novoalign.

optional arguments:
  -h, --help            show this help message and exit
  --outBam OUTBAM       Output aligned, indexed BAM file
  --outStats OUTSTATS   Output idxstats file
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

## viral-ngs_read_utils_dup_remove_mvicuna

### Tool Description
Run mvicuna's duplicate removal operation on paired-end reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
- **Homepage**: https://github.com/broadinstitute/viral-ngs
- **Package**: https://anaconda.org/channels/bioconda/packages/viral-ngs/overview
- **Validation**: PASS

### Original Help Text
```text
usage: read_utils.py subcommand dup_remove_mvicuna [-h]
                                                   [--unpairedOutFastq UNPAIREDOUTFASTQ]
                                                   [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}]
                                                   [--version]
                                                   [--tmp_dir TMP_DIR]
                                                   [--tmp_dirKeep]
                                                   inFastq1 inFastq2
                                                   pairedOutFastq1
                                                   pairedOutFastq2

Run mvicuna's duplicate removal operation on paired-end reads.

positional arguments:
  inFastq1              Input fastq file; 1st end of paired-end reads.
  inFastq2              Input fastq file; 2nd end of paired-end reads.
  pairedOutFastq1       Output fastq file; 1st end of paired-end reads.
  pairedOutFastq2       Output fastq file; 2nd end of paired-end reads.

optional arguments:
  -h, --help            show this help message and exit
  --unpairedOutFastq UNPAIREDOUTFASTQ
                        File name of output unpaired reads
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL,EXCEPTION}
                        Verboseness of output. [default: DEBUG]
  --version, -V         show program's version number and exit
  --tmp_dir TMP_DIR     Base directory for temp files. [default: /tmp]
  --tmp_dirKeep         Keep the tmp_dir if an exception occurs while running.
                        Default is to delete all temp files at the end, even
                        if there's a failure.
```

