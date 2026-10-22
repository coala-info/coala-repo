cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tiddit
  - --cov
label: tiddit_cov
doc: "TIDDIT coverage: generate a coverage bed/wig file.\n\nTool homepage: https://github.com/SciLifeLab/TIDDIT"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: "coordinate sorted bam file(required)"
    inputBinding:
      position: 101
      prefix: --bam
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "output prefix(default=output)"
    inputBinding:
      position: 101
      prefix: -o
  - id: bin_size
    type:
      - 'null'
      - string
    doc: "use bins of specified size(default = 500bp) to measure the coverage of the entire bam file, set output to stdout to print to stdout"
    inputBinding:
      position: 101
      prefix: -z
  - id: wig
    type:
      - 'null'
      - boolean
    doc: "generate wig instead of bed"
    inputBinding:
      position: 101
      prefix: -w
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: "minimum mapping quality(default=20)"
    inputBinding:
      position: 101
      prefix: -q
  - id: ref
    type:
      - 'null'
      - File
    doc: "reference fasta, used for reading cram"
    inputBinding:
      position: 101
      prefix: --ref
outputs:
  - id: coverage
    type: File
    doc: "Coverage in bed (or wig with -w) format"
    outputBinding:
      glob: "$((inputs.output_prefix ? inputs.output_prefix : 'output')).*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiddit:3.9.4--py311h93dcfea_0
