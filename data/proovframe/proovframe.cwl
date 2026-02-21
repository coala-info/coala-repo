cwlVersion: v1.2
class: CommandLineTool
baseCommand: proovframe
label: proovframe
doc: "The provided text does not contain help information for proovframe; it is an
  error log from a container runtime (Singularity/Apptainer) failing to fetch the
  image.\n\nTool homepage: https://github.com/thackl/proovframe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proovframe:0.9.7--hdfd78af_1
stdout: proovframe.out
