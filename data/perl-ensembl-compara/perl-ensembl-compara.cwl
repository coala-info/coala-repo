cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ensembl-compara
label: perl-ensembl-compara
doc: "The provided text is an error log from an Apptainer/Singularity image build
  process and does not contain help documentation or argument definitions for the
  tool.\n\nTool homepage: https://www.ensembl.org/info/docs/api/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ensembl-compara:98--0
stdout: perl-ensembl-compara.out
