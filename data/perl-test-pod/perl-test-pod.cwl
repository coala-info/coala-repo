cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-pod
label: perl-test-pod
doc: "A tool to check for POD (Plain Old Documentation) errors in Perl files.\n\n
  Tool homepage: http://search.cpan.org/dist/Test-Pod/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-pod:1.52--pl526_0
stdout: perl-test-pod.out
