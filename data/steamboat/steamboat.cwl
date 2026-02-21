cwlVersion: v1.2
class: CommandLineTool
baseCommand: steamboat
label: steamboat
doc: "The provided text does not contain help information or a description for the
  tool 'steamboat'. It appears to be a log of a failed container build process.\n\n
  Tool homepage: https://github.com/rpetit3/steamboat-py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/steamboat:1.1.1--pyhdfd78af_0
stdout: steamboat.out
