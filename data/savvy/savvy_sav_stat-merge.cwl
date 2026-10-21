cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sav
  - stat-merge
label: savvy_sav_stat-merge
doc: "Merges output from multiple calls to stat\n\nTool homepage: https://github.com/statgen/savvy"
inputs:
  - id: input_tsvs
    type:
      type: array
      items: File
    doc: Output files of sav stat to merge (at least two)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Merged statistics
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
stdout: savvy_sav_stat-merge.out
