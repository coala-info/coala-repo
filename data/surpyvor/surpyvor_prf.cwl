cwlVersion: v1.2
class: CommandLineTool
baseCommand: surpyvor prf
label: surpyvor_prf
doc: "Calculate performance metrics for structural variant calls.\n\nTool homepage:
  https://github.com/wdecoster/surpyvor"
inputs:
  - id: bar
    type:
      - 'null'
      - boolean
    doc: Make stacked bar chart of SV lengths coloured by validation status
    inputBinding:
      position: 101
      prefix: --bar
  - id: distance
    type:
      - 'null'
      - float
    doc: maximum distance between test and truth call
    inputBinding:
      position: 101
      prefix: --distance
  - id: ignore_chroms
    type:
      - 'null'
      - type: array
        items: string
    doc: Chromosomes to ignore for prf calculation.
    inputBinding:
      position: 101
      prefix: --ignore_chroms
  - id: ignore_type
    type:
      - 'null'
      - boolean
    doc: Ignore the type of the structural variant
    inputBinding:
      position: 101
      prefix: --ignore_type
  - id: matrix
    type:
      - 'null'
      - boolean
    doc: Make a confusion matrix.
    inputBinding:
      position: 101
      prefix: --matrix
  - id: minlength
    type:
      - 'null'
      - int
    doc: Minimum length of SVs to be taken into account
    inputBinding:
      position: 101
      prefix: --minlength
  - id: test
    type: File
    doc: vcf containing test set
    inputBinding:
      position: 101
      prefix: --test
  - id: truth
    type: File
    doc: vcf containing truth set
    inputBinding:
      position: 101
      prefix: --truth
  - id: venn
    type:
      - 'null'
      - boolean
    doc: Make a venn diagram.
    inputBinding:
      position: 101
      prefix: --venn
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
    doc: Save merged vcf file.
    outputBinding:
      glob: $(inputs.keepmerged)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/surpyvor:0.15.0--pyhdfd78af_0
