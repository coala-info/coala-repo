cwlVersion: v1.2
class: CommandLineTool
baseCommand: bed2gfa.py
label: mtglink_bed2gfa.py
doc: "Convert a BED file containing the 'N's coordinates for each scaffold (or locus
  coordinates) to a GFA file (GFA 2.0) ('N's regions are treated as gaps). We can
  filter the 'N's regions by their size (e.g. gap lengths) and by the contigs' sizes
  on both sides (long enough for ex to get enough barcodes)\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: bed_file
    type: File
    doc: "BED file containing the 'Ns' coordinates for each scaffold (format: 'xxx.bed')"
    inputBinding:
      position: 101
      prefix: -bed
  - id: fasta_file
    type: File
    doc: "FASTA file containing the sequences of the scaffolds (reference genome)
      (format: 'xxx.fasta' or 'xxx.fa')"
    inputBinding:
      position: 101
      prefix: -fa
  - id: max_gap_size
    type:
      - 'null'
      - int
    doc: Maximum size of the 'Ns' region to treat as a gap
    inputBinding:
      position: 101
      prefix: -max
  - id: min_contig_size
    type:
      - 'null'
      - int
    doc: Minimum size of the flanking contigs of the 'Ns' region to treat as a 
      gap
    inputBinding:
      position: 101
      prefix: -contigs
  - id: min_gap_size
    type:
      - 'null'
      - int
    doc: Minimum size of the 'Ns' region to treat as a gap
    inputBinding:
      position: 101
      prefix: -min
outputs:
  - id: output_gfa_file
    type: File
    doc: Name of the output GFA file
    outputBinding:
      glob: $(inputs.output_gfa_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
