cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  attempting to fetch a Snakemake image, rather than the help text for the Snakemake
  tool itself. As a result, no command-line arguments could be extracted from this
  input.\n\nTool homepage: https://snakemake.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake:9.16.2--hdfd78af_1
stdout: snakemake.out
