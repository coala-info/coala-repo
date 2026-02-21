cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-cg-pipeline
label: perl-cg-pipeline
doc: "The provided text does not contain help documentation for the tool. It appears
  to be a system log indicating that the executable 'perl-cg-pipeline' was not found
  in the environment's PATH.\n\nTool homepage: https://github.com/lskatz/CG-Pipeline"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-cg-pipeline:0.5--pl526_0
stdout: perl-cg-pipeline.out
