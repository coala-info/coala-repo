cwlVersion: v1.2
class: CommandLineTool
baseCommand: expMatrixToBarChartBed
label: ucsc-expmatrixtobarchartbed
doc: "The provided text is a container execution error log and does not contain help
  documentation or usage instructions for the tool.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-expmatrixtobarchartbed:469--h664eb37_1
stdout: ucsc-expmatrixtobarchartbed.out
