cwlVersion: v1.2
class: CommandLineTool
baseCommand: avro-cwl
label: avro-cwl
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log indicating that the executable 'avro-cwl' was not found in the
  system PATH during a container execution attempt.\n\nTool homepage: https://pypi.python.org/pypi?:action=display&name=avro-cwl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/avro-cwl:1.8.9--py_0
stdout: avro-cwl.out
