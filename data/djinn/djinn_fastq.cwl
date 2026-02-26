cwlVersion: v1.2
class: CommandLineTool
baseCommand: djinn fastq
label: djinn_fastq
doc: "FASTQ file conversions and modifications\n\nTool homepage: https://github.com/pdimens/djinn"
inputs:
  - id: command
    type: string
    doc: Command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (if pigz is available)
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
stdout: djinn_fastq.out
