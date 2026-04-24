cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastv
label: fastv
doc: "an ultra-fast tool for fast identification of SARS-CoV-2 and other microbes
  from sequencing data.\n\nTool homepage: https://github.com/OpenGene/fastv"
inputs:
  - id: adapter_fasta_file
    type:
      - 'null'
      - File
    doc: specify a FASTA file to trim both read1 and read2 (if PE) by all the 
      sequences in this FASTA file
    inputBinding:
      position: 101
      prefix: --adapter_fasta
  - id: adapter_sequence_read1
    type:
      - 'null'
      - string
    doc: the adapter for read1. For SE data, if not specified, the adapter will 
      be auto-detected. For PE data, this is used if R1/R2 are found not 
      overlapped.
    inputBinding:
      position: 101
      prefix: --adapter_sequence
  - id: adapter_sequence_read2
    type:
      - 'null'
      - string
    doc: the adapter for read2 (PE data only). This is used if R1/R2 are found 
      not overlapped. If not specified, it will be the same as 
      <adapter_sequence>
    inputBinding:
      position: 101
      prefix: --adapter_sequence_r2
  - id: average_qual
    type:
      - 'null'
      - int
    doc: if one read's average quality score <avg_qual, then this read/pair is 
      discarded. Default 0 means no requirement
    inputBinding:
      position: 101
      prefix: --average_qual
  - id: bin_size
    type:
      - 'null'
      - int
    doc: For coverage calculation. The genome is splitted to many bins, with 
      each bin has a length of bin_size (1 ~ 100000), default 0 means adaptive.
    inputBinding:
      position: 101
      prefix: --bin_size
  - id: complexity_threshold
    type:
      - 'null'
      - int
    doc: the threshold for low complexity filter (0~100). Default is 30, which 
      means 30% complexity is required.
    inputBinding:
      position: 101
      prefix: --complexity_threshold
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression level for gzip output (1 ~ 9). 1 is fastest, 9 is smallest,
      default is 4.
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
    inputBinding:
      position: 101
      prefix: --cut_front_mean_quality
  - id: cut_front_window_size
    type:
      - 'null'
      - int
    doc: the window size option of cut_front, default to cut_window_size if not 
      specified
    inputBinding:
      position: 101
      prefix: --cut_front_window_size
  - id: cut_mean_quality
    type:
      - 'null'
      - int
    doc: 'the mean quality requirement option shared by cut_front, cut_tail or cut_sliding.
      Range: 1~36 default: 20 (Q20)'
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
    inputBinding:
      position: 101
      prefix: --cut_right_mean_quality
  - id: cut_right_window_size
    type:
      - 'null'
      - int
    doc: the window size option of cut_right, default to cut_window_size if not 
      specified
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
    inputBinding:
      position: 101
      prefix: --cut_tail_mean_quality
  - id: cut_tail_window_size
    type:
      - 'null'
      - int
    doc: the window size option of cut_tail, default to cut_window_size if not 
      specified
    inputBinding:
      position: 101
      prefix: --cut_tail_window_size
  - id: cut_window_size
    type:
      - 'null'
      - int
    doc: 'the window size option shared by cut_front, cut_tail or cut_sliding. Range:
      1~1000, default: 4'
    inputBinding:
      position: 101
      prefix: --cut_window_size
  - id: depth_threshold
    type:
      - 'null'
      - float
    doc: For coverage calculation. A region is considered covered when its mean 
      depth >= depth_threshold (0.001 ~ 1000). 1.0 by default.
    inputBinding:
      position: 101
      prefix: --depth_threshold
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
  - id: dont_overwrite
    type:
      - 'null'
      - boolean
    doc: don't overwrite existing files. Overwritting is allowed by default.
    inputBinding:
      position: 101
      prefix: --dont_overwrite
  - id: ed_threshold
    type:
      - 'null'
      - int
    doc: If the edit distance of a sequence and a genome region is 
      <=ed_threshold, then consider it a match (0 ~ 50). 8 by default.
    inputBinding:
      position: 101
      prefix: --ed_threshold
  - id: enable_correction
    type:
      - 'null'
      - boolean
    doc: enable base correction in overlapped regions (only for PE data), 
      default is disabled
    inputBinding:
      position: 101
      prefix: --correction
  - id: enable_umi_preprocessing
    type:
      - 'null'
      - boolean
    doc: enable unique molecular identifier (UMI) preprocessing
    inputBinding:
      position: 101
      prefix: --umi
  - id: filter_by_index1_file
    type:
      - 'null'
      - File
    doc: specify a file contains a list of barcodes of index1 to be filtered 
      out, one barcode per line
    inputBinding:
      position: 101
      prefix: --filter_by_index1
  - id: filter_by_index2_file
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
    inputBinding:
      position: 101
      prefix: --filter_by_index_threshold
  - id: genomes_file
    type:
      - 'null'
      - File
    doc: the genomes file of the detection target in fasta format. 
      data/SARS-CoV-2.genomes.fa will be used if none of 
      k-mer/Genomes/k-mer_Collection file is specified
    inputBinding:
      position: 101
      prefix: --genomes
  - id: html_report_file
    type:
      - 'null'
      - File
    doc: the html format report file name
    inputBinding:
      position: 101
      prefix: --html
  - id: input_from_stdin
    type:
      - 'null'
      - boolean
    doc: input from STDIN. If the STDIN is interleaved paired-end FASTQ, please 
      also add --interleaved_in.
    inputBinding:
      position: 101
      prefix: --stdin
  - id: interleaved_input
    type:
      - 'null'
      - boolean
    doc: indicate that <in1> is an interleaved FASTQ which contains both read1 
      and read2. Disabled by default.
    inputBinding:
      position: 101
      prefix: --interleaved_in
  - id: json_report_file
    type:
      - 'null'
      - File
    doc: the json format report file name
    inputBinding:
      position: 101
      prefix: --json
  - id: kc_coverage_threshold
    type:
      - 'null'
      - double
    doc: For each genome in the k-mer collection FASTA, report it when its 
      coverage > kc_coverage_threshold. Default is 0.01.
    inputBinding:
      position: 101
      prefix: --kc_coverage_threshold
  - id: kc_high_confidence_coverage_threshold
    type:
      - 'null'
      - double
    doc: For each genome in the k-mer collection FASTA, report it as high 
      confidence when its coverage > kc_high_confidence_coverage_threshold. 
      Default is 0.9.
    inputBinding:
      position: 101
      prefix: --kc_high_confidence_coverage_threshold
  - id: kc_high_confidence_median_hit_threshold
    type:
      - 'null'
      - int
    doc: For each genome in the k-mer collection FASTA, report it as high 
      confidence when its median hits > kc_high_confidence_median_hit_threshold.
      Default is 5.
    inputBinding:
      position: 101
      prefix: --kc_high_confidence_median_hit_threshold
  - id: kmer_collection_file
    type:
      - 'null'
      - File
    doc: 'the unique k-mer collection file in fasta format, see an example: http://opengene.org/kmer_collection.fasta'
    inputBinding:
      position: 101
      prefix: --kmer_collection
  - id: kmer_file
    type:
      - 'null'
      - File
    doc: the unique k-mer file of the detection target in fasta format. 
      data/SARS-CoV-2.kmer.fa will be used if none of 
      k-mer/Genomes/k-mer_Collection file is specified
    inputBinding:
      position: 101
      prefix: --kmer
  - id: length_limit
    type:
      - 'null'
      - int
    doc: reads longer than length_limit will be discarded, default 0 means no 
      limitation.
    inputBinding:
      position: 101
      prefix: --length_limit
  - id: length_required
    type:
      - 'null'
      - int
    doc: reads shorter than length_required will be discarded, default is 15.
    inputBinding:
      position: 101
      prefix: --length_required
  - id: long_read_threshold
    type:
      - 'null'
      - int
    doc: A read will be considered as long read if its length >= 
      long_read_threshold (100 ~ 10000). 200 by default.
    inputBinding:
      position: 101
      prefix: --long_read_threshold
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
    inputBinding:
      position: 101
      prefix: --max_len2
  - id: n_base_limit
    type:
      - 'null'
      - int
    doc: if one read's number of N base is >n_base_limit, then this read/pair is
      discarded. Default is 5
    inputBinding:
      position: 101
      prefix: --n_base_limit
  - id: output_to_stdout
    type:
      - 'null'
      - boolean
    doc: stream passing-filters reads to STDOUT. This option will result in 
      interleaved FASTQ output for paired-end output. Disabled by default.
    inputBinding:
      position: 101
      prefix: --stdout
  - id: overlap_diff_limit
    type:
      - 'null'
      - int
    doc: the maximum number of mismatched bases to detect overlapped region of 
      PE reads. This will affect overlap analysis based PE merge, adapter 
      trimming and correction. 5 by default.
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
    inputBinding:
      position: 101
      prefix: --overlap_len_require
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
    inputBinding:
      position: 101
      prefix: --poly_g_min_len
  - id: poly_x_min_len
    type:
      - 'null'
      - int
    doc: the minimum length to detect polyX in the read tail. 10 by default.
    inputBinding:
      position: 101
      prefix: --poly_x_min_len
  - id: positive_threshold
    type:
      - 'null'
      - float
    doc: the data is considered as POSITIVE, when its mean coverage of unique 
      kmer >= positive_threshold (0.001 ~ 100). 0.1 by default.
    inputBinding:
      position: 101
      prefix: --positive_threshold
  - id: qualified_quality_phred
    type:
      - 'null'
      - int
    doc: the quality value that a base is qualified. Default 15 means phred 
      quality >=Q15 is qualified.
    inputBinding:
      position: 101
      prefix: --qualified_quality_phred
  - id: read1_input_file
    type:
      - 'null'
      - File
    doc: read1 input file name
    inputBinding:
      position: 101
      prefix: --in1
  - id: read2_input_file
    type:
      - 'null'
      - File
    doc: read2 input file name
    inputBinding:
      position: 101
      prefix: --in2
  - id: read_segment_len
    type:
      - 'null'
      - int
    doc: A long read will be splitted to read segments, with each <= 
      read_segment_len (50 ~ 5000, should be < long_read_threshold). 100 by 
      default.
    inputBinding:
      position: 101
      prefix: --read_segment_len
  - id: reads_to_process
    type:
      - 'null'
      - int
    doc: specify how many reads/pairs to be processed. Default 0 means process 
      all reads.
    inputBinding:
      position: 101
      prefix: --reads_to_process
  - id: report_title
    type:
      - 'null'
      - string
    doc: should be quoted with ' or ", default is "fastv report"
    inputBinding:
      position: 101
      prefix: --report_title
  - id: threads
    type:
      - 'null'
      - int
    doc: worker thread number, default is 4
    inputBinding:
      position: 101
      prefix: --thread
  - id: trim_front1
    type:
      - 'null'
      - int
    doc: trimming how many bases in front for read1, default is 0
    inputBinding:
      position: 101
      prefix: --trim_front1
  - id: trim_front2
    type:
      - 'null'
      - int
    doc: trimming how many bases in front for read2. If it's not specified, it 
      will follow read1's settings
    inputBinding:
      position: 101
      prefix: --trim_front2
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
    inputBinding:
      position: 101
      prefix: --trim_tail1
  - id: trim_tail2
    type:
      - 'null'
      - int
    doc: trimming how many bases in tail for read2. If it's not specified, it 
      will follow read1's settings
    inputBinding:
      position: 101
      prefix: --trim_tail2
  - id: umi_length
    type:
      - 'null'
      - int
    doc: if the UMI is in read1/read2, its length should be provided
    inputBinding:
      position: 101
      prefix: --umi_len
  - id: umi_location
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
  - id: umi_skip_bases
    type:
      - 'null'
      - int
    doc: if the UMI is in read1/read2, fastv can skip several bases following 
      UMI, default is 0
    inputBinding:
      position: 101
      prefix: --umi_skip
  - id: unqualified_percent_limit
    type:
      - 'null'
      - int
    doc: how many percents of bases are allowed to be unqualified (0~100). 
      Default 40 means 40%
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
  - id: read1_output_file
    type:
      - 'null'
      - File
    doc: file name to store read1 with on-target sequences
    outputBinding:
      glob: $(inputs.read1_output_file)
  - id: read2_output_file
    type:
      - 'null'
      - File
    doc: file name to store read2 with on-target sequences
    outputBinding:
      glob: $(inputs.read2_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastv:0.10.0--h077b44d_1
