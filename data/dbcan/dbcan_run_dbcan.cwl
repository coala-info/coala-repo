cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_dbcan
label: dbcan_run_dbcan
doc: "dbCAN: automated Carbohydrate-active enzyme ANnotation. Note: The provided text
  contains error logs and environment information rather than command-line usage instructions.\n
  \nTool homepage: http://bcb.unl.edu/dbCAN2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcan:5.2.6--pyhdfd78af_0
stdout: dbcan_run_dbcan.out
