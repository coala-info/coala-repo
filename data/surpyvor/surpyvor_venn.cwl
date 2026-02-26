cwlVersion: v1.2
class: CommandLineTool
baseCommand: surpyvor venn
label: surpyvor_venn
doc: "Generate Venn diagrams of structural variants from multiple VCF files.\n\nTool
  homepage: https://github.com/wdecoster/surpyvor"
inputs:
  - id: distance
    type:
      - 'null'
      - float
    doc: maximum distance between test and truth call
    inputBinding:
      position: 101
      prefix: --distance
  - id: ignore_type
    type:
      - 'null'
      - boolean
    doc: Ignore the type of the structural variant
    inputBinding:
      position: 101
      prefix: --ignore_type
  - id: minlength
    type:
      - 'null'
      - int
    doc: Minimum length of SVs to be taken into account
    inputBinding:
      position: 101
      prefix: --minlength
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of datasets in --variants
    inputBinding:
      position: 101
      prefix: --names
  - id: variants
    type:
      type: array
      items: File
    doc: vcfs containing structural variants
    inputBinding:
      position: 101
      prefix: --variants
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print out more information while running.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: keepmerged
    type:
      - 'null'
      - File
    doc: Save merged vcf file
    outputBinding:
      glob: $(inputs.keepmerged)
  - id: plotout
    type:
      - 'null'
      - File
    doc: Name of output plot
    outputBinding:
      glob: $(inputs.plotout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
