cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainFilter
label: ucsc-chainfilter
doc: "The provided text does not contain help information as it is an error log from
  a container runtime (Singularity/Apptainer). No arguments could be extracted.\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainfilter:482--h0b57e2e_0
stdout: ucsc-chainfilter.out
