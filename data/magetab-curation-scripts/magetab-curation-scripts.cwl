cwlVersion: v1.2
class: CommandLineTool
baseCommand: magetab-curation-scripts
label: magetab-curation-scripts
doc: "MAGE-TAB curation scripts (Note: The provided text contains container execution
  errors rather than tool help text, so no arguments could be extracted).\n\nTool
  homepage: https://github.com/ebi-gene-expression-group/perl-curation-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magetab-curation-scripts:1.1.0--hdfd78af_0
stdout: magetab-curation-scripts.out
