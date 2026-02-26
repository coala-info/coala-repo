cwlVersion: v1.2
class: CommandLineTool
baseCommand: amulety
label: amulety
doc: "AMULETY: Adaptive imMUne receptor Language model Embedding tool for TCR and
  antibodY\n\nTool homepage: https://github.com/immcantation/amulety"
inputs:
  - id: command
    type: string
    doc: The command to execute (translate-igblast, embed, or check-deps)
    inputBinding:
      position: 1
  - id: log_file
    type:
      - 'null'
      - File
    doc: Path to log file. If not provided, logs will be printed to stdout.
    inputBinding:
      position: 102
      prefix: --log-file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging (DEBUG level).
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amulety:2.1.2--pyh6d73907_0
stdout: amulety.out
