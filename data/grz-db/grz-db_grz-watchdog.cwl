cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grz-db
  - watchdog
label: grz-db_grz-watchdog
doc: "Watchdog tool for grz-db\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-db:1.2.0--pyhdfd78af_0
stdout: grz-db_grz-watchdog.out
