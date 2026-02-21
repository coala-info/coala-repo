cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-statistics-r_perldl
label: perl-statistics-r_perldl
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is an error log indicating a failure to build a Singularity/Apptainer
  container due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/PDLPorters/PDL-Stats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-statistics-r:0.34--pl5321r44hdfd78af_7
stdout: perl-statistics-r_perldl.out
