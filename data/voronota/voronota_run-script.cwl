cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_run-script
label: voronota_run-script
doc: "Run a script with Voronota\n\nTool homepage: https://www.voronota.com/"
inputs:
  - id: script
    type: File
    doc: script as plain text
    inputBinding:
      position: 1
  - id: exit_on_first_failure
    type:
      - 'null'
      - boolean
    doc: flag to terminate script when a command fails
    inputBinding:
      position: 102
      prefix: --exit-on-first-failure
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: flag for interactive mode
    inputBinding:
      position: 102
      prefix: --interactive
  - id: max_unfolding
    type:
      - 'null'
      - int
    doc: maximum level of output unfolding
    inputBinding:
      position: 102
      prefix: --max-unfolding
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdout: voronota_run-script.out
