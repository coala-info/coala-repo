cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-json-create
label: perl-json-create
doc: "The provided text does not contain help documentation for the tool. It consists
  of system error messages related to a Singularity/Apptainer container build failure
  due to insufficient disk space.\n\nTool homepage: https://metacpan.org/pod/distribution/JSON-Create/lib/JSON/Create.pod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-json-create:0.35--pl5321h7b50bb2_5
stdout: perl-json-create.out
