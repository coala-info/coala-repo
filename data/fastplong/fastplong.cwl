cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastplong
label: fastplong
doc: "ultra-fast FASTQ preprocessing and quality control for long reads\n\nTool homepage:
  https://github.com/OpenGene/fastplong"
inputs:
  - id: adapter_fasta
    type:
      - 'null'
      - File
    doc: specify a FASTA file to trim both read by all the sequences in this 
      FASTA file
    default: ''
    inputBinding:
      position: 101
      prefix: --adapter_fasta
  - id: break_mean_quality
    type:
      - 'null'
      - int
    doc: 'the mean quality requirement for sliding window breaking (5~30), default:
      10 (Q10)'
    default: 10
    inputBinding:
      position: 101
      prefix: --break_mean_quality
  - id: break_reads
    type:
      - 'null'
      - boolean
    doc: break the reads by discarding the low quality regions, these regions 
      are detected by sliding window with mean quality < break_mean_quality.
    inputBinding:
      position: 101
      prefix: --break
  - id: break_window_size
    type:
      - 'null'
      - int
    doc: 'the size of the sliding window to evaluate the mean quality for sliding
      window breaking(5~1000000), default: 100'
    default: 100
    inputBinding:
      position: 101
      prefix: --break_window_size
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
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression level for gzip output (1 ~ 9). 1 is fastest, 9 is smallest,
      default is 4.
    default: 4
    inputBinding:
      position: 101
      prefix: --compression
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
    doc: 'the mean quality requirement option shared by cut_front, cut_tail. Range:
      1~36 default: 20 (Q20)'
    default: 20
    inputBinding:
      position: 101
      prefix: --cut_mean_quality
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
    doc: 'the window size option shared by cut_front, cut_tail. Range: 1~1000, default:
      4'
    default: 4
    inputBinding:
      position: 101
      prefix: --cut_window_size
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
  - id: distance_threshold
    type:
      - 'null'
      - float
    doc: threshold of sequence-adapter-distance/adapter-length (0.0 ~ 1.0), 
      greater value means more adapters detected
    default: 0.25
    inputBinding:
      position: 101
      prefix: --distance_threshold
  - id: dont_overwrite
    type:
      - 'null'
      - boolean
    doc: don't overwrite existing files. Overwritting is allowed by default.
    inputBinding:
      position: 101
      prefix: --dont_overwrite
  - id: end_adapter
    type:
      - 'null'
      - string
    doc: the adapter sequence at read end (3').
    default: auto
    inputBinding:
      position: 101
      prefix: --end_adapter
  - id: failed_out
    type:
      - 'null'
      - string
    doc: specify the file to store reads that cannot pass the filters.
    default: '='
    inputBinding:
      position: 101
      prefix: --failed_out
  - id: html_report
    type:
      - 'null'
      - string
    doc: the html format report file name
    default: fastplong.html
    inputBinding:
      position: 101
      prefix: --html
  - id: input_file
    type:
      - 'null'
      - string
    doc: read input file name
    default: '='
    inputBinding:
      position: 101
      prefix: --in
  - id: json_report
    type:
      - 'null'
      - string
    doc: the json format report file name
    default: fastplong.json
    inputBinding:
      position: 101
      prefix: --json
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
    doc: reads shorter than length_required will be discarded, default is 20.
    default: 20
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
  - id: mask
    type:
      - 'null'
      - boolean
    doc: mask the low quality regions with N, these regions are detected by 
      sliding window with mean quality < mask_mean_quality.
    inputBinding:
      position: 101
      prefix: --mask
  - id: mask_mean_quality
    type:
      - 'null'
      - int
    doc: 'the mean quality requirement for sliding window N masking (5~30), default:
      10 (Q10)'
    default: 10
    inputBinding:
      position: 101
      prefix: --mask_mean_quality
  - id: mask_window_size
    type:
      - 'null'
      - int
    doc: 'the size of the sliding window to evaluate the mean quality for N masking(5~1000000),
      default: 50'
    default: 50
    inputBinding:
      position: 101
      prefix: --mask_window_size
  - id: mean_qual
    type:
      - 'null'
      - int
    doc: if one read's mean_qual quality score <mean_qual, then this read is 
      discarded. Default 0 means no requirement
    default: 0
    inputBinding:
      position: 101
      prefix: --mean_qual
  - id: n_base_limit
    type:
      - 'null'
      - int
    doc: if number of N base is >n_base_limit, then this read is discarded 
      (0~1000000). 0 means no N allowed, default 1000000 means no N limit
    default: 1000000
    inputBinding:
      position: 101
      prefix: --n_base_limit
  - id: n_percent_limit
    type:
      - 'null'
      - int
    doc: if one read's N base percentage is >n_percent_limit, then this read is 
      discarded (0~100). Default 10 means 10%
    default: 10
    inputBinding:
      position: 101
      prefix: --n_percent_limit
  - id: output_file
    type:
      - 'null'
      - string
    doc: read output file name
    default: '='
    inputBinding:
      position: 101
      prefix: --out
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
    doc: should be quoted with ' or ", default is "fastplong report"
    default: fastplong report
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
  - id: start_adapter
    type:
      - 'null'
      - string
    doc: the adapter sequence at read start (5').
    default: auto
    inputBinding:
      position: 101
      prefix: --start_adapter
  - id: stdin
    type:
      - 'null'
      - boolean
    doc: input from STDIN.
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
  - id: trim_front
    type:
      - 'null'
      - int
    doc: trimming how many bases in front for read, default is 0
    default: 0
    inputBinding:
      position: 101
      prefix: --trim_front
  - id: trim_poly_x
    type:
      - 'null'
      - boolean
    doc: enable polyX trimming in 3' ends.
    inputBinding:
      position: 101
      prefix: --trim_poly_x
  - id: trim_tail
    type:
      - 'null'
      - int
    doc: trimming how many bases in tail for read, default is 0
    default: 0
    inputBinding:
      position: 101
      prefix: --trim_tail
  - id: trimming_extension
    type:
      - 'null'
      - int
    doc: when an adapter is detected, extend the trimming to make cleaner 
      trimming, default 10 means trimming 10 bases more
    default: 10
    inputBinding:
      position: 101
      prefix: --trimming_extension
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastplong:0.4.1--h224cc79_0
stdout: fastplong.out
