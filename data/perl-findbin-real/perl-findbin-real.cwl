cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-findbin-real
label: perl-findbin-real
doc: "FindBin::Real - Locate the real directory of the script being executed.\n\n\
  Tool homepage: https://metacpan.org/pod/FindBin::Real"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-findbin-real:1.05--pl5321h05cac1d_2
stdout: perl-findbin-real.out
