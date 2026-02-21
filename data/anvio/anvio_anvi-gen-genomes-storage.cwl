cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anvi-gen-genomes-storage
label: anvio_anvi-gen-genomes-storage
doc: "Generate a genomes storage database for anvi'o.\n\nTool homepage: http://merenlab.org/software/anvio/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio:7--hdfd78af_1
stdout: anvio_anvi-gen-genomes-storage.out
