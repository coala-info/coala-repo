cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbl2asn-forever
label: tbl2asn-forever
doc: "The provided text does not contain help information or usage instructions; it
  consists of container runtime (Apptainer/Singularity) log messages and a fatal error
  regarding image retrieval.\n\nTool homepage: https://www.ncbi.nlm.nih.gov/genbank/tbl2asn2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbl2asn-forever:25.7.1f--0
stdout: tbl2asn-forever.out
