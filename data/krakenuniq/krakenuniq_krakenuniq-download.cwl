cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenuniq-download
label: krakenuniq_krakenuniq-download
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Singularity/Apptainer) failing to
  pull a Docker image due to insufficient disk space.\n\nTool homepage: https://github.com/fbreitwieser/krakenuniq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
stdout: krakenuniq_krakenuniq-download.out
