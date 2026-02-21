cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraFetch
label: ucsc-paranode_paraFetch
doc: "The provided text does not contain help information for the tool. It contains
  container engine logs (Singularity/Apptainer) indicating a failure to fetch or build
  the container image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranode:482--h0b57e2e_0
stdout: ucsc-paranode_paraFetch.out
