cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-leaktrace
label: perl-test-leaktrace
doc: "The provided text is an error log reporting a 'no space left on device' failure
  during a Singularity container build and does not contain CLI help information or
  usage instructions for the tool.\n\nTool homepage: http://metacpan.org/pod/Test-LeakTrace"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-leaktrace:0.17--pl5321hec16e2b_1
stdout: perl-test-leaktrace.out
