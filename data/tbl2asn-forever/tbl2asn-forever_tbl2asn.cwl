cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbl2asn
label: tbl2asn-forever_tbl2asn
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to fetch or build the container image. It does not contain
  the help text or usage information for the tool itself.\n\nTool homepage: https://www.ncbi.nlm.nih.gov/genbank/tbl2asn2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbl2asn-forever:25.7.1f--0
stdout: tbl2asn-forever_tbl2asn.out
