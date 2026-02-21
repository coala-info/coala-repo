cwlVersion: v1.2
class: CommandLineTool
baseCommand: mustang-testdata
label: mustang-testdata
doc: "Test data for MUSTANG (Multiple structural alignment algorithm). Note: The provided
  text contains container runtime error messages rather than tool help documentation.\n
  \nTool homepage: http://lcb.infotech.monash.edu.au/mustang/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mustang-testdata:v3.2.3-3-deb_cv1
stdout: mustang-testdata.out
