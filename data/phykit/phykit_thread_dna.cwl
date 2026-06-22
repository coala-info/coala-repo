cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - thread_dna
label: phykit_thread_dna
doc: Thread DNA sequence onto a protein alignment to create a codon-based 
  alignment. This function requires input alignments are in fasta format. Codon 
  alignments are then printed to stdout. Note, paired sequences are assumed to 
  have the same name between the protein and nucleotide file.
inputs:
  - id: protein
    type: File
    doc: protein alignment file
    inputBinding:
      position: 101
      prefix: --protein
  - id: nucleotide
    type:
      - 'null'
      - File
    doc: nucleotide sequence file
    inputBinding:
      position: 101
      prefix: --nucleotide
  - id: clipkit_log
    type:
      - 'null'
      - File
    doc: clipkit outputted log file
    inputBinding:
      position: 101
      prefix: --clipkit_log
  - id: stop
    type:
      - 'null'
      - boolean
    doc: boolean for whether or not stop codons should be kept. If used, stop 
      codons will be removed.
    inputBinding:
      position: 101
      prefix: --stop
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_thread_dna.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
