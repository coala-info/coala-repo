cwlVersion: v1.2
class: CommandLineTool
baseCommand: satsuma2_satsuma_run.sh
label: satsuma2_satsuma_run.sh
doc: "Satsuma2 synteny analysis tool (Note: The provided text contains container runtime
  error logs rather than help documentation; no arguments could be extracted).\n\n
  Tool homepage: https://github.com/bioinfologics/satsuma2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
stdout: satsuma2_satsuma_run.sh.out
