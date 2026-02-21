cwlVersion: v1.2
class: CommandLineTool
baseCommand: sloika
label: sloika
doc: "The provided text does not contain help information or usage instructions for
  the tool 'sloika'. It appears to be a log from a failed container build process
  (Singularity/Apptainer).\n\nTool homepage: https://github.com/nanoporetech/sloika"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sloika:2.0.1--np112_0
stdout: sloika.out
