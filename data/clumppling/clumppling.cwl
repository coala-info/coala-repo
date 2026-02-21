cwlVersion: v1.2
class: CommandLineTool
baseCommand: clumppling
label: clumppling
doc: "The provided text does not contain help information for the tool 'clumppling'.
  It appears to be an error log from a container runtime (Singularity/Apptainer) indicating
  a failure to build or extract the OCI image due to lack of disk space ('no space
  left on device').\n\nTool homepage: https://pypi.org/project/clumppling"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clumppling:2.0.6--pyhdfd78af_0
stdout: clumppling.out
