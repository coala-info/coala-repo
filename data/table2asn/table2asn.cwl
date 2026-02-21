cwlVersion: v1.2
class: CommandLineTool
baseCommand: table2asn
label: table2asn
doc: "The provided text does not contain help information; it is a fatal error log
  from a container runtime (Singularity/Apptainer) indicating a failure to fetch the
  image.\n\nTool homepage: https://www.ncbi.nlm.nih.gov/genbank/table2asn/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/table2asn:1.28.1179--he45da00_1
stdout: table2asn.out
