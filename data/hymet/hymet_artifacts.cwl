cwlVersion: v1.2
class: CommandLineTool
baseCommand: hymet artifacts
label: hymet_artifacts
doc: "Show commands without executing them\n\nTool homepage: https://github.com/inesbmartins02/HYMET"
inputs:
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Show commands without executing them
    inputBinding:
      position: 101
      prefix: --dry-run
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
stdout: hymet_artifacts.out
