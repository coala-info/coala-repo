cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyopenms_IDMassAccuracy
label: pyopenms_IDMassAccuracy
doc: "The provided text does not contain help information for the tool, but rather
  container runtime error messages. No arguments or tool description could be extracted
  from the input.\n\nTool homepage: https://github.com/OpenMS/OpenMS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyopenms:3.4.1--py310h7ad0250_2
stdout: pyopenms_IDMassAccuracy.out
