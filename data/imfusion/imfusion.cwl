cwlVersion: v1.2
class: CommandLineTool
baseCommand: imfusion
label: imfusion
doc: "A tool for identifying insertional mutagenesis in fusion genes (Note: The provided
  text was a container runtime error log and did not contain help information).\n\n
  Tool homepage: https://github.com/iamsh4shank/Imfusion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
stdout: imfusion.out
