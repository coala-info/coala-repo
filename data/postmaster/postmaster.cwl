cwlVersion: v1.2
class: CommandLineTool
baseCommand: postmaster
label: postmaster
doc: "\nTool homepage: https://github.com/COMBINE-lab/postmaster"
inputs:
  - id: alignments
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --alignments
  - id: num_threads
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: output
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --output
  - id: quant
    type: string
    inputBinding:
      position: 101
      prefix: --quant
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/postmaster:0.1.0--ha6fb395_1
stdout: postmaster.out
