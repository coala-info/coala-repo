cwlVersion: v1.2
class: CommandLineTool
baseCommand: varifier
label: varifier
doc: "The provided text does not contain help information or usage instructions for
  the tool 'varifier'. It appears to be a fatal error log from a container runtime
  (Singularity/Apptainer) failing to fetch the OCI image.\n\nTool homepage: https://github.com/iqbal-lab-org/varifier"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varifier:0.4.0--pyhdfd78af_0
stdout: varifier.out
