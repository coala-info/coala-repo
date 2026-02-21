cwlVersion: v1.2
class: CommandLineTool
baseCommand: sfs_code
label: sfs_code
doc: "No description available: The provided text is an error log from a failed container
  build and does not contain help information.\n\nTool homepage: http://sfscode.sourceforge.net/SFS_CODE/index/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sfs:0.1.0--h9ee0642_0
stdout: sfs_code.out
