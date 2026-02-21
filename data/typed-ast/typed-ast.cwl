cwlVersion: v1.2
class: CommandLineTool
baseCommand: typed-ast
label: typed-ast
doc: "The provided text does not contain help information or usage instructions for
  the tool 'typed-ast'. It appears to be an error log from a container build process
  (Apptainer/Singularity) that failed due to insufficient disk space.\n\nTool homepage:
  https://github.com/harshankur/officeParser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/typed-ast:v1.3.1-1-deb-py3_cv1
stdout: typed-ast.out
