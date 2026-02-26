cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nextstrain
  - view
label: nextstrain_view
doc: "Visualizes a completed pathogen build in Auspice, the Nextstrain visualization
  app.\n\nTool homepage: https://nextstrain.org"
inputs:
  - id: directory
    type: Directory
    doc: Path to directory containing JSONs for Auspice
    inputBinding:
      position: 1
  - id: allow_remote_access
    type:
      - 'null'
      - boolean
    doc: Allow other computers on the network to access the website
    default: false
    inputBinding:
      position: 102
      prefix: --allow-remote-access
  - id: port
    type:
      - 'null'
      - int
    doc: Listen on the given port instead of the default port
    default: 4000
    inputBinding:
      position: 102
      prefix: --port
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextstrain:20200304--hdfd78af_1
stdout: nextstrain_view.out
