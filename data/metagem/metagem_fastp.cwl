cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastp
label: metagem_fastp
doc: "an ultra-fast all-in-one FASTQ preprocessor\n\nTool homepage: https://github.com/franciscozorrilla/metaGEM"
inputs:
  - id: adapter_fasta
    type:
      - 'null'
      - File
    doc: specify a FASTA file to trim both read1 and read2 (if PE) by all the 
      sequences in this FASTA file
    inputBinding:
      position: 101
      prefix: --adapter_fasta
  - id: adapter_sequence
    type:
      - 'null'
      - string
    doc: the adapter for read1. For SE data, if not specified, the adapter will 
      be auto-detected. For PE data, this is used if R1/R2 are found not 
      overlapped.
    default: auto
    inputBinding:
      position: 101
      prefix: --adapter_sequence
  - id: adapter_sequence_r2
    type:
      - 'null'
      - string
    doc: the adapter for read2 (PE data only). This is used if R1/R2 are found 
      not overlapped. If not specified, it will be the same as 
      <adapter_sequence>
    default: auto
    inputBinding:
      position: 101
      prefix: --adapter_sequence_r2
  - id: average_qual
    type:
      - 'null'
      - int
    doc: if one read's average quality score <avg_qual, then this read/pair is 
      discarded. Default 0 means no requirement
    default: 0
    inputBinding:
      position: 101
      prefix: --average_qual
  - id: complexity_threshold
    type:
      - 'null'
      - int
    doc: the threshold for low complexity filter (0~100). Default is 30, which 
      means 30% complexity is required.
    default: 30
    inputBinding:
      position: 101
      prefix: --complexity_threshold
  - id: compression
    type:
      - 'null'
      - int
    doc: compression level for gzip output (1 ~ 9). 1 is fastest, 9 is smallest,
      default is 4.
    default: 4
    inputBinding:
      position: 101
      prefix: --compression
  - id: correction
    type:
      - 'null'
      - boolean
    doc: enable base correction in overlapped regions (only for PE data), 
      default is disabled
    inputBinding:
      position: 101
      prefix: --correction
  - id: cut_front
    type:
      - 'null'
      - boolean
    doc: move a sliding window from front (5') to tail, drop the bases in the 
      window if its mean quality < threshold, stop otherwise.
    inputBinding:
      position: 101
      prefix: --cut_front
  - id: cut_front_mean_quality
    type:
      - 'null'
      - int
    doc: the mean quality requirement option for cut_front, default to 
      cut_mean_quality if not specified
    default: 20
    inputBinding:
      position: 101
      prefix: --cut_front_mean_quality
  - id: cut_front_window_size
    type:
      - 'null'
      - int
    doc: the window size option of cut_front, default to cut_window_size if not 
      specified
    default: 4
    inputBinding:
      position: 101
      prefix: --cut_front_window_size
  - id: cut_mean_quality
    type:
      - 'null'
      - int
    doc: 'the mean quality requirement option shared by cut_front, cut_tail or cut_sliding.
      Range: 1~36 default: 20 (Q20)'
    default: 20
    inputBinding:
      position: 101
      prefix: --cut_mean_quality
  - id: cut_right
    type:
      - 'null'
      - boolean
    doc: move a sliding window from front to tail, if meet one window with mean 
      quality < threshold, drop the bases in the window and the right part, and 
      then stop.
    inputBinding:
      position: 101
      prefix: --cut_right
  - id: cut_right_mean_quality
    type:
      - 'null'
      - int
    doc: the mean quality requirement option for cut_right, default to 
      cut_mean_quality if not specified
    default: 20
    inputBinding:
      position: 101
      prefix: --cut_right_mean_quality
  - id: cut_right_window_size
    type:
      - 'null'
      - int
    doc: the window size option of cut_right, default to cut_window_size if not 
      specified
    default: 4
    inputBinding:
      position: 101
      prefix: --cut_right_window_size
  - id: cut_tail
    type:
      - 'null'
      - boolean
    doc: move a sliding window from tail (3') to front, drop the bases in the 
      window if its mean quality < threshold, stop otherwise.
    inputBinding:
      position: 101
      prefix: --cut_tail
  - id: cut_tail_mean_quality
    type:
      - 'null'
      - int
    doc: the mean quality requirement option for cut_tail, default to 
      cut_mean_quality if not specified
    default: 20
    inputBinding:
      position: 101
      prefix: --cut_tail_mean_quality
  - id: cut_tail_window_size
    type:
      - 'null'
      - int
    doc: the window size option of cut_tail, default to cut_window_size if not 
      specified
    default: 4
    inputBinding:
      position: 101
      prefix: --cut_tail_window_size
  - id: cut_window_size
    type:
      - 'null'
      - int
    doc: 'the window size option shared by cut_front, cut_tail or cut_sliding. Range:
      1~1000, default: 4'
    default: 4
    inputBinding:
      position: 101
      prefix: --cut_window_size
  - id: dedup
    type:
      - 'null'
      - boolean
    doc: enable deduplication to drop the duplicated reads/pairs
    inputBinding:
      position: 101
      prefix: --dedup
  - id: detect_adapter_for_pe
    type:
      - 'null'
      - boolean
    doc: by default, the auto-detection for adapter is for SE data input only, 
      turn on this option to enable it for PE data.
    inputBinding:
      position: 101
      prefix: --detect_adapter_for_pe
  - id: disable_adapter_trimming
    type:
      - 'null'
      - boolean
    doc: adapter trimming is enabled by default. If this option is specified, 
      adapter trimming is disabled
    inputBinding:
      position: 101
      prefix: --disable_adapter_trimming
  - id: disable_length_filtering
    type:
      - 'null'
      - boolean
    doc: length filtering is enabled by default. If this option is specified, 
      length filtering is disabled
    inputBinding:
      position: 101
      prefix: --disable_length_filtering
  - id: disable_quality_filtering
    type:
      - 'null'
      - boolean
    doc: quality filtering is enabled by default. If this option is specified, 
      quality filtering is disabled
    inputBinding:
      position: 101
      prefix: --disable_quality_filtering
  - id: disable_trim_poly_g
    type:
      - 'null'
      - boolean
    doc: disable polyG tail trimming, by default trimming is automatically 
      enabled for Illumina NextSeq/NovaSeq data
    inputBinding:
      position: 101
      prefix: --disable_trim_poly_g
  - id: dont_eval_duplication
    type:
      - 'null'
      - boolean
    doc: don't evaluate duplication rate to save time and use less memory.
    inputBinding:
      position: 101
      prefix: --dont_eval_duplication
  - id: dont_overwrite
    type:
      - 'null'
      - boolean
    doc: don't overwrite existing files. Overwritting is allowed by default.
    inputBinding:
      position: 101
      prefix: --dont_overwrite
  - id: dup_calc_accuracy
    type:
      - 'null'
      - int
    doc: accuracy level to calculate duplication (1~6), higher level uses more 
      memory (1G, 2G, 4G, 8G, 16G, 24G). Default 1 for no-dedup mode, and 3 for 
      dedup mode.
    default: 0
    inputBinding:
      position: 101
      prefix: --dup_calc_accuracy
  - id: failed_out
    type:
      - 'null'
      - File
    doc: specify the file to store reads that cannot pass the filters.
    inputBinding:
      position: 101
  - id: filter_by_index1
    type:
      - 'null'
      - File
    doc: specify a file contains a list of barcodes of index1 to be filtered 
      out, one barcode per line
    inputBinding:
      position: 101
      prefix: --filter_by_index1
  - id: filter_by_index2
    type:
      - 'null'
      - File
    doc: specify a file contains a list of barcodes of index2 to be filtered 
      out, one barcode per line
    inputBinding:
      position: 101
      prefix: --filter_by_index2
  - id: filter_by_index_threshold
    type:
      - 'null'
      - int
    doc: the allowed difference of index barcode for index filtering, default 0 
      means completely identical.
    default: 0
    inputBinding:
      position: 101
      prefix: --filter_by_index_threshold
  - id: fix_mgi_id
    type:
      - 'null'
      - boolean
    doc: the MGI FASTQ ID format is not compatible with many BAM operation 
      tools, enable this option to fix it.
    inputBinding:
      position: 101
      prefix: --fix_mgi_id
  - id: in1
    type:
      - 'null'
      - File
    doc: read1 input file name
    inputBinding:
      position: 101
      prefix: --in1
  - id: in2
    type:
      - 'null'
      - File
    doc: read2 input file name
    inputBinding:
      position: 101
      prefix: --in2
  - id: include_unmerged
    type:
      - 'null'
      - boolean
    doc: in the merging mode, write the unmerged or unpaired reads to the file 
      specified by --merge. Disabled by default.
    inputBinding:
      position: 101
  - id: interleaved_in
    type:
      - 'null'
      - boolean
    doc: indicate that <in1> is an interleaved FASTQ which contains both read1 
      and read2. Disabled by default.
    inputBinding:
      position: 101
      prefix: --interleaved_in
  - id: length_limit
    type:
      - 'null'
      - int
    doc: reads longer than length_limit will be discarded, default 0 means no 
      limitation.
    default: 0
    inputBinding:
      position: 101
      prefix: --length_limit
  - id: length_required
    type:
      - 'null'
      - int
    doc: reads shorter than length_required will be discarded, default is 15.
    default: 15
    inputBinding:
      position: 101
      prefix: --length_required
  - id: low_complexity_filter
    type:
      - 'null'
      - boolean
    doc: enable low complexity filter. The complexity is defined as the 
      percentage of base that is different from its next base (base[i] != 
      base[i+1]).
    inputBinding:
      position: 101
      prefix: --low_complexity_filter
  - id: max_len1
    type:
      - 'null'
      - int
    doc: if read1 is longer than max_len1, then trim read1 at its tail to make 
      it as long as max_len1. Default 0 means no limitation
    default: 0
    inputBinding:
      position: 101
      prefix: --max_len1
  - id: max_len2
    type:
      - 'null'
      - int
    doc: if read2 is longer than max_len2, then trim read2 at its tail to make 
      it as long as max_len2. Default 0 means no limitation. If it's not 
      specified, it will follow read1's settings
    default: 0
    inputBinding:
      position: 101
      prefix: --max_len2
  - id: merge
    type:
      - 'null'
      - boolean
    doc: for paired-end input, merge each pair of reads into a single read if 
      they are overlapped. The merged reads will be written to the file given by
      --merged_out, the unmerged reads will be written to the files specified by
      --out1 and --out2. The merging mode is disabled by default.
    inputBinding:
      position: 101
      prefix: --merge
  - id: merged_out
    type:
      - 'null'
      - File
    doc: in the merging mode, specify the file name to store merged output, or 
      specify --stdout to stream the merged output
    inputBinding:
      position: 101
  - id: n_base_limit
    type:
      - 'null'
      - int
    doc: if one read's number of N base is >n_base_limit, then this read/pair is
      discarded. Default is 5
    default: 5
    inputBinding:
      position: 101
      prefix: --n_base_limit
  - id: overlap_diff_limit
    type:
      - 'null'
      - int
    doc: the maximum number of mismatched bases to detect overlapped region of 
      PE reads. This will affect overlap analysis based PE merge, adapter 
      trimming and correction. 5 by default.
    default: 5
    inputBinding:
      position: 101
      prefix: --overlap_diff_limit
  - id: overlap_diff_percent_limit
    type:
      - 'null'
      - int
    doc: the maximum percentage of mismatched bases to detect overlapped region 
      of PE reads. This will affect overlap analysis based PE merge, adapter 
      trimming and correction. Default 20 means 20%.
    default: 20
    inputBinding:
      position: 101
      prefix: --overlap_diff_percent_limit
  - id: overlap_len_require
    type:
      - 'null'
      - int
    doc: the minimum length to detect overlapped region of PE reads. This will 
      affect overlap analysis based PE merge, adapter trimming and correction. 
      30 by default.
    default: 30
    inputBinding:
      position: 101
      prefix: --overlap_len_require
  - id: overlapped_out
    type:
      - 'null'
      - File
    doc: for each read pair, output the overlapped region if it has no any 
      mismatched base.
    inputBinding:
      position: 101
  - id: overrepresentation_analysis
    type:
      - 'null'
      - boolean
    doc: enable overrepresented sequence analysis.
    inputBinding:
      position: 101
      prefix: --overrepresentation_analysis
  - id: overrepresentation_sampling
    type:
      - 'null'
      - int
    doc: one in (--overrepresentation_sampling) reads will be computed for 
      overrepresentation analysis (1~10000), smaller is slower, default is 20.
    default: 20
    inputBinding:
      position: 101
      prefix: --overrepresentation_sampling
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: indicate the input is using phred64 scoring (it'll be converted to 
      phred33, so the output will still be phred33)
    inputBinding:
      position: 101
      prefix: --phred64
  - id: poly_g_min_len
    type:
      - 'null'
      - int
    doc: the minimum length to detect polyG in the read tail. 10 by default.
    default: 10
    inputBinding:
      position: 101
      prefix: --poly_g_min_len
  - id: poly_x_min_len
    type:
      - 'null'
      - int
    doc: the minimum length to detect polyX in the read tail. 10 by default.
    default: 10
    inputBinding:
      position: 101
      prefix: --poly_x_min_len
  - id: qualified_quality_phred
    type:
      - 'null'
      - int
    doc: the quality value that a base is qualified. Default 15 means phred 
      quality >=Q15 is qualified.
    default: 15
    inputBinding:
      position: 101
      prefix: --qualified_quality_phred
  - id: reads_to_process
    type:
      - 'null'
      - int
    doc: specify how many reads/pairs to be processed. Default 0 means process 
      all reads.
    default: 0
    inputBinding:
      position: 101
      prefix: --reads_to_process
  - id: report_title
    type:
      - 'null'
      - string
    doc: should be quoted with ' or ", default is "fastp report"
    default: fastp report
    inputBinding:
      position: 101
      prefix: --report_title
  - id: split
    type:
      - 'null'
      - int
    doc: split output by limiting total split file number with this option 
      (2~999), a sequential number prefix will be added to output name ( 
      0001.out.fq, 0002.out.fq...), disabled by default
    default: 0
    inputBinding:
      position: 101
      prefix: --split
  - id: split_by_lines
    type:
      - 'null'
      - long
    doc: split output by limiting lines of each file with this option(>=1000), a
      sequential number prefix will be added to output name ( 0001.out.fq, 
      0002.out.fq...), disabled by default
    default: 0
    inputBinding:
      position: 101
      prefix: --split_by_lines
  - id: split_prefix_digits
    type:
      - 'null'
      - int
    doc: the digits for the sequential number padding (1~10), default is 4, so 
      the filename will be padded as 0001.xxx, 0 to disable padding
    default: 4
    inputBinding:
      position: 101
      prefix: --split_prefix_digits
  - id: stdin
    type:
      - 'null'
      - boolean
    doc: input from STDIN. If the STDIN is interleaved paired-end FASTQ, please 
      also add --interleaved_in.
    inputBinding:
      position: 101
      prefix: --stdin
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: stream passing-filters reads to STDOUT. This option will result in 
      interleaved FASTQ output for paired-end output. Disabled by default.
    inputBinding:
      position: 101
      prefix: --stdout
  - id: thread
    type:
      - 'null'
      - int
    doc: worker thread number, default is 3
    default: 3
    inputBinding:
      position: 101
      prefix: --thread
  - id: trim_front1
    type:
      - 'null'
      - int
    doc: trimming how many bases in front for read1, default is 0
    default: 0
    inputBinding:
      position: 101
      prefix: --trim_front1
  - id: trim_front2
    type:
      - 'null'
      - int
    doc: trimming how many bases in front for read2. If it's not specified, it 
      will follow read1's settings
    default: 0
    inputBinding:
      position: 101
      prefix: --trim_front2
  - id: trim_poly_g
    type:
      - 'null'
      - boolean
    doc: force polyG tail trimming, by default trimming is automatically enabled
      for Illumina NextSeq/NovaSeq data
    inputBinding:
      position: 101
      prefix: --trim_poly_g
  - id: trim_poly_x
    type:
      - 'null'
      - boolean
    doc: enable polyX trimming in 3' ends.
    inputBinding:
      position: 101
      prefix: --trim_poly_x
  - id: trim_tail1
    type:
      - 'null'
      - int
    doc: trimming how many bases in tail for read1, default is 0
    default: 0
    inputBinding:
      position: 101
      prefix: --trim_tail1
  - id: trim_tail2
    type:
      - 'null'
      - int
    doc: trimming how many bases in tail for read2. If it's not specified, it 
      will follow read1's settings
    default: 0
    inputBinding:
      position: 101
      prefix: --trim_tail2
  - id: umi
    type:
      - 'null'
      - boolean
    doc: enable unique molecular identifier (UMI) preprocessing
    inputBinding:
      position: 101
      prefix: --umi
  - id: umi_len
    type:
      - 'null'
      - int
    doc: if the UMI is in read1/read2, its length should be provided
    default: 0
    inputBinding:
      position: 101
      prefix: --umi_len
  - id: umi_loc
    type:
      - 'null'
      - string
    doc: specify the location of UMI, can be 
      (index1/index2/read1/read2/per_index/per_read, default is none
    inputBinding:
      position: 101
      prefix: --umi_loc
  - id: umi_prefix
    type:
      - 'null'
      - string
    doc: if specified, an underline will be used to connect prefix and UMI (i.e.
      prefix=UMI, UMI=AATTCG, final=UMI_AATTCG). No prefix by default
    inputBinding:
      position: 101
      prefix: --umi_prefix
  - id: umi_skip
    type:
      - 'null'
      - int
    doc: if the UMI is in read1/read2, fastp can skip several bases following 
      UMI, default is 0
    default: 0
    inputBinding:
      position: 101
      prefix: --umi_skip
  - id: unpaired1
    type:
      - 'null'
      - File
    doc: for PE input, if read1 passed QC but read2 not, it will be written to 
      unpaired1. Default is to discard it.
    inputBinding:
      position: 101
  - id: unpaired2
    type:
      - 'null'
      - File
    doc: for PE input, if read2 passed QC but read1 not, it will be written to 
      unpaired2. If --unpaired2 is same as --unpaired1 (default mode), both 
      unpaired reads will be written to this same file.
    inputBinding:
      position: 101
  - id: unqualified_percent_limit
    type:
      - 'null'
      - int
    doc: how many percents of bases are allowed to be unqualified (0~100). 
      Default 40 means 40%
    default: 40
    inputBinding:
      position: 101
      prefix: --unqualified_percent_limit
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: output verbose log information (i.e. when every 1M reads are 
      processed).
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out1
    type:
      - 'null'
      - File
    doc: read1 output file name
    outputBinding:
      glob: $(inputs.out1)
  - id: out2
    type:
      - 'null'
      - File
    doc: read2 output file name
    outputBinding:
      glob: $(inputs.out2)
  - id: json
    type:
      - 'null'
      - File
    doc: the json format report file name
    outputBinding:
      glob: $(inputs.json)
  - id: html
    type:
      - 'null'
      - File
    doc: the html format report file name
    outputBinding:
      glob: $(inputs.html)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagem:1.0.5--hdfd78af_0
