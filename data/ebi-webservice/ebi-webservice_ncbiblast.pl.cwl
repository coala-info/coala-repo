cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebi-webservice_ncbiblast.pl
label: ebi-webservice_ncbiblast.pl
doc: "NCBI BLAST search via EBI Web Services. (Note: The provided help text contains
  only system error messages regarding container execution and disk space, and does
  not list any command-line arguments.)\n\nTool homepage: https://github.com/ebi-jdispatcher/webservice-clients"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ebi-webservice:v1.0.0_cv1
stdout: ebi-webservice_ncbiblast.pl.out
