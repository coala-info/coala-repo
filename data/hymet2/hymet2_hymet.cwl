cwlVersion: v1.2
class: CommandLineTool
baseCommand: hymet2_hymet
label: hymet2_hymet
doc: "Please enter the path to the input directory (containing .fna files):\n\nTool
  homepage: https://github.com/inesbmartins02/HYMET2"
inputs:
  - id: input_directory
    type: Directory
    doc: Path to the input directory containing .fna files
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet2:1.0.0--hdfd78af_0
stdout: hymet2_hymet.out
