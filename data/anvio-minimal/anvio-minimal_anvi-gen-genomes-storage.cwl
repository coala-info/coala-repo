cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anvi-gen-genomes-storage
label: anvio-minimal_anvi-gen-genomes-storage
doc: "Generate an anvi'o genomes storage file.\n\nTool homepage: http://merenlab.org/software/anvio/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
stdout: anvio-minimal_anvi-gen-genomes-storage.out
