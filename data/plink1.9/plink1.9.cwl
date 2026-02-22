cwlVersion: v1.2
class: CommandLineTool
baseCommand: plink
label: plink1.9
doc: "The provided text does not contain help documentation or usage instructions.
  It consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull a Docker image due to insufficient disk space ('no space left on
  device').\n\nTool homepage: https://github.com/cemalley/plink1.9"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/plink1.9:v1.90b3.45-170113-1-deb_cv1
stdout: plink1.9.out
