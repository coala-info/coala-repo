cwlVersion: v1.2
class: CommandLineTool
baseCommand: align_trim
label: align_trim_aligntrim
doc: "The provided text does not contain help information for the tool. It consists
  of system logs and a fatal error message indicating a failure to build or run a
  container image due to insufficient disk space ('no space left on device').\n\n
  Tool homepage: https://github.com/artic-network/align_trim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alignlib-lite:0.3--py312h9c9b0c2_9
stdout: align_trim_aligntrim.out
