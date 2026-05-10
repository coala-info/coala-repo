cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet-seqstat
  - generate
label: biopet-seqstat_generate
doc: "Generate stats from FastQ files\n\nTool homepage: https://github.com/biopet/seqstat"
inputs:
  - id: fastq_r1
    type: File
    doc: FastQ file to generate stats from
    inputBinding:
      position: 101
      prefix: --fastqR1
  - id: fastq_r2
    type:
      - 'null'
      - File
    doc: FastQ file to generate stats from
    inputBinding:
      position: 101
      prefix: --fastqR2
  - id: library
    type: string
    doc: Library name
    inputBinding:
      position: 101
      prefix: --library
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
  - id: readgroup
    type: string
    doc: Readgroup name
    inputBinding:
      position: 101
      prefix: --readgroup
  - id: sample
    type: string
    doc: Sample name
    inputBinding:
      position: 101
      prefix: --sample
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: File to write output to, if not supplied output go to stdout
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-seqstat:1.0.1--0
