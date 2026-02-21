cwlVersion: v1.2
class: CommandLineTool
baseCommand: hymet2_main.pl
label: hymet2_main.pl
doc: "HyMet2 tool (Note: The provided text contains container execution errors rather
  than command-line help documentation. No arguments could be extracted from the input.)\n
  \nTool homepage: https://github.com/inesbmartins02/HYMET2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet2:1.0.0--hdfd78af_0
stdout: hymet2_main.pl.out
