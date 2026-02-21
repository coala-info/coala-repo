cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnasnp
label: rnasnp
doc: "The provided text does not contain help information for the tool; it is a fatal
  error log from a container runtime (Singularity/Apptainer) failing to fetch the
  rnasnp image.\n\nTool homepage: https://github.com/chunjie-sam-liu/miRNASNP-v3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnasnp:1.2--h503566f_10
stdout: rnasnp.out
