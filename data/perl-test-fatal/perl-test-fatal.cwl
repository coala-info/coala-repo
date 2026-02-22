cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-fatal
label: perl-test-fatal
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  indicating a failure to pull or convert the OCI image due to insufficient disk space.
  It does not contain help text or command-line argument definitions.\n\nTool homepage:
  https://github.com/rjbs/Test-Fatal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-fatal:0.016--pl5321hdfd78af_0
stdout: perl-test-fatal.out
