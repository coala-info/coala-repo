cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - alignment_recoding
label: phykit_alignment_recoding
doc: Recode alignments using reduced character states. Alignments can be recoded
  using established or custom recoding schemes.
inputs:
  - id: fasta
    type: File
    doc: First argument after function name should be a fasta file
    inputBinding:
      position: 1
  - id: code
    type: string
    doc: Recoding scheme to use (e.g., RY-nucleotide, SandR-6, KGB-6, Dayhoff-6,
      Dayhoff-9, Dayhoff-12, Dayhoff-15, Dayhoff-18, or a custom two-column 
      file)
    inputBinding:
      position: 102
      prefix: --code
  - id: json
    type:
      - 'null'
      - boolean
    doc: Optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_alignment_recoding.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
