cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-config-general
label: perl-config-general
doc: "The provided text contains system error messages related to a failed container
  image pull (no space left on device) rather than CLI help documentation. Consequently,
  no arguments or tool descriptions could be extracted from the text.\n\nTool homepage:
  http://metacpan.org/pod/Config-General"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-config-general:2.67--pl5321hdfd78af_0
stdout: perl-config-general.out
