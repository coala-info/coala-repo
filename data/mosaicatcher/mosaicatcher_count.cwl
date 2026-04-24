cwlVersion: v1.2
class: CommandLineTool
baseCommand: count
label: mosaicatcher_count
doc: "Count reads from Strand-seq BAM files.\n\nTool homepage: https://github.com/friendsofstrandseq/mosaicatcher/"
inputs:
  - id: input_bams
    type:
      type: array
      items: File
    doc: Strand-seq BAM files
    inputBinding:
      position: 1
  - id: bins
    type:
      - 'null'
      - File
    doc: BED file with manual bins (disables -w). See also 'makebins'
    inputBinding:
      position: 102
      prefix: --bins
  - id: do_not_blacklist_hmm
    type:
      - 'null'
      - boolean
    doc: Do not output a blacklist (None bins). Bins will be blacklisted for 
      parameter estimation, but not during HMM
    inputBinding:
      position: 102
      prefix: --do-not-blacklist-hmm
  - id: do_not_filter_by_wc
    type:
      - 'null'
      - boolean
    doc: When black-listing bins, only consider coverage and not WC/WW/CC states
    inputBinding:
      position: 102
      prefix: --do-not-filter-by-WC
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude chromosomes and regions
    inputBinding:
      position: 102
      prefix: --exclude
  - id: info
    type:
      - 'null'
      - string
    doc: Write info about samples
    inputBinding:
      position: 102
      prefix: --info
  - id: mapq
    type:
      - 'null'
      - int
    doc: min mapping quality
    inputBinding:
      position: 102
      prefix: --mapq
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be more verbose in the output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: window
    type:
      - 'null'
      - int
    doc: window size of fixed windows
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file for counts + strand state (gz)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosaicatcher:0.3.1--h66ab1b6_2
