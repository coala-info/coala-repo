cwlVersion: v1.2
class: CommandLineTool
baseCommand: skesa
label: skesa
doc: "The provided text does not contain help information for the tool 'skesa'. It
  appears to be an error log from a container runtime (Singularity/Apptainer) failing
  to fetch or build the OCI image.\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/pub/agarwala/skesa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skesa:2.5.1--h077b44d_3
stdout: skesa.out
