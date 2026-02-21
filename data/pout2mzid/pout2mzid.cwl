cwlVersion: v1.2
class: CommandLineTool
baseCommand: pout2mzid
label: pout2mzid
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container runtime (Apptainer/Singularity) attempting to
  pull the pout2mzid image.\n\nTool homepage: https://github.com/percolator/pout2mzid"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pout2mzid:0.3.03--boost1.62_2
stdout: pout2mzid.out
