cwlVersion: v1.2
class: CommandLineTool
baseCommand: snap
label: snap
doc: "The provided text does not contain help information or usage instructions for
  the 'snap' tool. It appears to be a log of a failed container build process (Singularity/Apptainer)
  while attempting to fetch the snap image from a container registry.\n\nTool homepage:
  https://github.com/SnapKit/SnapKit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snap:2017_03_01--h7b50bb2_0
stdout: snap.out
