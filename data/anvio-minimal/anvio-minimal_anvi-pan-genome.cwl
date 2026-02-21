cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anvi-pan-genome
label: anvio-minimal_anvi-pan-genome
doc: "The provided text does not contain help documentation. It is an error log indicating
  a failure to build or extract the container image due to insufficient disk space
  ('no space left on device').\n\nTool homepage: http://merenlab.org/software/anvio/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anvio-minimal:9--pyhdfd78af_0
stdout: anvio-minimal_anvi-pan-genome.out
