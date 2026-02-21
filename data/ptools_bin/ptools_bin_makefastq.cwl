cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ptools_bin
  - makefastq
label: ptools_bin_makefastq
doc: "The provided text does not contain help information or a description for the
  tool. It contains container runtime log messages and a fatal error regarding image
  retrieval.\n\nTool homepage: https://github.com/ENCODE-DCC/ptools_bin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptools_bin:0.0.7--pyh5e36f6f_0
stdout: ptools_bin_makefastq.out
