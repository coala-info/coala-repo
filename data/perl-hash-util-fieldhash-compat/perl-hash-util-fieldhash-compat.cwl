cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-hash-util-fieldhash-compat
label: perl-hash-util-fieldhash-compat
doc: "A Perl module providing a compatibility layer for Hash::Util::FieldHash.\n\n
  Tool homepage: https://github.com/karenetheridge/Hash-Util-FieldHash-Compat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-hash-util-fieldhash-compat:0.11--0
stdout: perl-hash-util-fieldhash-compat.out
