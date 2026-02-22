cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sub-exporter-formethods
label: perl-sub-exporter-formethods
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a Singularity/Apptainer
  container build failure due to insufficient disk space.\n\nTool homepage: https://github.com/rjbs/Sub-Exporter-ForMethods"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-sub-exporter-formethods:0.100055--pl5321hdfd78af_0
stdout: perl-sub-exporter-formethods.out
