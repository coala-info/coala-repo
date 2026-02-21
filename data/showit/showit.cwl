cwlVersion: v1.2
class: CommandLineTool
baseCommand: showit
label: showit
doc: "The provided text appears to be a container build log rather than command-line
  help text. As a result, no specific arguments or descriptions could be extracted
  from the input.\n\nTool homepage: https://github.com/freeman-lab/showit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/showit:1.1.4--py_0
stdout: showit.out
