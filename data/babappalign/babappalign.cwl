cwlVersion: v1.2
class: CommandLineTool
baseCommand: babappalign
label: babappalign
doc: "\nTool homepage: https://github.com/sinhakrishnendu/BABAPPAlign"
inputs:
  - id: fasta
    type: File
    doc: Input protein or CDS FASTA; alignments are written beside it
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: device
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --device
  - id: gap_extend
    type:
      - 'null'
      - float
    inputBinding:
      position: 102
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - float
    inputBinding:
      position: 102
      prefix: --gap-open
  - id: mode
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --mode
  - id: model
    type: File
    doc: BABAPPAScore model weights (babappascore.pt)
    inputBinding:
      position: 102
      prefix: --model
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: protein_alignment
    type: File
    doc: Protein alignment <input stem>.protein.aln.fasta
    outputBinding:
      glob: $(inputs.fasta.nameroot).protein.aln.fasta
  - id: codon_alignment
    type:
      - 'null'
      - File
    doc: Codon alignment <input stem>.codon.aln.fasta (codon mode only)
    outputBinding:
      glob: $(inputs.fasta.nameroot).codon.aln.fasta
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta)
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/babappalign:1.2.0--py313h9ee0642_0
stdout: babappalign.out
