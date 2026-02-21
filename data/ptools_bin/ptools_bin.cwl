cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptools_bin
label: ptools_bin
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process for the ptools_bin image.\n\nTool homepage:
  https://github.com/ENCODE-DCC/ptools_bin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
stdout: ptools_bin.out
