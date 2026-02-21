cwlVersion: v1.2
class: CommandLineTool
baseCommand: catfasta2phyml.pl
label: catfasta2phyml_catfasta2phyml.pl
doc: "A tool for concatenating FASTA alignments (Note: The provided help text contains
  only system error messages regarding container extraction and does not list tool-specific
  usage or arguments).\n\nTool homepage: https://github.com/nylander/catfasta2phyml"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/catfasta2phyml:1.2.1--hdfd78af_0
stdout: catfasta2phyml_catfasta2phyml.pl.out
