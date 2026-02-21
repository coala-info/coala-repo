cwlVersion: v1.2
class: CommandLineTool
baseCommand: tepid-refine
label: tepid_tepid-refine
doc: "The provided text is a container execution error log and does not contain help
  documentation or usage instructions for the tool. As a result, no arguments could
  be extracted.\n\nTool homepage: https://github.com/ListerLab/TEPID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tepid:0.10--py_0
stdout: tepid_tepid-refine.out
