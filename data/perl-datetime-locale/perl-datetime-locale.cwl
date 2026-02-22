cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-datetime-locale
label: perl-datetime-locale
doc: "The provided text does not contain help documentation for the tool. It contains
  system error messages related to a failed Singularity/Apptainer container build
  due to insufficient disk space ('no space left on device').\n\nTool homepage: http://metacpan.org/release/DateTime-Locale"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-datetime-locale:1.45--pl5321h9948957_1
stdout: perl-datetime-locale.out
