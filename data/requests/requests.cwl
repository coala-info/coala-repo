cwlVersion: v1.2
class: CommandLineTool
baseCommand: requests
label: requests
doc: "The provided text appears to be a build log from a container engine (Apptainer/Singularity)
  rather than CLI help text. No command-line arguments, flags, or usage instructions
  were found in the input.\n\nTool homepage: https://github.com/psf/requests"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/requests:2.26.0
stdout: requests.out
