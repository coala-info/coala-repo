cwlVersion: v1.2
class: CommandLineTool
baseCommand: samsum
label: samsum
doc: "The provided text does not contain help information or usage instructions for
  the tool 'samsum'. It is an error log from a container build process (Apptainer/Singularity)
  that failed to fetch the OCI image.\n\nTool homepage: https://github.com/hallamlab/samsum"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsum:0.1.4--py39h918f1d6_7
stdout: samsum.out
