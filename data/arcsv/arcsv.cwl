cwlVersion: v1.2
class: CommandLineTool
baseCommand: arcsv
label: arcsv
doc: "The provided text is an error log from a container build process and does not
  contain help documentation or command-line arguments for the tool 'arcsv'.\n\nTool
  homepage: https://github.com/xuxif/ArcSV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arcsv:1.0.2--hdfd78af_0
stdout: arcsv.out
