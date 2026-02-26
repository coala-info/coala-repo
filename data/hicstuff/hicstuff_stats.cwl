cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicstuff_stats
label: hicstuff_stats
doc: "Extract stats from a hicstuff log file.\n\nTool homepage: https://github.com/koszullab/hicstuff"
inputs:
  - id: log
    type: File
    doc: Path to a hicstuff log file.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicstuff:3.2.4--pyhdfd78af_0
stdout: hicstuff_stats.out
