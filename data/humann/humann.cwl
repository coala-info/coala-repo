cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann
label: humann
doc: "The HMP Unified Metabolic Analysis Network (HUMAnN) is a pipeline for efficiently
  and accurately profiling the presence/absence and abundance of microbial pathways
  in a community from metagenomic or metatranscriptomic sequencing data.\n\nTool homepage:
  http://huttenhower.sph.harvard.edu/humann"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
stdout: humann.out
