cwlVersion: v1.2
class: CommandLineTool
baseCommand: svanalyzer
label: svanalyzer
doc: "A tool for structural variant analysis (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  http://svanalyzer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svanalyzer:0.36--pl5321hdfd78af_2
stdout: svanalyzer.out
