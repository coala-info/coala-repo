cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capC-MAP
  - getchromsizes
label: capc-map_getchromsizes
doc: "Generate a chrom.sizes file from a list of restriction enzyme fragments.\n\nTool homepage: https://capc-map.readthedocs.io/"
inputs:
  - id: fragments_file
    type: File
    doc: "bed file containing list of restriction enzyme fragments for genome"
    inputBinding:
      position: 1
      prefix: -f
  - id: outfile
    type:
      - 'null'
      - string
    default: chrom.sizes
    doc: "output file name (Default: chrom.sizes)"
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: chrom_sizes
    type: File
    doc: "chromosome sizes file"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
