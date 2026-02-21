cwlVersion: v1.2
class: CommandLineTool
baseCommand: yamda
label: yamda
doc: "The provided text does not contain help information or a description for the
  tool 'yamda'. It appears to be a log of a failed container build process (Singularity/Apptainer)
  while attempting to fetch the tool's image.\n\nTool homepage: https://github.com/daquang/YAMDA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yamda:0.1.00e9c9d--py_0
stdout: yamda.out
