cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioperl-run_Minimo
label: bioperl-run_Minimo
doc: "BioPerl wrapper for the Minimo assembler. (Note: The provided input text contains
  system error messages regarding container execution and disk space, rather than
  the tool's help documentation. No arguments could be extracted.)\n\nTool homepage:
  https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_Minimo.out
