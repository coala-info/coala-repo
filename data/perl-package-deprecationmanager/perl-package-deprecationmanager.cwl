cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-package-deprecationmanager
label: perl-package-deprecationmanager
doc: "Manage deprecation warnings for Perl packages\n\nTool homepage: http://metacpan.org/release/Package-DeprecationManager"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-package-deprecationmanager:0.17--pl526_0
stdout: perl-package-deprecationmanager.out
