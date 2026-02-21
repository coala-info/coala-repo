cwlVersion: v1.2
class: CommandLineTool
baseCommand: bbmerge-auto.sh
label: bbmap_bbmerge_auto
doc: "BBMerge merges paired-end reads into single reads by identifying overlap. (Note:
  The provided help text resulted in a runtime error and did not list specific arguments).\n
  \nTool homepage: https://sourceforge.net/projects/bbmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
stdout: bbmap_bbmerge_auto.out
