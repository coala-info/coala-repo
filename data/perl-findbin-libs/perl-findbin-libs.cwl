cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-findbin-libs
label: perl-findbin-libs
doc: "A Perl utility related to FindBin::libs; however, the provided text contains
  only execution logs and an error indicating the executable was not found in the
  environment.\n\nTool homepage: http://metacpan.org/pod/FindBin::libs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-findbin-libs:2.017008--0
stdout: perl-findbin-libs.out
