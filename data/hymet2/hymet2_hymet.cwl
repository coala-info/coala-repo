cwlVersion: v1.2
class: CommandLineTool
baseCommand: []
label: hymet2_hymet
doc: "Please enter the path to the input directory (containing .fna files):\n\nTool
  homepage: https://github.com/inesbmartins02/HYMET2"
inputs:
  - id: input_directory
    type: Directory
    doc: Path to the input directory containing .fna files (sent to the program's prompt
      on standard input)
arguments:
  - position: 1
    shellQuote: false
    valueFrom: printf '%s\n' "$(inputs.input_directory.path)" | hymet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet2:1.0.0--hdfd78af_0
stdout: hymet2_hymet.out
