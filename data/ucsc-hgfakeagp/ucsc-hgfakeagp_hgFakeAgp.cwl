cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgFakeAgp
label: ucsc-hgfakeagp_hgFakeAgp
doc: "Create fake AGP file by looking at N's\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: input_fa
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: min_contig_gap
    type:
      - 'null'
      - int
    doc: Minimum size for a gap between contigs.
    inputBinding:
      position: 102
      prefix: -minContigGap
  - id: min_scaffold_gap
    type:
      - 'null'
      - int
    doc: Min size for a gap between scaffolds.
    inputBinding:
      position: 102
      prefix: -minScaffoldGap
  - id: single_contigs
    type:
      - 'null'
      - boolean
    doc: when a full sequence has no gaps, maintain contig name without adding 
      index extension.
    inputBinding:
      position: 102
      prefix: -singleContigs
outputs:
  - id: output_agp
    type: File
    doc: Output AGP file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgfakeagp:482--h0b57e2e_0
