cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxmapper_plot
label: taxmapper_plot
doc: "Plotting tool for taxonomic data.\n\nTool homepage: https://bitbucket.org/dbeisser/taxmapper"
inputs:
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional sample names, sample names have to be in the same order as 
      taxonomy input files. If no samplenames are provided, the base names of 
      the taxa file(s) will be used.
    inputBinding:
      position: 101
      prefix: --samples
  - id: taxa
    type:
      type: array
      items: File
    doc: Taxonomy file(s), counted taxa for a taxonomic hierarchy
    inputBinding:
      position: 101
      prefix: --taxa
outputs:
  - id: freq
    type:
      - 'null'
      - File
    doc: Output file 1, taxon matrix with normalized frequencies
    outputBinding:
      glob: $(inputs.freq)
  - id: counts
    type:
      - 'null'
      - File
    doc: Output file 2, taxon matrix with counts
    outputBinding:
      glob: $(inputs.counts)
  - id: plot
    type:
      - 'null'
      - File
    doc: Output file 3, stacked barplot of total count normalized taxa
    outputBinding:
      glob: $(inputs.plot)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxmapper:1.0.2--py36_0
