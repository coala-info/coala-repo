cwlVersion: v1.2
class: CommandLineTool
baseCommand: macsylib
label: macsylib
doc: "Macsylib (Note: The provided text contains only environment logs and error messages;
  no help text or usage information was found to extract arguments).\n\nTool homepage:
  https://github.com/gem-pasteur/macsylib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
stdout: macsylib.out
