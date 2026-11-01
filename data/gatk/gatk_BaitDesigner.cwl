cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- BaitDesigner
label: gatk_BaitDesigner
doc: |-
  Designs oligonucleotide baits for hybrid selection reactions. This tool is used to design custom bait sets for hybrid selection experiments. The following files are input into BaitDesigner: a (TARGET) interval list indicating the sequences of interest, e.g. exons with their respective coordinates, a reference sequence, and a unique identifier string (DESIGN_NAME).

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
- id: design_name
  type: string
  doc: The name of the bait design
  inputBinding:
    position: 1
    prefix: --DESIGN_NAME
- id: reference_sequence
  type: File
  doc: Reference sequence file.
  inputBinding:
    position: 1
    prefix: --REFERENCE_SEQUENCE
  secondaryFiles:
  - .fai
  - ^.dict
- id: targets
  type: File
  doc: The file with design parameters and targets
  inputBinding:
    position: 1
    prefix: --TARGETS
- id: bait_offset
  type:
  - 'null'
  - int
  doc: The desired offset between the start of one bait and the start of another bait
    for the same target.
  inputBinding:
    position: 1
    prefix: --BAIT_OFFSET
- id: bait_size
  type:
  - 'null'
  - int
  doc: The length of each individual bait to design
  inputBinding:
    position: 1
    prefix: --BAIT_SIZE
- id: design_on_target_strand
  type:
  - 'null'
  - boolean
  doc: 'If true design baits on the strand of the target feature, if false always
    design on the + strand of the genome. Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --DESIGN_ON_TARGET_STRAND
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: design_strategy
  type:
  - 'null'
  - string
  doc: 'The design strategy to use to layout baits across each target Possible values:
    CenteredConstrained, FixedOffset, Simple.'
  inputBinding:
    position: 1
    prefix: --DESIGN_STRATEGY
- id: fill_pools
  type:
  - 'null'
  - boolean
  doc: 'If true, fill up the pools with alternating fwd and rc copies of all baits.
    Equal copies of all baits will always be maintained Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --FILL_POOLS
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: left_primer
  type:
  - 'null'
  - string
  doc: The left amplification primer to prepend to all baits for synthesis
  inputBinding:
    position: 1
    prefix: --LEFT_PRIMER
- id: merge_nearby_targets
  type:
  - 'null'
  - boolean
  doc: 'If true merge targets that are ''close enough'' that designing against a merged
    target would be more efficient. Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --MERGE_NEARBY_TARGETS
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: minimum_baits_per_target
  type:
  - 'null'
  - int
  doc: The minimum number of baits to design per target.
  inputBinding:
    position: 1
    prefix: --MINIMUM_BAITS_PER_TARGET
- id: output_agilent_files
  type:
  - 'null'
  - boolean
  doc: 'If true also output .design.txt files per pool with one line per bait sequence
    Possible values: true, false.'
  inputBinding:
    position: 1
    prefix: --OUTPUT_AGILENT_FILES
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: output_directory
  type:
  - 'null'
  - string
  default: baits_out
  doc: The output directory. If not provided then the DESIGN_NAME will be used as
    the output directory
  inputBinding:
    position: 1
    prefix: --OUTPUT_DIRECTORY
- id: padding
  type:
  - 'null'
  - int
  doc: Pad the input targets by this amount when designing baits. Padding is applied
    on both sides in this amount.
  inputBinding:
    position: 1
    prefix: --PADDING
- id: pool_size
  type:
  - 'null'
  - int
  doc: The size of pools or arrays for synthesis. If no pool files are desired, can
    be set to 0.
  inputBinding:
    position: 1
    prefix: --POOL_SIZE
- id: repeat_tolerance
  type:
  - 'null'
  - int
  doc: Baits that have more than REPEAT_TOLERANCE soft or hard masked bases will not
    be allowed
  inputBinding:
    position: 1
    prefix: --REPEAT_TOLERANCE
- id: right_primer
  type:
  - 'null'
  - string
  doc: The right amplification primer to prepend to all baits for synthesis
  inputBinding:
    position: 1
    prefix: --RIGHT_PRIMER
outputs:
- id: output_directory_dir
  type: Directory
  doc: The output directory. If not provided then the DESIGN_NAME will be used as
    the output directory
  outputBinding:
    glob: $(inputs.output_directory)
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
