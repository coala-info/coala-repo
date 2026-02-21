cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake-wrapper-utils
label: snakemake-wrapper-utils
doc: "The provided text appears to be a container runtime log (Apptainer/Singularity)
  reporting a fatal error during an image build process, rather than the help text
  for the tool itself. As a result, no command-line arguments, flags, or tool descriptions
  could be extracted from the input.\n\nTool homepage: https://github.com/snakemake/snakemake-wrapper-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake-wrapper-utils:0.8.0--pyhdfd78af_0
stdout: snakemake-wrapper-utils.out
