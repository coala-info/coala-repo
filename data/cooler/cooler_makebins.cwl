cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler_makebins
label: cooler_makebins
doc: "Generate fixed-width genomic bins.\n\n  Output a genome segmentation at a fixed
  resolution as a BED file.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: chromsizes_path
    type: File
    doc: UCSC-like chromsizes file, with chromosomes in desired order.
    inputBinding:
      position: 1
  - id: binsize
    type: int
    doc: Resolution (bin size) in base pairs
    inputBinding:
      position: 2
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print the header of column names as the first row.
    inputBinding:
      position: 103
      prefix: --header
  - id: rel_ids
    type:
      - 'null'
      - boolean
    doc: Include a column of relative bin IDs for each chromosome. Choose 
      whether to report them as 0- or 1-based.
    inputBinding:
      position: 103
      prefix: --rel-ids
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file (defaults to stdout)
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
