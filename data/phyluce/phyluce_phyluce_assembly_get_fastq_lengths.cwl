cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_get_fastq_lengths
label: phyluce_phyluce_assembly_get_fastq_lengths
doc: "Get summary (length) data from fastq\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: Directory
    doc: "The directory of fastq files to summarize"
    inputBinding:
      position: 1
      prefix: --input
  - id: csv
    type:
      - 'null'
      - boolean
    doc: "Give output in CSV"
    inputBinding:
      position: 1
      prefix: --csv
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_assembly_get_fastq_lengths.out
