cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cannoli-submit
  - bcftoolsCall
label: cannoli_bcftoolsCall
doc: "Call variants from alignments using bcftools call via Cannoli/Spark.\n\nTool
  homepage: https://github.com/bigdatagenomics/cannoli"
inputs:
  - id: input
    type: File
    doc: Input ADAM alignments
    inputBinding:
      position: 1
  - id: consensus_caller
    type:
      - 'null'
      - boolean
    doc: The original calling method
    inputBinding:
      position: 102
      prefix: --consensus_caller
  - id: multiallelic_caller
    type:
      - 'null'
      - boolean
    doc: Alternative model for multiallelic and rare-variant calling
    inputBinding:
      position: 102
      prefix: --multiallelic_caller
  - id: ploidy
    type:
      - 'null'
      - string
    doc: Predefined ploidy
    inputBinding:
      position: 102
      prefix: --ploidy
  - id: ploidy_file
    type:
      - 'null'
      - File
    doc: Ploidy file
    inputBinding:
      position: 102
      prefix: --ploidy_file
  - id: samples
    type:
      - 'null'
      - string
    doc: Comma-separated list of samples to include
    inputBinding:
      position: 102
      prefix: --samples
  - id: samples_file
    type:
      - 'null'
      - File
    doc: File of samples to include
    inputBinding:
      position: 102
      prefix: --samples_file
  - id: variants_only
    type:
      - 'null'
      - boolean
    doc: Output variant sites only
    inputBinding:
      position: 102
      prefix: --variants_only
outputs:
  - id: output
    type: File
    doc: Output ADAM variants
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
