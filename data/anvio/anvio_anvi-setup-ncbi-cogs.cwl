cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anvi-setup-ncbi-cogs
label: anvio_anvi-setup-ncbi-cogs
doc: "A tool to set up NCBI COG data for anvi'o. Note: The provided help text contains
  only system error logs regarding container extraction and does not list specific
  command-line arguments.\n\nTool homepage: http://merenlab.org/software/anvio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio:7--hdfd78af_1
stdout: anvio_anvi-setup-ncbi-cogs.out
