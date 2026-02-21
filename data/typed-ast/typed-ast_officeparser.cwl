cwlVersion: v1.2
class: CommandLineTool
baseCommand: typed-ast_officeparser
label: typed-ast_officeparser
doc: "The provided text appears to be a system error log from a container build process
  (Apptainer/Singularity) rather than CLI help documentation. As a result, no specific
  command-line arguments, flags, or options could be extracted from the text.\n\n
  Tool homepage: https://github.com/harshankur/officeParser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/typed-ast:v1.3.1-1-deb-py3_cv1
stdout: typed-ast_officeparser.out
