cwlVersion: v1.2
class: CommandLineTool
baseCommand: riboraptor export-gene-coverages
label: riboraptor_export-gene-coverages
doc: "Export gene level coverage for all genes for given region\n\nTool homepage:
  https://github.com/saketkc/riboraptor"
inputs:
  - id: bigwig
    type: File
    doc: Path to bigwig
    inputBinding:
      position: 101
      prefix: --bigwig
  - id: ignore_tx_version
    type:
      - 'null'
      - boolean
    doc: Ignore version (.xyz) in gene names
    inputBinding:
      position: 101
      prefix: --ignore_tx_version
  - id: offset_3p
    type:
      - 'null'
      - int
    doc: Number of downstream bases to count(3')
    inputBinding:
      position: 101
      prefix: --offset_3p
  - id: offset_5p
    type:
      - 'null'
      - int
    doc: Number of upstream bases to count(5')
    inputBinding:
      position: 101
      prefix: --offset_5p
  - id: region_bed
    type: File
    doc: Path to bed file
    inputBinding:
      position: 101
      prefix: --region_bed
outputs:
  - id: saveto
    type:
      - 'null'
      - File
    doc: Path to write gene coverages tsv file
    outputBinding:
      glob: $(inputs.saveto)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
