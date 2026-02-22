cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioperl-run_TigrAssembler
label: bioperl-run_TigrAssembler
doc: "A BioPerl-run wrapper for the TIGR Assembler. Note: The provided input text
  contains system error messages regarding disk space and container execution rather
  than the tool's help documentation.\n\nTool homepage: https://github.com/bioperl/bioperl-run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl-run:v1.7.2-4-deb_cv1
stdout: bioperl-run_TigrAssembler.out
