cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capCpair2bg
label: capc-map_capCpair2bg
doc: "Pile up a capture valid pairs file into a bedGraph of reporter counts for a target.\n\nTool homepage: https://capc-map.readthedocs.io/"
inputs:
  - id: pairsfile
    type:
      type: array
      items: File
      inputBinding:
        prefix: -i
    doc: "is the input file name; can use this option more than once to combine multiple targets into one"
    inputBinding:
      position: 1
  - id: bgfile
    type: string
    doc: "is the file name for the output bedGraph"
    inputBinding:
      position: 1
      prefix: -o
  - id: targetname
    type: string
    doc: "is the name of the target"
    inputBinding:
      position: 1
      prefix: -n
  - id: target_location
    type:
      type: array
      items: string
      inputBinding:
        prefix: -t
    doc: "chrom:start-end is the genomic location of the target site; can use this option more than once if multiple pair files are specified."
    inputBinding:
      position: 1
  - id: interchrom
    type:
      - 'null'
      - boolean
    doc: "flag to specify interchromosomal interactions are present"
    inputBinding:
      position: 1
      prefix: --interchrom
outputs:
  - id: bedgraph
    type: File
    doc: "pile-up bedGraph"
    outputBinding:
      glob: $(inputs.bgfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
