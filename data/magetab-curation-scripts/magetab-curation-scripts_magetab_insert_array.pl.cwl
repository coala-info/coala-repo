cwlVersion: v1.2
class: CommandLineTool
baseCommand: magetab_insert_array.pl
label: magetab-curation-scripts_magetab_insert_array.pl
doc: "A script from the magetab-curation-scripts suite, likely used for inserting
  array information into MAGE-TAB files.\n\nTool homepage: https://github.com/ebi-gene-expression-group/perl-curation-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
stdout: magetab-curation-scripts_magetab_insert_array.pl.out
