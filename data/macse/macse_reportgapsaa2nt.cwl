cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macse
  - -prog
  - reportGapsAA2NT
label: macse_reportgapsaa2nt
doc: "uses a amino acid alignment to align nucleotide sequences.\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: AA_seq_as_pattern_ON
    type:
      - 'null'
      - boolean
    doc: "use this option to indicate that the AA file does not contain a real alignment but a single sequence that contains as many AA as the NT alignment has codons and whose gaps indicate where gaps should be inserted in the NT alignment. Useful for a divide and conquer strategy: 1. build separate alignments (e.g per taxonomic group), 2. build their consensus, 3. align those consensus sequences at the AA level, and use the result to combine the initial NT alignments using this option."
    inputBinding:
      position: 102
      prefix: -AA_seq_as_pattern_ON
  - id: align_AA
    type: File
    doc: "input FASTA file containing aligned amino acid sequences"
    inputBinding:
      position: 102
      prefix: -align_AA
  - id: allow_NT
    type:
      - 'null'
      - string
    doc: "extra nucleotide characters to consider as N (example: -allow_NT \"#?\")"
    inputBinding:
      position: 102
      prefix: -allow_NT
  - id: out_NT
    type: string
    default: "macse_NT.fasta"
    doc: "output FASTA file containing aligned nucleotide sequences (output file name)"
    inputBinding:
      position: 102
      prefix: -out_NT
  - id: seq
    type: File
    doc: "input FASTA file containing (reliable) nucleotide sequences"
    inputBinding:
      position: 102
      prefix: -seq
outputs:
  - id: out_NT_file
    type:
      - 'null'
      - File
    doc: "output FASTA file containing aligned nucleotide sequences"
    outputBinding:
      glob: $(inputs.out_NT)
requirements:
  - class: InlineJavascriptRequirement
  - class: ResourceRequirement
    ramMin: 4096
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
