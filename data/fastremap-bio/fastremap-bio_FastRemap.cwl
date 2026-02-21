cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastRemap
label: fastremap-bio_FastRemap
doc: "FastRemap is a tool for rapid remapping of reads. (Note: The provided text is
  a system error log and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/CMU-SAFARI/FastRemap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastremap-bio:1.0.0--hdcf5f25_1
stdout: fastremap-bio_FastRemap.out
