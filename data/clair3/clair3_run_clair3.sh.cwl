cwlVersion: v1.2
class: CommandLineTool
baseCommand: clair3_run_clair3.sh
label: clair3_run_clair3.sh
doc: "Clair3 is a germline variant caller for long-read sequencing data. (Note: The
  provided text appears to be a container execution log reporting a 'no space left
  on device' error rather than the tool's help documentation; therefore, no arguments
  could be extracted from the input.)\n\nTool homepage: https://github.com/HKU-BAL/Clair3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair3:1.2.0--py310h779eee5_0
stdout: clair3_run_clair3.sh.out
