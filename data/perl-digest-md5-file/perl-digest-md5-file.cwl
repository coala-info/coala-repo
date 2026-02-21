cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-digest-md5-file
label: perl-digest-md5-file
doc: "A tool for calculating MD5 digests of files (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: http://search.cpan.org/dist/Digest-MD5-File/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-digest-md5-file:0.08--pl5.22.0_0
stdout: perl-digest-md5-file.out
