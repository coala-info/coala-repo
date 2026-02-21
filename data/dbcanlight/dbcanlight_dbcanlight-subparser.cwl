cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbcanlight
label: dbcanlight_dbcanlight-subparser
doc: "A tool for automated carbohydrate-active enzyme (CAZyme) annotation.\n\nTool
  homepage: https://github.com/chtsai0105/dbcanLight/tree/main"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcanlight:1.1.1--pyhdfd78af_0
stdout: dbcanlight_dbcanlight-subparser.out
