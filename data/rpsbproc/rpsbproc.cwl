cwlVersion: v1.2
class: CommandLineTool
baseCommand: rpsbproc
label: rpsbproc
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains error logs from a container runtime (Apptainer/Singularity)
  failing to fetch the image.\n\nTool homepage: https://ftp.ncbi.nih.gov/pub/mmdb/cdd/rpsbproc/README"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rpsbproc:0.5.1--hd6d6fdc_0
stdout: rpsbproc.out
