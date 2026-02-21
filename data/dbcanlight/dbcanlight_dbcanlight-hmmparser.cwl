cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbcanlight-hmmparser
label: dbcanlight_dbcanlight-hmmparser
doc: "The provided text does not contain help information for the tool, but appears
  to be a container execution error log (no space left on device).\n\nTool homepage:
  https://github.com/chtsai0105/dbcanLight/tree/main"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcanlight:1.1.1--pyhdfd78af_0
stdout: dbcanlight_dbcanlight-hmmparser.out
