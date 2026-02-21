cwlVersion: v1.2
class: CommandLineTool
baseCommand: domalign
label: embassy-domalign
doc: The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to build an image due to lack of disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/embassy-domalign:v0.1.660-3-deb_cv1
stdout: embassy-domalign.out
