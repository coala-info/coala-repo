cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapsnp
label: soapsnp
doc: "The provided text does not contain help information for soapsnp; it is a system
  error log from a container runtime (Apptainer/Singularity) failing to fetch the
  image.\n\nTool homepage: https://github.com/zzhangjii/soapsnp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/soapsnp:v1.03-3-deb_cv1
stdout: soapsnp.out
