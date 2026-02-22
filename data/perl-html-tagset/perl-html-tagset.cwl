cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-html-tagset
label: perl-html-tagset
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a 'no space left on device' failure
  during a container image pull/conversion process.\n\nTool homepage: https://metacpan.org/pod/HTML::Tagset"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-html-tagset:3.24--pl5321hdfd78af_0
stdout: perl-html-tagset.out
