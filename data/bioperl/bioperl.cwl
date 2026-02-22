cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioperl
label: bioperl
doc: "BioPerl is a collection of Perl modules for bioinformatics. (Note: The provided
  text is a system error log regarding container execution and does not contain command-line
  help information.)\n\nTool homepage: https://github.com/bioperl/bioperl-live"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bioperl:v1.7.2-3-deb_cv1
stdout: bioperl.out
