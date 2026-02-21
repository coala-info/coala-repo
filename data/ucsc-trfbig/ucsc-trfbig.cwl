cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-trfbig
label: ucsc-trfbig
doc: "The provided text does not contain help information for the tool. It consists
  of container engine (Apptainer/Singularity) log messages and a fatal error encountered
  during the image build process.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-trfbig:482--h0b57e2e_0
stdout: ucsc-trfbig.out
