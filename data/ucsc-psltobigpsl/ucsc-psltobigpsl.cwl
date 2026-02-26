cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslToBigPsl
label: ucsc-psltobigpsl
doc: "Convert a PSL file to a bigPsl file, which can then be converted to bigBed format.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_in
    type: File
    doc: Input PSL file.
    inputBinding:
      position: 1
  - id: chrom_sizes
    type: File
    doc: 'Chromosome sizes file (two columns: name and size).'
    inputBinding:
      position: 2
  - id: cds
    type:
      - 'null'
      - File
    doc: Input CDS information file.
    inputBinding:
      position: 103
      prefix: -cds
  - id: fa
    type:
      - 'null'
      - File
    doc: Input FASTA file with sequence information.
    inputBinding:
      position: 103
      prefix: -fa
  - id: map
    type:
      - 'null'
      - File
    doc: Input mapping information file.
    inputBinding:
      position: 103
      prefix: -map
outputs:
  - id: big_psl_out
    type: File
    doc: Output bigPsl file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltobigpsl:482--h0b57e2e_0
