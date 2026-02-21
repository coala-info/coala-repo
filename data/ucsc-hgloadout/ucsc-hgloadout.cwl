cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadOut
label: ucsc-hgloadout
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution error log (Singularity/Apptainer) indicating a failure
  to fetch or build the OCI image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadout:482--h0b57e2e_0
stdout: ucsc-hgloadout.out
