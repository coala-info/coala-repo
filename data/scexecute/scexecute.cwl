cwlVersion: v1.2
class: CommandLineTool
baseCommand: scexecute
label: scexecute
doc: "A tool for executing single-cell analysis tasks (Note: The provided text contains
  system error messages regarding container image retrieval and does not list specific
  command-line arguments).\n\nTool homepage: https://github.com/HorvathLab/NGS/tree/master/SCExecute#readme"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scexecute:1.3.3--hdfd78af_0
stdout: scexecute.out
