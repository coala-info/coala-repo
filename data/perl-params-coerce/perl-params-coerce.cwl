cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-params-coerce
label: perl-params-coerce
doc: "The executable 'perl-params-coerce' was not found in the environment, and no
  help text was provided.\n\nTool homepage: http://metacpan.org/pod/Params::Coerce"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-params-coerce:0.14--pl526_1
stdout: perl-params-coerce.out
