cwlVersion: v1.2
class: CommandLineTool
baseCommand: quickmirseq_create_database_util.sh
label: quickmirseq_create_database_util.sh
doc: "A utility script for creating databases for QuickMIRSeq. (Note: The provided
  text contains container runtime logs and error messages rather than tool help text;
  no arguments could be extracted.)\n\nTool homepage: https://sourceforge.net/projects/quickmirseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quickmirseq:1.0.0--hdfd78af_3
stdout: quickmirseq_create_database_util.sh.out
