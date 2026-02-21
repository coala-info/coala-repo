cwlVersion: v1.2
class: CommandLineTool
baseCommand: magetab-curation-scripts_comment_out_assays.pl
label: magetab-curation-scripts_comment_out_assays.pl
doc: "A script from the magetab-curation-scripts suite, likely used to comment out
  assay entries in MAGE-TAB files. Note: The provided help text contains only container
  runtime error messages and no usage information.\n\nTool homepage: https://github.com/ebi-gene-expression-group/perl-curation-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
stdout: magetab-curation-scripts_comment_out_assays.pl.out
