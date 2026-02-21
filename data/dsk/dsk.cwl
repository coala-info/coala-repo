cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsk
label: dsk
doc: "DSK is a k-mer counter for NGS data. (Note: The provided text contains only
  system error logs and no help information; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/GATB/dsk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsk:2.3.3--h5ca1c30_7
stdout: dsk.out
