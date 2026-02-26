cwlVersion: v1.2
class: CommandLineTool
baseCommand: itero assemble
label: itero_assemble
doc: "Assemble cleaned/trimmed sequencing reads.\n\nTool homepage: https://github.com/faircloth-lab/itero"
inputs:
  - id: command
    type: string
    doc: Command to run for assembly (local or mpi)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itero:1.1.2--py27_0
stdout: itero_assemble.out
