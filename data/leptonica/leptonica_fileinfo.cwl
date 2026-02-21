cwlVersion: v1.2
class: CommandLineTool
baseCommand: fileinfo
label: leptonica_fileinfo
doc: "A tool from the Leptonica library to display information about image files.\n
  \nTool homepage: https://github.com/DanBloomberg/leptonica"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leptonica:1.73--1
stdout: leptonica_fileinfo.out
