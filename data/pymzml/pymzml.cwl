cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymzml
label: pymzml
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to fetch the pymzml image.\n\nTool homepage: https://github.com/pymzml/pymzML"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymzml:2.5.11--pyhdfd78af_0
stdout: pymzml.out
