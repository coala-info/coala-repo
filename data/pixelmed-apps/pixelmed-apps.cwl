cwlVersion: v1.2
class: CommandLineTool
baseCommand: pixelmed-apps
label: pixelmed-apps
doc: The provided text does not contain help documentation for the tool. It is an
  error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build or fetch the image 'docker://biocontainers/pixelmed-apps:v20150917-1-deb_cv1'
  due to 'no space left on device'.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pixelmed-apps:v20150917-1-deb_cv1
stdout: pixelmed-apps.out
