cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-exec
label: perl-test-exec
doc: "The provided text does not contain help documentation. It consists of Apptainer/Singularity
  build logs and a fatal error indicating that the executable 'perl-test-exec' was
  not found in the system PATH.\n\nTool homepage: https://metacpan.org/pod/Test::Exec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-exec:0.04--pl526_0
stdout: perl-test-exec.out
