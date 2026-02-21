cwlVersion: v1.2
class: CommandLineTool
baseCommand: pywdl
label: pywdl
doc: "The provided text contains execution logs and error messages rather than help
  documentation. No arguments or usage information could be extracted from the input.\n
  \nTool homepage: https://github.com/broadinstitute/pywdl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pywdl:1.0.22--py_1
stdout: pywdl.out
