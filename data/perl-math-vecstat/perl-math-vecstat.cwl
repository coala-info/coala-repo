cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-vecstat
label: perl-math-vecstat
doc: "The executable 'perl-math-vecstat' was not found in the system PATH. No help
  text or usage information was provided.\n\nTool homepage: https://github.com/pld-linux/perl-Math-VecStat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-math-vecstat:0.08--pl526_1
stdout: perl-math-vecstat.out
