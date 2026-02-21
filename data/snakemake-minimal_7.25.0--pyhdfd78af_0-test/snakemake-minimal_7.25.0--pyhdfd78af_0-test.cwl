cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakemake
label: snakemake-minimal_7.25.0--pyhdfd78af_0-test
doc: "Snakemake is a workflow management system that aims to reduce the complexity
  of creating workflows by providing a fast and flexible execution environment. (Note:
  The provided text appears to be an error log from a container build process rather
  than a CLI help message, so no arguments could be extracted.)\n\nTool homepage:
  https://snakemake.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakemake:9.16.2--hdfd78af_1
stdout: snakemake-minimal_7.25.0--pyhdfd78af_0-test.out
