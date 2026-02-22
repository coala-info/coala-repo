cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioperl-run_ClustalW
label: bioperl-run_ClustalW
doc: "ClustalW is a general purpose multiple sequence alignment program for DNA or
  proteins. (Note: The provided input text contained system error messages regarding
  container execution and did not contain help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_ClustalW.out
