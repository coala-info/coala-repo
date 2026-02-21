cwlVersion: v1.2
class: CommandLineTool
baseCommand: beamspy
label: beamspy
doc: "The provided text does not contain help information or usage instructions for
  beamspy. It appears to be a log of a failed container build/extraction process (Apptainer/Singularity)
  due to insufficient disk space.\n\nTool homepage: https://github.com/computational-metabolomics/beamspy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beamspy:1.2.0--pyhdfd78af_0
stdout: beamspy.out
