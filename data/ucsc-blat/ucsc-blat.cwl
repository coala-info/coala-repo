cwlVersion: v1.2
class: CommandLineTool
baseCommand: blat
label: ucsc-blat
doc: "The provided text does not contain help information for ucsc-blat; it contains
  error logs from a container runtime (Apptainer/Singularity) failing to fetch the
  tool image.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-blat:482--hdc0a859_0
stdout: ucsc-blat.out
