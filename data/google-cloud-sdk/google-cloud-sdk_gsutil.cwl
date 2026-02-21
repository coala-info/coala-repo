cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsutil
label: google-cloud-sdk_gsutil
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a set of system logs and a fatal error message regarding a container
  runtime (Singularity/Apptainer) failure due to lack of disk space.\n\nTool homepage:
  https://cloud.google.com/sdk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
stdout: google-cloud-sdk_gsutil.out
