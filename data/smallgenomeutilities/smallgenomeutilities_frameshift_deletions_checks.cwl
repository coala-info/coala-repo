cwlVersion: v1.2
class: CommandLineTool
baseCommand: frameshift_deletions_checks
label: smallgenomeutilities_frameshift_deletions_checks
doc: "Produces a report about frameshifting indels and stops in a consensus sequences\n\
  \nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs:
  - id: chain
    type:
      - 'null'
      - string
    doc: Chain file describing how the consensus is aligned to the reference 
      (e.g. `bcftools consensus --chain ...`); If not provided, mafft will be 
      used to align the consensus to the reference.
    default: None
    inputBinding:
      position: 101
      prefix: --chain
  - id: consensus_fasta
    type: File
    doc: Fasta file containing the ref_majority_dels consensus sequence
    inputBinding:
      position: 101
      prefix: --consensus
  - id: english
    type:
      - 'null'
      - boolean
    doc: If True writes english summary diagnosis.
    default: true
    inputBinding:
      position: 101
      prefix: --english
  - id: genes_gff
    type: File
    doc: GFF file listing genes positions on the reference sequence
    inputBinding:
      position: 101
      prefix: --genes
  - id: input_bam
    type: File
    doc: Input BAM file, aligned against the reference
    inputBinding:
      position: 101
      prefix: --input
  - id: no_english
    type:
      - 'null'
      - boolean
    doc: If True writes english summary diagnosis.
    inputBinding:
      position: 101
      prefix: --no-english
  - id: orf1ab
    type:
      - 'null'
      - string
    doc: CDS ID for the full Orf1ab CDS, comprising the ribosomal shift. In the 
      GFF this CDS should consist of 2 entries with the same CDS ID due to the 
      partial overlap caused by the ribosomal shift at translation time
    default: cds-YP_009724389.1
    inputBinding:
      position: 101
      prefix: --orf1ab
  - id: reference_fasta
    type: File
    doc: Fasta file containing the reference sequence to compare against
    inputBinding:
      position: 101
      prefix: --reference
  - id: zero_based
    type:
      - 'null'
      - boolean
    doc: Use 0-based (python) instead of 1-based (standard) seq positions
    default: false
    inputBinding:
      position: 101
      prefix: --zero-based
outputs:
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
