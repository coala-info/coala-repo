cwlVersion: v1.2
class: CommandLineTool
baseCommand: fba_map
label: fba_map
doc: "Quantify enriched transcripts (through hybridization or PCR amplification) from
  parent single cell libraries. Read 1 contains cell partitioning and UMI information,
  and read 2 contains transcribed regions of enriched/targeted transcripts of interest.
  BWA (Li, H. 2013) or Bowtie2 (Langmead, B., et al. 2012) is used for read 2 alignment.
  The quantification (UMI deduplication) of enriched/targeted transcripts is powered
  by UMI-tools (Smith, T., et al. 2017).\n\nTool homepage: https://github.com/jlduan/fba"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: specify aligner for read 2.
    default: bwa
    inputBinding:
      position: 101
      prefix: --aligner
  - id: cb_num_n_threshold
    type:
      - 'null'
      - int
    doc: specify maximum number of ambiguous nucleotides allowed for read 1.
    default: 3
    inputBinding:
      position: 101
      prefix: --cb_num_n_threshold
  - id: cell_barcode_mismatches
    type:
      - 'null'
      - int
    doc: specify cell barcode mismatching threshold.
    default: 1
    inputBinding:
      position: 101
      prefix: --cb_mismatches
  - id: feature_ref
    type: File
    doc: specify a reference of feature barcodes
    inputBinding:
      position: 101
      prefix: --feature_ref
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: specify minimal mapping quality required for feature mapping.
    default: 10
    inputBinding:
      position: 101
      prefix: --mapq
  - id: num_n_ref
    type:
      - 'null'
      - int
    doc: specify the number of Ns to separate sequences belonging to the same 
      feature.
    default: 0
    inputBinding:
      position: 101
      prefix: --num_n_ref
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: specify a temp directory.
    default: ./barcode_mapping
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: read1
    type: File
    doc: specify fastq file for read 1
    inputBinding:
      position: 101
      prefix: --read1
  - id: read1_coordinate
    type:
      - 'null'
      - string
    doc: "specify coordinate 'start,end' of read 1 to search. For example, '0,16':
      starts at 0, stops at 15. Nucleotide bases outside the range will be masked
      as lowercase in the output."
    default: 0,16
    inputBinding:
      position: 101
      prefix: --read1_coordinate
  - id: read2
    type: File
    doc: specify fastq file for read 2
    inputBinding:
      position: 101
      prefix: --read2
  - id: threads
    type:
      - 'null'
      - int
    doc: specify number of threads to launch. The default is to use all 
      available
    inputBinding:
      position: 101
      prefix: --threads
  - id: umi_deduplication_method
    type:
      - 'null'
      - string
    doc: specify UMI deduplication method (powered by UMI-tools. Smith, T., et 
      al. 2017).
    default: directional
    inputBinding:
      position: 101
      prefix: --umi_deduplication_method
  - id: umi_length
    type:
      - 'null'
      - int
    doc: specify the length of UMIs on read 1. Reads with UMI length less than 
      this value will be discarded.
    default: 12
    inputBinding:
      position: 101
      prefix: --umi_length
  - id: umi_mismatches
    type:
      - 'null'
      - int
    doc: specify the maximun edit distance allowed for UMIs on read 1 for 
      deduplication.
    default: 1
    inputBinding:
      position: 101
      prefix: --umi_mismatches
  - id: umi_start
    type:
      - 'null'
      - int
    doc: specify expected UMI starting postion on read 1.
    default: 16
    inputBinding:
      position: 101
      prefix: --umi_start
  - id: whitelist
    type: File
    doc: specify a whitelist of accepted cell barcodes
    inputBinding:
      position: 101
      prefix: --whitelist
outputs:
  - id: output
    type: File
    doc: specify an output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
