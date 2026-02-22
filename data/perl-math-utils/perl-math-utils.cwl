cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-utils
label: perl-math-utils
doc: "The provided text does not contain help information or usage instructions; it
  contains system error messages regarding container image retrieval and storage issues.\n\
  \nTool homepage: http://metacpan.org/pod/Math::Utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-math-utils:1.14--pl5321hdfd78af_0
stdout: perl-math-utils.out
