cwlVersion: v1.2
class: CommandLineTool
baseCommand: t1k
label: t1k
doc: "The provided text does not contain help information or usage instructions for
  the tool 't1k'. It consists of log messages from a container runtime (Singularity/Apptainer)
  reporting a fatal error during an image build process.\n\nTool homepage: https://github.com/mourisl/T1K"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/t1k:1.0.9--h5ca1c30_0
stdout: t1k.out
