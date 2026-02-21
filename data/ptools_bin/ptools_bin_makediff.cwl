cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptools_bin_makediff
label: ptools_bin_makediff
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container build process.\n\nTool
  homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
stdout: ptools_bin_makediff.out
