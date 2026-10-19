cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - riboraptor
  - periodicity
label: riboraptor_periodicity
doc: "Calculate periodicity\n\nTool homepage: https://github.com/saketkc/riboraptor"
inputs:
  - id: counts
    type:
      - 'null'
      - File
    doc: Path to counts file (if not stdin)
    inputBinding:
      position: 101
      prefix: --counts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
stdout: riboraptor_periodicity.out
