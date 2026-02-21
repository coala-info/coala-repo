cwlVersion: v1.2
class: CommandLineTool
baseCommand: tvc
label: tvc
doc: "Torrent Variant Caller (TVC) is a genetic variant caller designed for Ion Torrent
  sequencing data.\n\nTool homepage: https://github.com/tronscan/tron-tvc-list"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tvc:v5.0.3git20151221.80e144edfsg-2-deb_cv1
stdout: tvc.out
