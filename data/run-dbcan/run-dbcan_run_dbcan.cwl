cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run_dbcan
label: run-dbcan_run_dbcan
doc: "Automated Carbohydrate-active enZYme Annotation. (Note: The provided text contains
  system error logs rather than command-line help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/linnabrown/run_dbcan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/run-dbcan:2.0.11--pyh3252c3a_0
stdout: run-dbcan_run_dbcan.out
