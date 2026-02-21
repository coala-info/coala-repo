cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbl2asn
label: tbl2asn
doc: "The provided text does not contain help information for the tool. It consists
  of container runtime (Singularity/Apptainer) log messages and a fatal error regarding
  an OCI image fetch failure.\n\nTool homepage: https://www.ncbi.nlm.nih.gov/genbank/tbl2asn2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbl2asn:25.8--0
stdout: tbl2asn.out
