cwlVersion: v1.2
class: CommandLineTool
baseCommand: cuteSV_ONLINE
label: cutesv-ol_cuteSV_ONLINE
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding a failed container build (no space left on device).\n
  \nTool homepage: https://github.com/120L022331/cuteSV-OL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutesv-ol:1.0.2--py312h7b50bb2_0
stdout: cutesv-ol_cuteSV_ONLINE.out
