cwlVersion: v1.2
class: CommandLineTool
baseCommand: proalign
label: proalign
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to fetch the proalign image.\n\nTool homepage: https://github.com/alifarooq9/proalign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/proalign:v0.603-4-deb_cv1
stdout: proalign.out
