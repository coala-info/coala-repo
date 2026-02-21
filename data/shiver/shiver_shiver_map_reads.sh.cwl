cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiver_shiver_map_reads.sh
label: shiver_shiver_map_reads.sh
doc: "Map reads using the shiver pipeline (Note: The provided text contains execution
  logs and error messages rather than help documentation; therefore, no arguments
  could be extracted).\n\nTool homepage: https://github.com/ChrisHIV/shiver"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiver:1.7.3--hdfd78af_0
stdout: shiver_shiver_map_reads.sh.out
