cwlVersion: v1.2
class: CommandLineTool
baseCommand: pychopper
label: pychopper
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a container execution failure.\n\nTool homepage:
  https://github.com/nanoporetech/pychopper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pychopper:2.7.10--pyhdfd78af_0
stdout: pychopper.out
