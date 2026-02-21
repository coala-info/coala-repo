cwlVersion: v1.2
class: CommandLineTool
baseCommand: kegalign
label: kegalign-full_kegalign
doc: "The provided text does not contain help documentation or usage instructions;
  it consists of container runtime error messages regarding a lack of disk space during
  image conversion.\n\nTool homepage: https://github.com/galaxyproject/KegAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kegalign-full:0.1.2.8--hdfd78af_0
stdout: kegalign-full_kegalign.out
