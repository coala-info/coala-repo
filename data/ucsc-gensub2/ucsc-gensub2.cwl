cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-gensub2
label: ucsc-gensub2
doc: "The provided text does not contain help information for the tool. It consists
  of container runtime logs and a fatal error message indicating a failure to fetch
  or build the OCI image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-gensub2:469--h664eb37_1
stdout: ucsc-gensub2.out
