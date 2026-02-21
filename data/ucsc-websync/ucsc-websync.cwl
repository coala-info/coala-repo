cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-websync
label: ucsc-websync
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-websync:469--h664eb37_1
stdout: ucsc-websync.out
