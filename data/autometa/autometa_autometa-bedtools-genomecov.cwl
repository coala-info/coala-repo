cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-bedtools-genomecov
label: autometa_autometa-bedtools-genomecov
doc: "Compute genome coverage from sorted BAM file\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: ibam
    type: File
    doc: "Path to sorted alignment.bam"
    inputBinding:
      position: 1
      prefix: --ibam
  - id: bed
    type: string
    doc: "Path to write alignment.bed; tab-delimited cols=[contig,length]"
    inputBinding:
      position: 1
      prefix: --bed
  - id: output
    type: string
    doc: "Path to output coverage.tsv"
    inputBinding:
      position: 1
      prefix: --output
  - id: force_bed
    type:
      - 'null'
      - boolean
    doc: "force overwrite `bed`"
    inputBinding:
      position: 1
      prefix: --force-bed
  - id: force_cov
    type:
      - 'null'
      - boolean
    doc: "force overwrite `--output`"
    inputBinding:
      position: 1
      prefix: --force-cov
outputs:
  - id: bed_out
    type: File
    doc: "bedtools genomecov table"
    outputBinding:
      glob: "$(inputs.bed)"
  - id: coverage_out
    type: File
    doc: "Contig coverage table"
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
