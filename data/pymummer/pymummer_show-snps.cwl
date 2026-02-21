cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymummer_show-snps
label: pymummer_show-snps
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the image.\n\nTool homepage: https://github.com/sanger-pathogens/pymummer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymummer:0.12.0--pyhdfd78af_0
stdout: pymummer_show-snps.out
