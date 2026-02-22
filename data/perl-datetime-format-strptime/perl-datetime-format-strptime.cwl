cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-datetime-format-strptime
label: perl-datetime-format-strptime
doc: "The provided text does not contain help documentation for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull or build an image due to insufficient disk space.\n\nTool homepage: https://metacpan.org/dist/DateTime-Format-Strptime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-datetime-format-strptime:1.80--pl5321hdfd78af_0
stdout: perl-datetime-format-strptime.out
