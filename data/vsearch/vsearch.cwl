cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsearch
label: vsearch
doc: "The provided text does not contain help information for vsearch; it is an error
  log from a container runtime (Singularity/Apptainer) failing to fetch the vsearch
  image.\n\nTool homepage: https://github.com/torognes/vsearch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsearch:2.30.4--hd6d6fdc_0
stdout: vsearch.out
