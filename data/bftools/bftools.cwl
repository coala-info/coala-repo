cwlVersion: v1.2
class: CommandLineTool
baseCommand: bftools
label: bftools
doc: "Bio-Formats command line tools (Note: The provided text is an error log and
  does not contain help information).\n\nTool homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bftools:8.0.0--hdfd78af_0
stdout: bftools.out
