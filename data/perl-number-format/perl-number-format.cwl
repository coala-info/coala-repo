cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-number-format
label: perl-number-format
doc: "The provided text contains system error messages (Singularity/OCI conversion
  errors) rather than the command-line help documentation for the tool. As a result,
  no arguments or functional descriptions could be extracted.\n\nTool homepage: http://metacpan.org/pod/Number::Format"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-number-format:1.76--pl5321hdfd78af_0
stdout: perl-number-format.out
