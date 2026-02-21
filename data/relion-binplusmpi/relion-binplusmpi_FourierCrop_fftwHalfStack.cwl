cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion-binplusmpi_FourierCrop_fftwHalfStack
label: relion-binplusmpi_FourierCrop_fftwHalfStack
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the image.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-binplusmpi:v1.4dfsg-2b2-deb_cv1
stdout: relion-binplusmpi_FourierCrop_fftwHalfStack.out
