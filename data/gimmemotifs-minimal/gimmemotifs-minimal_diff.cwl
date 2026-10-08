cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gimme
  - diff
label: gimmemotifs-minimal_diff
doc: "Compare motif frequency and enrichment between fasta files\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs:
  - id: pfmfile
    type:
      - 'null'
      - File
    doc: "PFM file with motifs (default: gimme.vertebrate.v5.0.pfm)."
    inputBinding:
      position: 1
      prefix: --pfmfile
  - id: cutoff
    type:
      - 'null'
      - string
    doc: "motif score cutoff or file with cutoffs (default 0.9)"
    inputBinding:
      position: 1
      prefix: --cutoff
  - id: enrichment
    type:
      - 'null'
      - float
    doc: "minimum enrichment in at least one of the datasets compared to background"
    inputBinding:
      position: 1
      prefix: --enrichment
  - id: frequency
    type:
      - 'null'
      - float
    doc: "minimum frequency in at least one of the datasets"
    inputBinding:
      position: 1
      prefix: --frequency
  - id: genome
    type:
      - 'null'
      - File
    doc: "Genome fasta file; only necessary in combination with a BED file with clusters as inputfile."
    inputBinding:
      position: 1
      prefix: --genome
  - id: fafiles
    type:
      type: array
      items: File
    doc: "FASTA-formatted inputfiles OR a BED file with an identifier in the 4th column, for instance a cluster number."
    inputBinding:
      position: 100
      itemSeparator: ','
  - id: bgfafile
    type: File
    doc: "FASTA-formatted background file"
    inputBinding:
      position: 101
  - id: pngfile
    type: string
    doc: "outputfile (image)"
    inputBinding:
      position: 102
outputs:
  - id: output
    type: File
    doc: "Image with the motif frequency and enrichment comparison"
    outputBinding:
      glob: $(inputs.pngfile)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
