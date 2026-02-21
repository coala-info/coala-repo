cwlVersion: v1.2
class: CommandLineTool
baseCommand: mustang
label: mustang-testdata_mustang
doc: "MUSTANG (MUlti-STructural AligNment) is a tool for the multiple structural alignment
  of proteins. (Note: The provided text is an error log and does not contain usage
  information or argument definitions).\n\nTool homepage: http://lcb.infotech.monash.edu.au/mustang/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mustang-testdata:v3.2.3-3-deb_cv1
stdout: mustang-testdata_mustang.out
