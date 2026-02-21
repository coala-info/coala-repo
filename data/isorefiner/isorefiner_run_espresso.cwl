cwlVersion: v1.2
class: CommandLineTool
baseCommand: isorefiner_run_espresso
label: isorefiner_run_espresso
doc: "A tool within the IsoRefiner suite, likely used to run the ESPRESSO (Error-tolerant
  Shifting of Post-transcriptional Site Selection Outputs) pipeline.\n\nTool homepage:
  https://github.com/rkajitani/IsoRefiner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
stdout: isorefiner_run_espresso.out
