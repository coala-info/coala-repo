cwlVersion: v1.2
class: CommandLineTool
baseCommand: surpyvor_haplomerge
label: surpyvor_haplomerge
doc: "Merge VCF files from multiple callers.\n\nTool homepage: https://github.com/wdecoster/surpyvor"
inputs:
  - id: callers
    type:
      - 'null'
      - int
    doc: Minimum number of callers to support a variant
    inputBinding:
      position: 101
      prefix: --callers
  - id: distance
    type:
      - 'null'
      - int
    doc: distance between variants to merge
    inputBinding:
      position: 101
      prefix: --distance
  - id: estimate_distance
    type:
      - 'null'
      - boolean
    doc: Estimate distance between calls
    inputBinding:
      position: 101
      prefix: --estimate_distance
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
    doc: Minimum length of variants to consider
    inputBinding:
      position: 101
      prefix: --minlength
  - id: name
    type:
      - 'null'
      - string
    doc: name of sample in output VCF
    inputBinding:
      position: 101
      prefix: --name
  - id: strand
    type:
      - 'null'
      - boolean
    doc: Take strand into account
    inputBinding:
      position: 101
      prefix: --strand
  - id: variants
    type:
      type: array
      items: File
    doc: vcf files to merge
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
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
