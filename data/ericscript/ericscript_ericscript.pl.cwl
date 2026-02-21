cwlVersion: v1.2
class: CommandLineTool
baseCommand: ericscript.pl
label: ericscript_ericscript.pl
doc: "EricScript is a computational pipeline for the identification of gene fusion
  events from RNA-seq data.\n\nTool homepage: https://github.com/databio/ericscript"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ericscript:0.5.5--pl5.22.0r3.3.2_1
stdout: ericscript_ericscript.pl.out
