cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-spec
label: perl-file-spec
doc: "The provided text does not contain help information or documentation for the
  tool. It is an error log indicating that the executable 'perl-file-spec' was not
  found in the system PATH during a container build process.\n\nTool homepage: https://github.com/davorg-cpan/parse-rpm-spec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-spec:3.48_01--pl5.22.0_0
stdout: perl-file-spec.out
