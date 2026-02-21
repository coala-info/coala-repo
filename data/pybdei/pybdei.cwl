cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybdei
label: pybdei
doc: "The provided text appears to be a container runtime error log rather than the
  help text for pybdei. As a result, no command-line arguments could be extracted.\n
  \nTool homepage: https://github.com/evolbioinfo/bdei"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybdei:0.13--py310hef477bb_1
stdout: pybdei.out
