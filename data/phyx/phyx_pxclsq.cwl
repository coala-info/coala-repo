cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxclsq
label: phyx_pxclsq
doc: "Clean alignments by removing positions/taxa with too much ambiguous data. This
  will take fasta, fastq, phylip, and nexus formats from a file or STDIN. Results
  are written in fasta format.\n\nTool homepage: https://github.com/FePhyFoFum/phyx"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: display phyx citation and exit
    inputBinding:
      position: 101
      prefix: --citation
  - id: codon
    type:
      - 'null'
      - boolean
    doc: examine sequences by codon rather than site (requires all sequences be in
      frame and of correct length)
    inputBinding:
      position: 101
      prefix: --codon
  - id: info
    type:
      - 'null'
      - boolean
    doc: report counts of missing data and exit
    inputBinding:
      position: 101
      prefix: --info
  - id: prop
    type:
      - 'null'
      - float
    doc: proportion required to be present
    inputBinding:
      position: 101
      prefix: --prop
  - id: seqf
    type:
      - 'null'
      - File
    doc: input sequence file, STDIN otherwise
    inputBinding:
      position: 101
      prefix: --seqf
  - id: taxa
    type:
      - 'null'
      - boolean
    doc: 'consider missing data per taxon (default: per site)'
    inputBinding:
      position: 101
      prefix: --taxa
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: more verbose output (i.e. if entire seqs are removed)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outf
    type:
      - 'null'
      - File
    doc: output fasta file, STOUT otherwise
    outputBinding:
      glob: $(inputs.outf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
