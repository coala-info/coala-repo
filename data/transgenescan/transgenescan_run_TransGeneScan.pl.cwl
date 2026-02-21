cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_TransGeneScan.pl
label: transgenescan_run_TransGeneScan.pl
doc: "TransGeneScan: a tool for gene prediction in metatranscriptomic sequences. (Note:
  The provided help text contained only execution error messages and no usage information;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/COL-IU/TransGeneScan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transgenescan:1.3.0--h7b50bb2_3
stdout: transgenescan_run_TransGeneScan.pl.out
