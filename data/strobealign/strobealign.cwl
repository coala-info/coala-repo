cwlVersion: v1.2
class: CommandLineTool
baseCommand: strobealign
label: strobealign
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime (Apptainer/Singularity) failure.\n
  \nTool homepage: https://github.com/ksahlin/StrobeAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strobealign:0.17.0--h5ca1c30_0
stdout: strobealign.out
