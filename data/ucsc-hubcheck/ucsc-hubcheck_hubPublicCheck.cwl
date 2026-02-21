cwlVersion: v1.2
class: CommandLineTool
baseCommand: hubPublicCheck
label: ucsc-hubcheck_hubPublicCheck
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the OCI image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hubcheck:482--h0b57e2e_0
stdout: ucsc-hubcheck_hubPublicCheck.out
