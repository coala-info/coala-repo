cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfish
label: pyfish
doc: "The provided text does not contain help information or usage instructions for
  the tool 'pyfish'. It appears to be a log of a failed container build or execution
  attempt.\n\nTool homepage: https://bitbucket.org/schwarzlab/pyfish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfish:1.0.3--pyh7cba7a3_0
stdout: pyfish.out
