cwlVersion: v1.2
class: CommandLineTool
baseCommand: sketchlib_inverted
label: sketchlib_inverted
doc: "Building and querying with inverted indices (.ski)\n\nTool homepage: https://github.com/bacpop/sketchlib.rust"
inputs:
  - id: command
    type: string
    doc: Command to execute (build, query, precluster, help)
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't show any messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show progress messages
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
stdout: sketchlib_inverted.out
