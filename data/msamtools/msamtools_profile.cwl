cwlVersion: v1.2
class: CommandLineTool
baseCommand: msamtools profile
label: msamtools_profile
doc: "Produces an abundance profile of all reference sequences in a BAM file based
  on the number of read-pairs (inserts) mapping to each reference sequence.\n\nTool
  homepage: https://github.com/arumugamlab/msamtools"
inputs:
  - id: input_sam_bam
    type: File
    doc: input SAM/BAM file
    inputBinding:
      position: 1
  - id: abundance_unit
    type:
      - 'null'
      - string
    doc: unit of abundance to report {ab | rel | fpkm | tpm}
    default: rel
    inputBinding:
      position: 102
      prefix: --unit
  - id: do_not_normalize_for_length
    type:
      - 'null'
      - boolean
    doc: 'do not normalize the abundance (only relevant for ab or rel) for sequence
      length (default: normalize)'
    default: false
    inputBinding:
      position: 102
      prefix: --nolen
  - id: genome_definition_file
    type:
      - 'null'
      - File
    doc: tab-delimited genome definition file - 'genome-id<tab>seq-id'
    default: none
    inputBinding:
      position: 102
      prefix: --genome
  - id: input_is_sam
    type:
      - 'null'
      - boolean
    doc: input is SAM
    default: false
    inputBinding:
      position: 102
      prefix: -S
  - id: label
    type: string
    doc: label to use for the profile; typically the sample id
    inputBinding:
      position: 102
      prefix: --label
  - id: min_feature_count
    type:
      - 'null'
      - int
    doc: minimum number of inserts mapped to a feature, below which the feature 
      is counted as absent
    default: 0
    inputBinding:
      position: 102
      prefix: --mincount
  - id: multi_mapper_handling
    type:
      - 'null'
      - string
    doc: how to deal with multi-mappers {all | equal | proportional}
    default: proportional
    inputBinding:
      position: 102
      prefix: --multi
  - id: total_inserts
    type:
      - 'null'
      - int
    doc: number of high-quality inserts (mate-pairs/paired-ends) that were input
      to the aligner
    default: 0
    inputBinding:
      position: 102
      prefix: --total
  - id: use_pandas_header
    type:
      - 'null'
      - boolean
    doc: 'print two columns (ID, sample-label) as header compatible with python pandas
      (default: only sample label)'
    default: false
    inputBinding:
      position: 102
      prefix: --pandas
outputs:
  - id: output_file
    type: File
    doc: name of output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msamtools:1.1.3--h577a1d6_1
