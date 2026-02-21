cwlVersion: v1.2
class: CommandLineTool
baseCommand: syny_run_syny.pl
label: syny_run_syny.pl
doc: "Synteny analysis tool (Note: The provided text contains container build logs
  and error messages rather than the tool's help documentation, so arguments could
  not be extracted).\n\nTool homepage: https://github.com/PombertLab/SYNY"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/syny:1.3.1--py312pl5321h7e72e81_0
stdout: syny_run_syny.pl.out
