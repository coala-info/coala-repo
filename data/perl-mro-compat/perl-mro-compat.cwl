cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mro-compat
label: perl-mro-compat
doc: "MRO::Compat - mro compatibility methods (Note: The provided text is an error
  log indicating a 'no space left on device' failure during a container build and
  does not contain actual CLI help documentation.)\n\nTool homepage: https://metacpan.org/release/MRO-Compat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-mro-compat:0.15--pl5321hdfd78af_0
stdout: perl-mro-compat.out
