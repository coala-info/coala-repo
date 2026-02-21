cwlVersion: v1.2
class: CommandLineTool
baseCommand: anvi-migrate
label: anvio_anvi-migrate
doc: "Migrate anvi'o databases from an older version to the current version. (Note:
  The provided help text contains only system error messages regarding a failed container
  build and does not list specific command-line arguments.)\n\nTool homepage: http://merenlab.org/software/anvio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio:7--hdfd78af_1
stdout: anvio_anvi-migrate.out
