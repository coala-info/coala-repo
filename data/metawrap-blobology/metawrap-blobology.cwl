cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - blobology
label: metawrap-blobology
doc: "The blobology module of metaWRAP, used for visualizing the GC content and abundance
  of contigs (blobplots) to assist in binning and quality control of metagenomic assemblies.\n
  \nTool homepage: https://github.com/bxlab/metaWRAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap-blobology:1.3.0--hdfd78af_3
stdout: metawrap-blobology.out
