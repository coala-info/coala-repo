cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pathoscope
  - id
label: pathoscope_ID
doc: "PathoScope ID: Identification and quantification of microbes from sequencing
  data\n\nTool homepage: https://github.com/PathoScope/PathoScope"
inputs:
  - id: align_file
    type: File
    doc: Alignment file path
    inputBinding:
      position: 101
      prefix: -alignFile
  - id: em_epsilon
    type:
      - 'null'
      - float
    doc: EM Algorithm Epsilon cutoff
    inputBinding:
      position: 101
      prefix: -emEpsilon
  - id: exp_tag
    type:
      - 'null'
      - string
    doc: Experiment tag added to output file for easy identification
    default: pathoid
    inputBinding:
      position: 101
      prefix: -expTag
  - id: file_type
    type:
      - 'null'
      - string
    doc: 'Alignment Format: sam/bl8/gnu-sam'
    default: sam
    inputBinding:
      position: 101
      prefix: -fileType
  - id: max_iter
    type:
      - 'null'
      - int
    doc: EM Algorithm maximum iterations
    inputBinding:
      position: 101
      prefix: -maxIter
  - id: no_display_cutoff
    type:
      - 'null'
      - boolean
    doc: Do not cutoff display of genomes, even if it is insignificant
    inputBinding:
      position: 101
      prefix: --noDisplayCutoff
  - id: no_updated_align_file
    type:
      - 'null'
      - boolean
    doc: Do not generate an updated alignment file
    inputBinding:
      position: 101
      prefix: --noUpdatedAlignFile
  - id: out_matrix
    type:
      - 'null'
      - boolean
    doc: Output alignment matrix
    inputBinding:
      position: 101
      prefix: --outMatrix
  - id: pi_prior
    type:
      - 'null'
      - int
    doc: EM Algorithm Pi Prior equivalent to adding n unique reads
    default: 0
    inputBinding:
      position: 101
      prefix: -piPrior
  - id: score_cutoff
    type:
      - 'null'
      - float
    doc: Score Cutoff
    inputBinding:
      position: 101
      prefix: -scoreCutoff
  - id: theta_prior
    type:
      - 'null'
      - int
    doc: EM Algorithm Theta Prior equivalent to adding n non-unique reads
    default: 0
    inputBinding:
      position: 101
      prefix: -thetaPrior
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output Directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathoscope:2.0.7--pyhdfd78af_2
