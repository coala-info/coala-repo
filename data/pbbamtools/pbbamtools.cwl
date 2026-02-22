cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbbamtools
label: pbbamtools
doc: The provided text does not contain help information or usage instructions 
  for pbbamtools. It contains system error messages related to a container 
  runtime (Singularity/Apptainer) failing to pull an image due to insufficient 
  disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pbbamtools:v0.19.0dfsg-4-deb_cv1
stdout: pbbamtools.out
