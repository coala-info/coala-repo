cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-datetime-timezone
label: perl-datetime-timezone
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull an image due to insufficient disk space.\n\nTool homepage: https://metacpan.org/release/DateTime-TimeZone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-datetime-timezone:2.66--pl5321h9948957_0
stdout: perl-datetime-timezone.out
