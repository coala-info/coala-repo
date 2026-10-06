cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - art_modern
label: art_modern
doc: "YuZJ Modified ART_Illumina (art_modern): simulate Illumina reads from a reference\
  \ genome, transcriptome or templates.\n\nTool homepage: https://github.com/YU-Zhejian/art_modern"
inputs:
  - id: mode
    type:
      - 'null'
      - string
    doc: 'simulation mode, should be wgs, trans, template. (default: wgs)'
    inputBinding:
      position: 1
      prefix: --mode
  - id: lc
    type:
      - 'null'
      - string
    doc: 'library construction mode, should be se, pe, mp. (default: se)'
    inputBinding:
      position: 1
      prefix: --lc
  - id: i_seed
    type:
      - 'null'
      - long
    doc: Random seed for simulation. If not specified, will be generated at random.
    inputBinding:
      position: 1
      prefix: --i-seed
  - id: i_parser
    type:
      - 'null'
      - string
    doc: 'input file parser, should be auto, memory, htslib, stream. (default: auto)'
    inputBinding:
      position: 1
      prefix: --i-parser
  - id: i_type
    type:
      - 'null'
      - string
    doc: 'input file type, should be auto, fasta, pbsim3_transcripts. (default: auto)'
    inputBinding:
      position: 1
      prefix: --i-type
  - id: i_batch_size
    type:
      - 'null'
      - long
    doc: 'Batch size for stream input parser (default: 16384)'
    inputBinding:
      position: 1
      prefix: --i-batch_size
  - id: i_file
    type: File
    doc: the filename of input reference genome, reference transcriptome, or templates
    inputBinding:
      position: 1
      prefix: --i-file
  - id: i_fcov
    type:
      - 'null'
      - string
    doc: 'the fold of read coverage to be simulated or number of reads/read pairs
      generated for each sequence for simulating cDNA reads, or a double for simulating
      WGS reads. (default: 0.0)'
    inputBinding:
      position: 1
      prefix: --i-fcov
  - id: o_pwa
    type:
      - 'null'
      - string
    doc: Destination of output pwa file. Unset to disable the writer.
    inputBinding:
      position: 1
      prefix: --o-pwa
  - id: o_pwa_compression
    type:
      - 'null'
      - string
    doc: Compression type for the output file. Supported values are 'gzip', 'bgzip',
      and 'none'. If not set, it will be inferred from the file extension.
    inputBinding:
      position: 1
      prefix: --o-pwa-compression
  - id: o_pwa_compression_level
    type:
      - 'null'
      - int
    doc: 'Compression level for gzip compression. Valid values are typically between
      1 (fastest) and 9 (best compression). Default is 6. Not used when no compression.
      (default: 6)'
    inputBinding:
      position: 1
      prefix: --o-pwa-compression_level
  - id: o_pwa_buffer_size
    type:
      - 'null'
      - long
    doc: 'Buffer size in bytes for writing. Default is 1 MiB (1048576 bytes). (default:
      1048576)'
    inputBinding:
      position: 1
      prefix: --o-pwa-buffer_size
  - id: o_pwa_num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use for compression. Only applicable for bgzip compression.
      Default is 1 (no multithreading). (default: 1)'
    inputBinding:
      position: 1
      prefix: --o-pwa-num_threads
  - id: o_pwa_queue_size
    type:
      - 'null'
      - long
    doc: 'Size of the lock-free queue used in PWA output. (default: 1048576)'
    inputBinding:
      position: 1
      prefix: --o-pwa-queue_size
  - id: o_fasta
    type:
      - 'null'
      - string
    doc: Destination of output fasta file. Unset to disable the writer.
    inputBinding:
      position: 1
      prefix: --o-fasta
  - id: o_fasta_compression
    type:
      - 'null'
      - string
    doc: Compression type for the output file. Supported values are 'gzip', 'bgzip',
      and 'none'. If not set, it will be inferred from the file extension.
    inputBinding:
      position: 1
      prefix: --o-fasta-compression
  - id: o_fasta_compression_level
    type:
      - 'null'
      - int
    doc: 'Compression level for gzip compression. Valid values are typically between
      1 (fastest) and 9 (best compression). Default is 6. Not used when no compression.
      (default: 6)'
    inputBinding:
      position: 1
      prefix: --o-fasta-compression_level
  - id: o_fasta_buffer_size
    type:
      - 'null'
      - long
    doc: 'Buffer size in bytes for writing. Default is 1 MiB (1048576 bytes). (default:
      1048576)'
    inputBinding:
      position: 1
      prefix: --o-fasta-buffer_size
  - id: o_fasta_num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use for compression. Only applicable for bgzip compression.
      Default is 1 (no multithreading). (default: 1)'
    inputBinding:
      position: 1
      prefix: --o-fasta-num_threads
  - id: o_fasta_queue_size
    type:
      - 'null'
      - long
    doc: 'Size of the lock-free queue used in FASTA output. (default: 1048576)'
    inputBinding:
      position: 1
      prefix: --o-fasta-queue_size
  - id: o_fastq
    type:
      - 'null'
      - string
    doc: Destination of output fastq file. Unset to disable the writer.
    inputBinding:
      position: 1
      prefix: --o-fastq
  - id: o_fastq_compression
    type:
      - 'null'
      - string
    doc: Compression type for the output file. Supported values are 'gzip', 'bgzip',
      and 'none'. If not set, it will be inferred from the file extension.
    inputBinding:
      position: 1
      prefix: --o-fastq-compression
  - id: o_fastq_compression_level
    type:
      - 'null'
      - int
    doc: 'Compression level for gzip compression. Valid values are typically between
      1 (fastest) and 9 (best compression). Default is 6. Not used when no compression.
      (default: 6)'
    inputBinding:
      position: 1
      prefix: --o-fastq-compression_level
  - id: o_fastq_buffer_size
    type:
      - 'null'
      - long
    doc: 'Buffer size in bytes for writing. Default is 1 MiB (1048576 bytes). (default:
      1048576)'
    inputBinding:
      position: 1
      prefix: --o-fastq-buffer_size
  - id: o_fastq_num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use for compression. Only applicable for bgzip compression.
      Default is 1 (no multithreading). (default: 1)'
    inputBinding:
      position: 1
      prefix: --o-fastq-num_threads
  - id: o_fastq_queue_size
    type:
      - 'null'
      - long
    doc: 'Size of the lock-free queue used in FASTQ output. (default: 1048576)'
    inputBinding:
      position: 1
      prefix: --o-fastq-queue_size
  - id: o_sam
    type:
      - 'null'
      - string
    doc: Destination of output SAM/BAM file. Unset to disable the writer.
    inputBinding:
      position: 1
      prefix: --o-sam
  - id: o_sam_use_m
    type:
      - 'null'
      - boolean
    doc: Whether to use CIGAR 'M' instead of '=/X' for alignment
    inputBinding:
      position: 1
      prefix: --o-sam-use_m
  - id: o_sam_write_bam
    type:
      - 'null'
      - boolean
    doc: Enforce BAM instead of SAM output.
    inputBinding:
      position: 1
      prefix: --o-sam-write_bam
  - id: o_sam_num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads used in BAM compression. (default: 4)'
    inputBinding:
      position: 1
      prefix: --o-sam-num_threads
  - id: o_sam_compress_level
    type:
      - 'null'
      - string
    doc: 'Compression level in BAM. Support `u` for uncompressed raw BAM output and
      [0-9] for underlying zlib compression. (default: 4)'
    inputBinding:
      position: 1
      prefix: --o-sam-compress_level
  - id: o_sam_queue_size
    type:
      - 'null'
      - long
    doc: 'Size of the lock-free queue used in SAM/BAM output. (default: 1048576)'
    inputBinding:
      position: 1
      prefix: --o-sam-queue_size
  - id: o_sam_without_tag_md
    type:
      - 'null'
      - boolean
    doc: Set to disable the MD tag in SAM/BAM output.
    inputBinding:
      position: 1
      prefix: --o-sam-without_tag_MD
  - id: o_sam_without_tag_nm
    type:
      - 'null'
      - boolean
    doc: Set to disable the NM tag in SAM/BAM output.
    inputBinding:
      position: 1
      prefix: --o-sam-without_tag_NM
  - id: o_sam_no_qual
    type:
      - 'null'
      - boolean
    doc: Set to disable writing quality scores in SAM/BAM output.
    inputBinding:
      position: 1
      prefix: --o-sam-no_qual
  - id: o_hl_sam
    type:
      - 'null'
      - string
    doc: Destination of output headless SAM/BAM file. Unset to disable the writer.
    inputBinding:
      position: 1
      prefix: --o-hl_sam
  - id: o_hl_sam_use_m
    type:
      - 'null'
      - boolean
    doc: Whether to use CIGAR 'M' instead of '=/X' for alignment
    inputBinding:
      position: 1
      prefix: --o-hl_sam-use_m
  - id: o_hl_sam_write_bam
    type:
      - 'null'
      - boolean
    doc: Enforce BAM instead of SAM output.
    inputBinding:
      position: 1
      prefix: --o-hl_sam-write_bam
  - id: o_hl_sam_num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads used in BAM compression. (default: 4)'
    inputBinding:
      position: 1
      prefix: --o-hl_sam-num_threads
  - id: o_hl_sam_compress_level
    type:
      - 'null'
      - string
    doc: 'Compression level in BAM. Support `u` for uncompressed raw BAM output and
      [0-9] for underlying zlib compression. (default: 4)'
    inputBinding:
      position: 1
      prefix: --o-hl_sam-compress_level
  - id: o_hl_sam_queue_size
    type:
      - 'null'
      - long
    doc: 'Size of the lock-free queue used in headless SAM/BAM output. (default: 1048576)'
    inputBinding:
      position: 1
      prefix: --o-hl_sam-queue_size
  - id: o_hl_sam_without_tag_oa
    type:
      - 'null'
      - boolean
    doc: Set to disable the OA tag in headless SAM/BAM output.
    inputBinding:
      position: 1
      prefix: --o-hl_sam-without_tag_OA
  - id: o_hl_sam_without_tag_md
    type:
      - 'null'
      - boolean
    doc: Set to disable the MD tag in headless SAM/BAM output.
    inputBinding:
      position: 1
      prefix: --o-hl_sam-without_tag_MD
  - id: o_hl_sam_without_tag_nm
    type:
      - 'null'
      - boolean
    doc: Set to disable the NM tag in headless SAM/BAM output.
    inputBinding:
      position: 1
      prefix: --o-hl_sam-without_tag_NM
  - id: o_hl_sam_no_qual
    type:
      - 'null'
      - boolean
    doc: Set to disable writing quality scores in headless SAM/BAM output.
    inputBinding:
      position: 1
      prefix: --o-hl_sam-no_qual
  - id: id
    type:
      - 'null'
      - string
    doc: 'the prefix identification tag for read ID (default: AM)'
    inputBinding:
      position: 1
      prefix: --id
  - id: builtin_qual_file
    type:
      - 'null'
      - string
    doc: 'name of some built-in quality profile. See below for valid values. Set this
      to avoid qual_file_1 and qual_file_2. (default: HiSeq2500_150bp)'
    inputBinding:
      position: 1
      prefix: --builtin_qual_file
  - id: qual_file_1
    type:
      - 'null'
      - File
    doc: path to the first-read quality profile
    inputBinding:
      position: 1
      prefix: --qual_file_1
  - id: qual_file_2
    type:
      - 'null'
      - File
    doc: path to the second-read quality profile. For PE/MP only.
    inputBinding:
      position: 1
      prefix: --qual_file_2
  - id: ins_rate_1
    type:
      - 'null'
      - float
    doc: 'the first-read insertion rate (default: 9.0000000000000006e-05)'
    inputBinding:
      position: 1
      prefix: --ins_rate_1
  - id: ins_rate_2
    type:
      - 'null'
      - float
    doc: 'the second-read insertion rate (default: 0.00014999999999999999)'
    inputBinding:
      position: 1
      prefix: --ins_rate_2
  - id: del_rate_1
    type:
      - 'null'
      - float
    doc: 'the first-read deletion rate (default: 0.00011)'
    inputBinding:
      position: 1
      prefix: --del_rate_1
  - id: del_rate_2
    type:
      - 'null'
      - float
    doc: 'the second-read deletion rate (default: 0.00023000000000000001)'
    inputBinding:
      position: 1
      prefix: --del_rate_2
  - id: sep_flag
    type:
      - 'null'
      - boolean
    doc: use separate quality profiles for different bases. Default is to use same
      quality profile regardless its position
    inputBinding:
      position: 1
      prefix: --sep_flag
  - id: max_indel
    type:
      - 'null'
      - int
    doc: 'the maximum total number of insertion and deletion per read (default: -1)'
    inputBinding:
      position: 1
      prefix: --max_indel
  - id: max_n
    type:
      - 'null'
      - int
    doc: 'the maximum total number of ambiguous bases (N) per read (default: 0)'
    inputBinding:
      position: 1
      prefix: --max_n
  - id: read_len
    type:
      - 'null'
      - int
    doc: read length to be simulated. If the simulation mode is PE or MP, will use
      this value on both reads. If none of the read-length parameters are specified,
      will use the longest available read length specified in the profile. Cannot
      be specified together with read_len_1 or read_len_2
    inputBinding:
      position: 1
      prefix: --read_len
  - id: read_len_1
    type:
      - 'null'
      - int
    doc: read length of read 1 to be simulated
    inputBinding:
      position: 1
      prefix: --read_len_1
  - id: read_len_2
    type:
      - 'null'
      - int
    doc: read length of read 2 to be simulated
    inputBinding:
      position: 1
      prefix: --read_len_2
  - id: pe_frag_dist_mean
    type:
      - 'null'
      - float
    doc: Mean distance between DNA/RNA fragments for paired-end simulations
    inputBinding:
      position: 1
      prefix: --pe_frag_dist_mean
  - id: pe_frag_dist_std_dev
    type:
      - 'null'
      - float
    doc: Std. deviation of distance between DNA/RNA fragments for paired-end simulations
    inputBinding:
      position: 1
      prefix: --pe_frag_dist_std_dev
  - id: q_shift_1
    type:
      - 'null'
      - int
    doc: 'the amount to shift every first-read quality score by (default: 0)'
    inputBinding:
      position: 1
      prefix: --q_shift_1
  - id: q_shift_2
    type:
      - 'null'
      - int
    doc: 'the amount to shift every second-read quality score by (default: 0)'
    inputBinding:
      position: 1
      prefix: --q_shift_2
  - id: min_qual
    type:
      - 'null'
      - int
    doc: 'the minimum base quality score (default: 0)'
    inputBinding:
      position: 1
      prefix: --min_qual
  - id: max_qual
    type:
      - 'null'
      - int
    doc: 'the maximum base quality score (default: 71)'
    inputBinding:
      position: 1
      prefix: --max_qual
  - id: parallel
    type:
      - 'null'
      - int
    doc: 'Parallel level. -1 for disable, 0 for all CPUs, >=1 to specify number of
      threads. (default: 0)'
    inputBinding:
      position: 1
      prefix: --parallel
  - id: reporting_interval_job_executor
    type:
      - 'null'
      - int
    doc: 'The reporting interval (in seconds) for individual art_modern job. (default:
      5)'
    inputBinding:
      position: 1
      prefix: --reporting_interval-job_executor
  - id: reporting_interval_job_pool
    type:
      - 'null'
      - int
    doc: 'The reporting interval (in seconds) for JobPool. (default: 10)'
    inputBinding:
      position: 1
      prefix: --reporting_interval-job_pool
outputs:
  - id: pwa
    type:
      - 'null'
      - File
    doc: Output PWA (pairwise alignment) file.
    outputBinding:
      glob: $(inputs.o_pwa)
  - id: fasta
    type:
      - 'null'
      - File
    doc: Output FASTA file.
    outputBinding:
      glob: $(inputs.o_fasta)
  - id: fastq
    type:
      - 'null'
      - File
    doc: Output FASTQ file.
    outputBinding:
      glob: $(inputs.o_fastq)
  - id: sam
    type:
      - 'null'
      - File
    doc: Output SAM/BAM file.
    outputBinding:
      glob: $(inputs.o_sam)
  - id: hl_sam
    type:
      - 'null'
      - File
    doc: Output headless SAM/BAM file.
    outputBinding:
      glob: $(inputs.o_hl_sam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/art_modern:1.5.1--hc80e578_0
