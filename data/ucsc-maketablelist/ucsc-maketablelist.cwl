cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-maketablelist
label: ucsc-maketablelist
doc: "The provided text does not contain help information for the tool. It contains
  a fatal error message indicating a failure to fetch or build the container image
  (Singularity/Apptainer).\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maketablelist:482--h0b57e2e_0
stdout: ucsc-maketablelist.out
