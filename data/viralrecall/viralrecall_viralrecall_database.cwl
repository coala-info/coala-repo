cwlVersion: v1.2
class: CommandLineTool
baseCommand: viralrecall_database
label: viralrecall_viralrecall_database
doc: "Database management for ViralRecall. Note: The provided help text contains only
  container runtime logs and error messages, so no arguments could be extracted.\n
  \nTool homepage: https://github.com/abdealijivaji/ViralRecall_3.0"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralrecall:3.0.2--pyhdfd78af_0
stdout: viralrecall_viralrecall_database.out
