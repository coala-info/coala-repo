cwlVersion: v1.2
class: CommandLineTool
baseCommand: samtools
label: optitype_samtools
doc: "Tools for alignments in the SAM format\n\nTool homepage: https://github.com/FRED-2/OptiType"
inputs:
  - id: command
    type: string
    doc: samtools command
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: command specific options
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optitype:1.3.5--hdfd78af_3
stdout: optitype_samtools.out
