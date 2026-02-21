cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-localtime_gmtime
label: ucsc-localtime_gmtime
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to fetch
  or build the OCI image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-localtime:482--h0b57e2e_0
stdout: ucsc-localtime_gmtime.out
