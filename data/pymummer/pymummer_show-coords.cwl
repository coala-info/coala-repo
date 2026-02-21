cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymummer_show-coords
label: pymummer_show-coords
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Singularity/Apptainer) failing
  to fetch the OCI image.\n\nTool homepage: https://github.com/sanger-pathogens/pymummer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymummer:0.12.0--pyhdfd78af_0
stdout: pymummer_show-coords.out
