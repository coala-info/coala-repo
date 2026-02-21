cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_FragGeneScan.pl
label: fraggenescan_run_FragGeneScan.pl
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build a container image due to insufficient disk space.\n
  \nTool homepage: https://sourceforge.net/projects/fraggenescan/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraggenescan:1.32--h7b50bb2_1
stdout: fraggenescan_run_FragGeneScan.pl.out
