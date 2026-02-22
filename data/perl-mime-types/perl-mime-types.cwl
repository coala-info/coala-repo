cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mime-types
label: perl-mime-types
doc: "The provided text contains system error messages related to a container runtime
  failure (no space left on device) and does not contain the actual help text or usage
  instructions for the tool. As a result, no arguments could be extracted.\n\nTool
  homepage: http://metacpan.org/pod/MIME-Types"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-mime-types:2.30--pl5321hdfd78af_0
stdout: perl-mime-types.out
