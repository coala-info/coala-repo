cwlVersion: v1.2
class: CommandLineTool
baseCommand: faSplit
label: ucsc-fasplit
doc: "The provided text does not contain help information for the tool. It appears
  to be a container engine error log (Singularity/Apptainer) indicating a failure
  to fetch or build the OCI image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fasplit:482--h0b57e2e_0
stdout: ucsc-fasplit.out
