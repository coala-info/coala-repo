cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pod-plaintext
label: perl-pod-plaintext
doc: The tool 'perl-pod-plaintext' could not be executed, and no help text was provided
  in the input. The output indicates a fatal error where the executable was not found
  in the system PATH.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pod-plaintext:2.07--pl526_1
stdout: perl-pod-plaintext.out
