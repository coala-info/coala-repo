cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler digest
label: cooler_digest
doc: "Generate fragment-delimited genomic bins.\n\nOutput a genome segmentation of
  restriction fragments as a BED file.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: chromsizes_path
    type: File
    doc: UCSC-like chromsizes file, with chromosomes in desired order.
    inputBinding:
      position: 1
  - id: fasta_path
    type: File
    doc: Genome assembly FASTA file or folder containing FASTA files 
      (uncompressed).
    inputBinding:
      position: 2
  - id: enzyme
    type: string
    doc: Name of restriction enzyme
    inputBinding:
      position: 3
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print the header of column names as the first row.
    inputBinding:
      position: 104
      prefix: --header
  - id: rel_ids
    type:
      - 'null'
      - string
    doc: Include a column of relative bin IDs for each chromosome. Choose 
      whether to report them as 0- or 1-based.
    inputBinding:
      position: 104
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
