cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-eval-closure
label: perl-eval-closure
doc: "The provided text appears to be a system error log from a container build process
  (Apptainer/Singularity) rather than help text for the tool itself. No command-line
  arguments or usage instructions were found in the text.\n\nTool homepage: https://github.com/pld-linux/perl-Eval-Closure"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-eval-closure:0.14--pl526_1
stdout: perl-eval-closure.out
