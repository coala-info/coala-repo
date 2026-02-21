cwlVersion: v1.2
class: CommandLineTool
baseCommand: magetab-curation-scripts_gal2adf.pl
label: magetab-curation-scripts_gal2adf.pl
doc: "A script for converting GAL (Gene Array List) files to ADF (Array Design Format).
  Note: The provided text contains system error messages regarding container execution
  and does not include specific usage instructions or argument definitions.\n\nTool
  homepage: https://github.com/ebi-gene-expression-group/perl-curation-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
stdout: magetab-curation-scripts_gal2adf.pl.out
