cwlVersion: v1.2
class: CommandLineTool
baseCommand: autodock-getdata
label: autodock-getdata
doc: "A tool for retrieving data for AutoDock. (Note: The provided text contains build
  logs and error messages rather than command-line help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: http://autodock.scripps.edu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/autodock-getdata:v4.2.6-6-deb_cv1
stdout: autodock-getdata.out
