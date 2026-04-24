cwlVersion: v1.2
class: CommandLineTool
baseCommand: secapr clean_reads
label: secapr_clean_reads
doc: "Clean and trim raw Illumina read files\n\nTool homepage: https://github.com/AntonelliLab/seqcap_processor"
inputs:
  - id: complexity_threshold
    type:
      - 'null'
      - int
    doc: Reads below this complexity threshold will be removed (consult fastp 
      manual for more explanation).
    inputBinding:
      position: 101
      prefix: --complexity_threshold
  - id: cut_mean_quality
    type:
      - 'null'
      - int
    doc: Set quality threshold for moving window. If the mean quality across the
      window drops below this threshold, the nucleotides within the window are 
      removed (cut), as well as all trailing nucleotides.
    inputBinding:
      position: 101
      prefix: --cut_mean_quality
  - id: cut_window_size
    type:
      - 'null'
      - int
    doc: Set the size of the moving window (in nucleotides) for quality 
      trimming. The window will start moving from the end toward the beginning 
      of the read, applying the quality threshold set with the 
      --cut_mean_quality flag.
    inputBinding:
      position: 101
      prefix: --cut_window_size
  - id: disable_complexity_filter
    type:
      - 'null'
      - boolean
    doc: Use this flag if you want to disable the removal of low-complexity 
      reads, e.g. AAAAAAACCCCCCCCAAAAAAAAAAAAAAAAAAGGGGG (activated by default).
    inputBinding:
      position: 101
      prefix: --disable_complexity_filter
  - id: disable_poly_g_trimming
    type:
      - 'null'
      - boolean
    doc: Use this flag if you want to disable trimming of G repeats at the end 
      of the read. Poly-G read ends are common when working with very short 
      fragments. (activated by default).
    inputBinding:
      position: 101
      prefix: --disable_poly_g_trimming
  - id: disable_poly_x_trimming
    type:
      - 'null'
      - boolean
    doc: Use this flag if you want to disable trimming of nucleotide repeats of 
      any kind at the end of the read, e.g. poly-A tails (activated by default).
    inputBinding:
      position: 101
      prefix: --disable_poly_x_trimming
  - id: input
    type: Directory
    doc: The directory containing the .fastq or .fq files (raw read files). 
      Files can be zipped or unzipped.
    inputBinding:
      position: 101
      prefix: --input
  - id: poly_g_min_len
    type:
      - 'null'
      - int
    doc: Specifies the length of the nucleotide repeat region at end of read to 
      be trimmed.
    inputBinding:
      position: 101
      prefix: --poly_g_min_len
  - id: poly_x_min_len
    type:
      - 'null'
      - int
    doc: Specifies the length of the nucleotide repeat region at end of read to 
      be trimmed.
    inputBinding:
      position: 101
      prefix: --poly_x_min_len
  - id: qualified_quality_phred
    type:
      - 'null'
      - int
    doc: Specifies how accurate the match between any adapter etc. sequence must
      be against a read. For more information see trimmoatic tutorial.
    inputBinding:
      position: 101
      prefix: --qualified_quality_phred
  - id: read_min
    type:
      - 'null'
      - int
    doc: Set the minimum read count threshold. Any sample with fewer reads than 
      this minimum threshold will not be processed further.
    inputBinding:
      position: 101
      prefix: --read_min
  - id: required_read_length
    type:
      - 'null'
      - int
    doc: Set this value to only allow reads to pass which are equal to or longer
      than this threshold.
    inputBinding:
      position: 101
      prefix: --required_read_length
  - id: sample_annotation_file
    type: File
    doc: A simple comma-delimited text file containing the sample names in the 
      first column and the name-stem of the corresponding fastq files in the 
      second column (file should not have any column headers).
    inputBinding:
      position: 101
      prefix: --sample_annotation_file
  - id: trim_front
    type:
      - 'null'
      - int
    doc: Remove this number of nucleotides from the beginning of each read.
    inputBinding:
      position: 101
      prefix: --trim_front
  - id: trim_tail
    type:
      - 'null'
      - int
    doc: Remove this number of nucleotides from the end of each read.
    inputBinding:
      position: 101
      prefix: --trim_tail
  - id: unqualified_percent_limit
    type:
      - 'null'
      - int
    doc: Set the maximum percent of low-quality nucleotides allowed. Any read 
      with a higher percentage of unqualified (low quality) nucleotides will be 
      discarded.
    inputBinding:
      position: 101
      prefix: --unqualified_percent_limit
outputs:
  - id: output
    type: Directory
    doc: The output directory where the cleaned reads will be stored.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
