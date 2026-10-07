cwlVersion: v1.2
class: CommandLineTool
baseCommand: chain2paf
label: chain2paf
doc: "Convert UCSC chain files to PAF (Pairwise Mapping Format)\n\nTool homepage:
  https://github.com/AndreaGuarracino/chain2paf"
inputs:
  - id: input_chain
    type: File
    doc: Input UCSC chain file to be converted
    inputBinding:
      position: 1
      prefix: --input
  - id: fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA files (uncompressed or bgzipped) for targets (1st file) and 
      queries (2nd file). If specified, it writes =/X CIGAR operators (slower).
      The tool reads a .fai index (and .gzi for bgzipped files) beside each 
      file; give them, as the staged input folder is read-only.
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: .gzi
        required: false
    inputBinding:
      position: 2
      prefix: --fasta
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chain2paf:0.1.1--h3ab6199_0
stdout: chain2paf.out
