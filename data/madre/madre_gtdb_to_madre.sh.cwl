cwlVersion: v1.2
class: CommandLineTool
baseCommand: madre_gtdb_to_madre.sh
label: madre_gtdb_to_madre.sh
doc: "A script to convert GTDB (Genome Taxonomy Database) data to MADRE format. (Note:
  The provided help text contains only system error logs and does not list specific
  command-line arguments).\n\nTool homepage: https://github.com/lbcb-sci/MADRe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/madre:0.0.5--pyhdfd78af_0
stdout: madre_gtdb_to_madre.sh.out
