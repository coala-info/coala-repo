cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-params-util
label: perl-params-util
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a Singularity/Apptainer container build failure
  due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/Params::Util"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-params-util:1.102--pl5321h9f5acd7_1
stdout: perl-params-util.out
