cwlVersion: v1.2
class: CommandLineTool
baseCommand: requests-mock
label: requests-mock
doc: "The provided text does not contain help information or usage instructions for
  the tool 'requests-mock'. It appears to be a log from a failed container build process
  (Apptainer/Singularity).\n\nTool homepage: https://github.com/getsentry/responses"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/requests-mock:1.0.0--py27_1
stdout: requests-mock.out
