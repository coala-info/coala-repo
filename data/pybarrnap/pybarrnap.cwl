cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybarrnap
label: pybarrnap
doc: "The provided text does not contain help information or usage instructions for
  pybarrnap. It appears to be a fatal error log from a container runtime (Singularity/Apptainer)
  during an image build process.\n\nTool homepage: https://github.com/moshi4/pybarrnap/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybarrnap:0.5.1--pyhdfd78af_0
stdout: pybarrnap.out
