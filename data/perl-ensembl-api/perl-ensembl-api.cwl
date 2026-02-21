cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ensembl-api
label: perl-ensembl-api
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or extract the tool's image due to insufficient disk
  space ('no space left on device'). It does not contain CLI help text or argument
  definitions.\n\nTool homepage: https://www.ensembl.org/info/docs/api/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ensembl-api:98--0
stdout: perl-ensembl-api.out
