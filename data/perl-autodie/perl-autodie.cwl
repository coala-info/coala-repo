cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-autodie
label: perl-autodie
doc: "The autodie pragma provides a way to replace functions that normally return
  false on failure with ones that throw an exception.\n\nTool homepage: http://metacpan.org/pod/autodie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-autodie:2.37--pl5321hdfd78af_0
stdout: perl-autodie.out
