cwlVersion: v1.2
class: CommandLineTool
baseCommand: macsydata
label: macsylib_macsydata
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log regarding a container runtime failure (no space
  left on device).\n\nTool homepage: https://github.com/gem-pasteur/macsylib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
stdout: macsylib_macsydata.out
