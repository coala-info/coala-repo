# art_modern CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| art_modern | PASS |  |
| art_modern_am_compress | PASS |  |
| art_modern_art_profile_builder | PASS |  |

## art_modern

### Tool Description
YuZJ Modified ART_Illumina (art_modern): simulates Illumina reads from a reference genome, transcriptome or templates.

### Metadata
- **Docker Image**: quay.io/biocontainers/art_modern:1.5.1--hc80e578_0
- **Homepage**: https://github.com/YU-Zhejian/art_modern
- **Package**: https://anaconda.org/channels/bioconda/packages/art_modern/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/art_modern/overview
- **Total Downloads**: 9.9K
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/YU-Zhejian/art_modern
- **Stars**: 13

### Original Help Text
```text
General Options:
  --help                                print out usage information
  --version                             display version info

Required Options:
  --mode arg (=wgs)                     simulation mode, should be wgs, trans, 
                                        template.
  --lc arg (=se)                        library construction mode, should be 
                                        se, pe, mp.
  --i-seed arg                          Random seed for simulation. If not 
                                        specified, will be generated at random.
  --i-parser arg (=auto)                input file parser, should be auto, 
                                        memory, htslib, stream.
  --i-type arg (=auto)                  input file type, should be auto, fasta,
                                        pbsim3_transcripts.
  --i-batch_size arg (=16384)           Batch size for stream input parser
  --i-file arg                          the filename of input reference genome,
                                        reference transcriptome, or templates
  --i-fcov arg (=0.0)                   the fold of read coverage to be 
                                        simulated or number of reads/read pairs
                                        generated for each sequence for 
                                        simulating cDNA reads, or a double for 
                                        simulating WGS reads.

PWA Output:
  --o-pwa arg                           Destination of output pwa file. Unset 
                                        to disable the writer.
  --o-pwa-compression arg               Compression type for the output file. 
                                        Supported values are 'gzip', 'bgzip', 
                                        and 'none'. If not set, it will be 
                                        inferred from the file extension.
  --o-pwa-compression_level arg (=6)    Compression level for gzip compression.
                                        Valid values are typically between 1 
                                        (fastest) and 9 (best compression). 
                                        Default is 6. Not used when no 
                                        compression.
  --o-pwa-buffer_size arg (=1048576)    Buffer size in bytes for writing. 
                                        Default is 1 MiB (1048576 bytes).
  --o-pwa-num_threads arg (=1)          Number of threads to use for 
                                        compression. Only applicable for bgzip 
                                        compression. Default is 1 (no 
                                        multithreading).
  --o-pwa-queue_size arg (=1048576)     Size of the lock-free queue used in PWA
                                        output.

FASTA Output:
  --o-fasta arg                         Destination of output fasta file. Unset
                                        to disable the writer.
  --o-fasta-compression arg             Compression type for the output file. 
                                        Supported values are 'gzip', 'bgzip', 
                                        and 'none'. If not set, it will be 
                                        inferred from the file extension.
  --o-fasta-compression_level arg (=6)  Compression level for gzip compression.
                                        Valid values are typically between 1 
                                        (fastest) and 9 (best compression). 
                                        Default is 6. Not used when no 
                                        compression.
  --o-fasta-buffer_size arg (=1048576)  Buffer size in bytes for writing. 
                                        Default is 1 MiB (1048576 bytes).
  --o-fasta-num_threads arg (=1)        Number of threads to use for 
                                        compression. Only applicable for bgzip 
                                        compression. Default is 1 (no 
                                        multithreading).
  --o-fasta-queue_size arg (=1048576)   Size of the lock-free queue used in 
                                        FASTA output.

FASTQ Output:
  --o-fastq arg                         Destination of output fastq file. Unset
                                        to disable the writer.
  --o-fastq-compression arg             Compression type for the output file. 
                                        Supported values are 'gzip', 'bgzip', 
                                        and 'none'. If not set, it will be 
                                        inferred from the file extension.
  --o-fastq-compression_level arg (=6)  Compression level for gzip compression.
                                        Valid values are typically between 1 
                                        (fastest) and 9 (best compression). 
                                        Default is 6. Not used when no 
                                        compression.
  --o-fastq-buffer_size arg (=1048576)  Buffer size in bytes for writing. 
                                        Default is 1 MiB (1048576 bytes).
  --o-fastq-num_threads arg (=1)        Number of threads to use for 
                                        compression. Only applicable for bgzip 
                                        compression. Default is 1 (no 
                                        multithreading).
  --o-fastq-queue_size arg (=1048576)   Size of the lock-free queue used in 
                                        FASTQ output.

SAM/BAM Output:
  --o-sam arg                           Destination of output SAM/BAM file. 
                                        Unset to disable the writer.
  --o-sam-use_m                         Whether to use CIGAR 'M' instead of 
                                        '=/X' for alignment
  --o-sam-write_bam                     Enforce BAM instead of SAM output.
  --o-sam-num_threads arg (=4)          Number of threads used in BAM 
                                        compression.
  --o-sam-compress_level arg (=4)       Compression level in BAM. Support `u` 
                                        for uncompressed raw BAM output and 
                                        [0-9] for underlying zlib compression.
  --o-sam-queue_size arg (=1048576)     Size of the lock-free queue used in 
                                        SAM/BAM output.
  --o-sam-without_tag_MD                Set to disable the MD tag in SAM/BAM 
                                        output.
  --o-sam-without_tag_NM                Set to disable the NM tag in SAM/BAM 
                                        output.
  --o-sam-no_qual                       Set to disable writing quality scores 
                                        in SAM/BAM output.

Headless SAM/BAM Output:
  --o-hl_sam arg                        Destination of output headless SAM/BAM 
                                        file. Unset to disable the writer.
  --o-hl_sam-use_m                      Whether to use CIGAR 'M' instead of 
                                        '=/X' for alignment
  --o-hl_sam-write_bam                  Enforce BAM instead of SAM output.
  --o-hl_sam-num_threads arg (=4)       Number of threads used in BAM 
                                        compression.
  --o-hl_sam-compress_level arg (=4)    Compression level in BAM. Support `u` 
                                        for uncompressed raw BAM output and 
                                        [0-9] for underlying zlib compression.
  --o-hl_sam-queue_size arg (=1048576)  Size of the lock-free queue used in 
                                        headless SAM/BAM output.
  --o-hl_sam-without_tag_OA             Set to disable the OA tag in headless 
                                        SAM/BAM output.
  --o-hl_sam-without_tag_MD             Set to disable the MD tag in headless 
                                        SAM/BAM output.
  --o-hl_sam-without_tag_NM             Set to disable the NM tag in headless 
                                        SAM/BAM output.
  --o-hl_sam-no_qual                    Set to disable writing quality scores 
                                        in headless SAM/BAM output.

ART-specific options:
  --id arg (=AM)                        the prefix identification tag for read 
                                        ID
  --builtin_qual_file arg (=HiSeq2500_150bp)
                                        name of some built-in quality profile. 
                                        See below for valid values. Set this to
                                        avoid qual_file_1 and qual_file_2.
  --qual_file_1 arg                     path to the first-read quality profile
  --qual_file_2 arg                     path to the second-read quality 
                                        profile. For PE/MP only.
  --ins_rate_1 arg (=9.0000000000000006e-05)
                                        the first-read insertion rate
  --ins_rate_2 arg (=0.00014999999999999999)
                                        the second-read insertion rate
  --del_rate_1 arg (=0.00011)           the first-read deletion rate
  --del_rate_2 arg (=0.00023000000000000001)
                                        the second-read deletion rate
  --sep_flag                            use separate quality profiles for 
                                        different bases. Default is to use same
                                        quality profile regardless its position
  --max_indel arg (=-1)                 the maximum total number of insertion 
                                        and deletion per read
  --max_n arg (=0)                      the maximum total number of ambiguous 
                                        bases (N) per read
  --read_len arg                        read length to be simulated. If the 
                                        simulation mode is PE or MP, will use 
                                        this value on both reads. If none of 
                                        the read-length parameters are 
                                        specified, will use the longest 
                                        available read length specified in the 
                                        profile. Cannot be specified together 
                                        with read_len_1 or read_len_2
  --read_len_1 arg                      read length of read 1 to be simulated
  --read_len_2 arg                      read length of read 2 to be simulated
  --pe_frag_dist_mean arg               Mean distance between DNA/RNA fragments
                                        for paired-end simulations
  --pe_frag_dist_std_dev arg            Std. deviation of distance between 
                                        DNA/RNA fragments for paired-end 
                                        simulations
  --q_shift_1 arg (=0)                  the amount to shift every first-read 
                                        quality score by
  --q_shift_2 arg (=0)                  the amount to shift every second-read 
                                        quality score by
  --min_qual arg (=0)                   the minimum base quality score
  --max_qual arg (=71)                  the maximum base quality score

Parallelism-related options:
  --parallel arg (=0)                   Parallel level. -1 for disable, 0 for 
                                        all CPUs, >=1 to specify number of 
                                        threads.

Reporting options:
  --reporting_interval-job_executor arg (=5)
                                        The reporting interval (in seconds) for
                                        individual art_modern job.
  --reporting_interval-job_pool arg (=10)
                                        The reporting interval (in seconds) for
                                        JobPool.

Builtin profiles:
	GA1_36bp: PE, max read length: 36, 36
	GA1_44bp: PE, max read length: 44, 44
	GA2_50bp: PE, max read length: 53, 50
	GA2_75bp: PE, max read length: 75, 75
	GA1Recalibrated_36bp: PE, max read length: 36, 36
	GA1Recalibrated_44bp: PE, max read length: 44, 44
	GA2Recalibrated_50bp: PE, max read length: 50, 50
	GA2Recalibrated_75bp: PE, max read length: 75, 75
	GA2X_150bp: PE, max read length: 150, 150
	GA2X_100bp: PE, max read length: 100, 100
	HiSeq1000_100bp: PE, max read length: 100, 100
	HiSeq1500_250bp: PE, max read length: 250, 250
	HiSeq2000_100bp: PE, max read length: 100, 100
	HiSeq2500_125bp: PE, max read length: 126, 126
	HiSeq2500_150bp: PE, max read length: 150, 150
	HiSeq2500Filtered_150bp: PE, max read length: 150, 150
	HiSeq3000_150bp: PE, max read length: 150, 150
	HiSeq4000_150bp: PE, max read length: 150, 150
	HiSeqX_PCR_Free_150bp: PE, max read length: 151, 151
	HiSeqX_TruSeq_150bp: PE, max read length: 151, 151
	MiSeq_250bp: PE, max read length: 250, 250
	MiSeq_v3_250bp: PE, max read length: 251, 251
	MiSeq_v3_300bp: PE, max read length: 300, 300
	MiniSeq_TruSeq_50bp: SE, max read length: 51
	NextSeq500_150bp: PE, max read length: 150, 150
	NextSeq500_v2_75bp: PE, max read length: 76, 76
	NextSeq550_150bp: PE, max read length: 150, 150
	BGISeq500_150bp: PE, max read length: 150, 150
	DNBSeqG50_150bp: PE, max read length: 150, 150
	DNBSeqG99_300bp: PE, max read length: 300, 300
	DNBSeqG400_400bp: SE, max read length: 400
	DNBSeqG400_150bp: PE, max read length: 150, 150
	DNBSeqG400_200bp: PE, max read length: 200, 200
	DNBSeqT1Plus_150bp: PE, max read length: 150, 150
	DNBSeqT7_150bp: PE, max read length: 150, 150
	DNBSeqT10X4_100bp: PE, max read length: 100, 100
	PacbOnso_150bp: PE, max read length: 150, 150

[2026-10-06 16:16:01.328669] [T=0x000075f696fd1780] info: YuZJ Modified ART_Illumina (art_modern) v. 1.5.1 at <https://github.com/YU-Zhejian/art_modern/>
[2026-10-06 16:16:01.328774] [T=0x000075f696fd1780] info: Based on ART_Illumina: v. 2008-2016, Q Version 2.5.8 (June 6, 2016)
[2026-10-06 16:16:01.328784] [T=0x000075f696fd1780] info: Originally written by: Weichun Huang <whduke@gmail.com>
[2026-10-06 16:16:01.328796] [T=0x000075f696fd1780] info: Modified by: YU Zhejian <yuzj25@seas.upenn.edu>
[2026-10-06 16:16:01.328804] [T=0x000075f696fd1780] warning: ART_LOG_DIR not defined; Default to 'art_modern-log.d'.
[2026-10-06 16:16:01.329021] [T=0x000075f696fd1780] info: Log file sink to '/tmp/art_modern-log.d/nompi.log' added.
[2026-10-06 16:16:01.329118] [T=0x000075f696fd1780] info: MPI not found! Cross-node parallelism disabled.
[2026-10-06 16:16:01.329310] [T=0x000075f696fd1780] info: ARGS: art_modern --help
[2026-10-06 16:16:01.479666] [T=0x000075f696fd1780] info: EXIT
```

## art_modern_art_profile_builder

### Tool Description
Builds an ART read quality profile from FASTQ/SAM/BAM reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/art_modern:1.5.1--hc80e578_0
- **Homepage**: https://github.com/YU-Zhejian/art_modern
- **Package**: https://anaconda.org/channels/bioconda/packages/art_modern/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/art_modern/overview
- **Total Downloads**: 9.9K
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/YU-Zhejian/art_modern
- **Stars**: 13

### Original Help Text
```text
General Options:
  --help                                print out usage information
  --version                             display version info

Required Options:
  --i-file arg                          the filename of the input FASTQ/SAM/BAM
                                        file.
  --read_len arg                        maximum read length to be learnt. If 
                                        the file mode is PE or MP, will use 
                                        this value on both reads. Cannot be 
                                        specified together with read_len_1 or 
                                        read_len_2
  --read_len_1 arg                      read length of read 1 to be learnt
  --read_len_2 arg                      read length of read 2 to be learnt

Input Flags:
  --is_pe                               Whether the input is paired-end. 
                                        Default: single-end.
  --old_behavior                        Simulate the behaviour of original ART 
                                        profile builder. If set, all qualities 
                                        will be offsetted by 1.
  --o-file1 arg                         Output file name for read 1 profile.
  --o-file2 arg                         Output file name for read 2 profile.
  --i-format arg (=AUTO)                Input file format. AUTO to auto-detect.
                                        Valid values: AUTO, FASTQ, SAM, BAM, 
                                        CRAM.
  --first_n_reads arg (=9223372036854775807)
                                        Only process the first N reads in the 
                                        input file. Default: all reads.

Parallelism-related options:
  --parallel arg (=0)                   Parallel level. -1 for disable, 0 for 
                                        all CPUs, >=1 to specify number of 
                                        threads.
  --i-num_threads arg (=4)              number of threads to use for I/O. Note 
                                        that every thread specified in parallel
                                        will create i-num_threads threads for 
                                        I/O. 
  --queue_size arg (=1024)              # reads of the lock-free queue used in 
                                        reading input HTS files.
  --batch_size arg (=1024)              # reads of the batches in lock-free 
                                        queue used in reading input HTS files.
  --report_size arg (=1048576)          # reads to process before reporting in 
                                        each worker thread.

[2026-10-06 16:16:03.719443] [T=0x000074f329acb280] warning: ART_LOG_DIR not defined; Default to 'art_profile_builder-log.d'.
[2026-10-06 16:16:03.719825] [T=0x000074f329acb280] info: Log file sink to '/tmp/art_profile_builder-log.d/nompi.log' added.
[2026-10-06 16:16:03.719996] [T=0x000074f329acb280] info: ARGS: art_profile_builder --help
[2026-10-06 16:16:03.720146] [T=0x000074f329acb280] info: EXIT
```

## art_modern_am_compress

### Tool Description
Compresses a file with gzip or bgzip (art_modern helper).

### Metadata
- **Docker Image**: quay.io/biocontainers/art_modern:1.5.1--hc80e578_0
- **Homepage**: https://github.com/YU-Zhejian/art_modern
- **Package**: https://anaconda.org/channels/bioconda/packages/art_modern/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/art_modern/overview
- **Total Downloads**: 9.9K
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/YU-Zhejian/art_modern
- **Stars**: 13

### Original Help Text
```text
--o-compressed arg                    Destination of output compressed file. 
                                        Unset to disable the writer.
  --o-compressed-compression arg        Compression type for the output file. 
                                        Supported values are 'gzip', 'bgzip', 
                                        and 'none'. If not set, it will be 
                                        inferred from the file extension.
  --o-compressed-compression_level arg (=6)
                                        Compression level for gzip compression.
                                        Valid values are typically between 1 
                                        (fastest) and 9 (best compression). 
                                        Default is 6. Not used when no 
                                        compression.
  --o-compressed-buffer_size arg (=1048576)
                                        Buffer size in bytes for writing. 
                                        Default is 1 MiB (1048576 bytes).
  --o-compressed-num_threads arg (=1)   Number of threads to use for 
                                        compression. Only applicable for bgzip 
                                        compression. Default is 1 (no 
                                        multithreading).
  --i-file arg                          Path to the input file.
  --i-buffer_size arg (=4096)           Size (in bytes) of the buffer used to 
                                        read the input file.

General Options:
  --help                                print out usage information
  --version                             display version info

[2026-10-06 16:16:05.725625] [T=0x000074bb98493680] warning: ART_LOG_DIR not defined; Default to 'am_compress-log.d'.
[2026-10-06 16:16:05.725975] [T=0x000074bb98493680] info: Log file sink to '/tmp/am_compress-log.d/nompi.log' added.
[2026-10-06 16:16:05.726097] [T=0x000074bb98493680] info: Boost::timer started.
[2026-10-06 16:16:05.726261] [T=0x000074bb98493680] info: EXIT
```

