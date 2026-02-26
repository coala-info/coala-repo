cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccsmeth call_hifi
label: ccsmeth_call_hifi
doc: "call hifi reads with kinetics from subreads.bam using CCS, save in bam/sam format.\n\
  \nTool homepage: https://github.com/PengNi/ccsmeth"
inputs:
  - id: by_strand
    type:
      - 'null'
      - boolean
    doc: 'CCS: Generate a consensus for each strand.'
    inputBinding:
      position: 101
      prefix: --by-strand
  - id: hd_finder
    type:
      - 'null'
      - boolean
    doc: 'CCS: Enable heteroduplex finder and splitting.'
    inputBinding:
      position: 101
      prefix: --hd-finder
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'CCS: Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]'
    default: WARN
    inputBinding:
      position: 101
      prefix: --log-level
  - id: min_passes
    type:
      - 'null'
      - int
    doc: 'CCS: Minimum number of full-length subreads required to generate CCS for
      a ZMW. default None -> means using a default value set by CCS'
    inputBinding:
      position: 101
      prefix: --min-passes
  - id: path_to_ccs
    type:
      - 'null'
      - File
    doc: full path to the executable binary ccs(PBCCS) file. If not specified, 
      it is assumed that ccs is in the PATH.
    inputBinding:
      position: 101
      prefix: --path_to_ccs
  - id: path_to_samtools
    type:
      - 'null'
      - File
    doc: full path to the executable binary samtools file. If not specified, it 
      is assumed that samtools is in the PATH.
    inputBinding:
      position: 101
      prefix: --path_to_samtools
  - id: subreads
    type: File
    doc: path to subreads.bam file as input
    inputBinding:
      position: 101
      prefix: --subreads
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to call hifi reads, default None -> means using all 
      available processors
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file path for alignment results, bam/sam supported. If not 
      specified, the results will be saved in input_file_prefix.hifi.bam by 
      default.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
