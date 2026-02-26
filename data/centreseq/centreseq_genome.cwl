cwlVersion: v1.2
class: CommandLineTool
baseCommand: centreseq
label: centreseq_genome
doc: "CentreSeq is a tool for analyzing sequencing data.\n\nTool homepage: https://github.com/bfssi-forest-dussault/centreseq"
inputs:
  - id: options
    type:
      - 'null'
      - string
    doc: General options for centreseq
    inputBinding:
      position: 1
  - id: command
    type: string
    doc: The command to execute (e.g., genome, qc, align)
    inputBinding:
      position: 2
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centreseq:0.3.8--py_0
stdout: centreseq_genome.out
