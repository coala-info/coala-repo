cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: emirge_samtools
doc: "Tools for alignments in the SAM format\n\nTool homepage: https://github.com/csmiller/EMIRGE"
inputs:
  - id: command
    type: string
    doc: Command to execute (e.g., dict, faidx, index, calmd, etc.)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emirge:0.61.1--py27_1
stdout: emirge_samtools.out
