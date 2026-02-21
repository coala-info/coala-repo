cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-spline
label: perl-math-spline
doc: "The executable 'perl-math-spline' was not found in the system path. No help
  text was available to parse.\n\nTool homepage: https://github.com/pld-linux/perl-Math-Spline"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-math-spline:0.02--pl526_2
stdout: perl-math-spline.out
