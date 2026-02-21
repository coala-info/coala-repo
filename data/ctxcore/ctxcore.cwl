cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctxcore
label: ctxcore
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log output from a failed container build process (Apptainer/Singularity)
  indicating a 'no space left on device' error during the extraction of the ctxcore
  OCI image.\n\nTool homepage: https://scenic.aertslab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctxcore:0.2.0--pyh7e72e81_1
stdout: ctxcore.out
