cwlVersion: v1.2
class: CommandLineTool
baseCommand: pythoncyc
label: pythoncyc
doc: "Python interface to Pathway Tools (BioCyc). Note: The provided text is a container
  build log and does not contain CLI help information or argument definitions.\n\n
  Tool homepage: https://github.com/networkbiolab/PythonCyc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pythoncyc:2.0.2--pyhdfd78af_0
stdout: pythoncyc.out
