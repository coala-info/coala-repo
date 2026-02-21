cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ensembl-io
label: perl-ensembl-io
doc: "The provided text is an error log from a container build process (Apptainer/Singularity)
  and does not contain help documentation or usage instructions for the tool.\n\n
  Tool homepage: https://www.ensembl.org/info/docs/api/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ensembl-io:98--0
stdout: perl-ensembl-io.out
