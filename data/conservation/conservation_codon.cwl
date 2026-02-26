cwlVersion: v1.2
class: CommandLineTool
baseCommand: conservation_codon
label: conservation_codon
doc: "Codon conservation analysis from Pfam domains and CDS sequences.\n\nTool homepage:
  https://github.com/hanjunlee21/conservation"
inputs:
  - id: cds
    type: string
    doc: Comma-separated list of CDS fasta files for each organism
    inputBinding:
      position: 101
      prefix: --cds
  - id: conservedness
    type:
      - 'null'
      - string
    doc: Identity ratio threshold
    default: mean + 2*std
    inputBinding:
      position: 101
      prefix: --conservedness
  - id: domain
    type: File
    doc: FASTA file of domain sequences (e.g., Pfam)
    inputBinding:
      position: 101
      prefix: --domain
  - id: dpi
    type:
      - 'null'
      - int
    doc: DPI for all generated PDF files
    default: 300
    inputBinding:
      position: 101
      prefix: --dpi
  - id: fdr
    type:
      - 'null'
      - float
    doc: FDR cutoff
    default: 0.05 / num_records
    inputBinding:
      position: 101
      prefix: --fdr
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: Directory
    doc: Output directory to store results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conservation:1.0.1--pyhdfd78af_0
