cwlVersion: v1.2
class: CommandLineTool
baseCommand: ViralMSA.py
label: viralmsa_ViralMSA.py
doc: "Reference-guided multiple sequence alignment of viral genomes\n\nTool homepage:
  https://github.com/niemasd/ViralMSA"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: 'Aligner (options: bowtie2, bwa, dragmap, hisat2, lra, minimap2, mm2-fast,
      ngmlr, seq-align, star, unimap, wfmash, winnowmap)'
    inputBinding:
      position: 101
      prefix: --aligner
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: File Stream Buffer Size (bytes)
    inputBinding:
      position: 101
      prefix: --buffer_size
  - id: email
    type:
      - 'null'
      - string
    doc: Email Address (for Entrez)
    inputBinding:
      position: 101
      prefix: --email
  - id: list_references
    type:
      - 'null'
      - boolean
    doc: List all reference sequences
    inputBinding:
      position: 101
      prefix: --list_references
  - id: omit_ref
    type:
      - 'null'
      - boolean
    doc: Omit reference sequence from output alignment
    inputBinding:
      position: 101
      prefix: --omit_ref
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress log output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reference
    type: File
    doc: Reference
    inputBinding:
      position: 101
      prefix: --reference
  - id: sequences
    type: File
    doc: Input Sequences (FASTA format, or SAM if already mapped)
    inputBinding:
      position: 101
      prefix: --sequences
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Write MSA to standard output instead of to file
    inputBinding:
      position: 101
      prefix: --stdout
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of Threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: update
    type:
      - 'null'
      - boolean
    doc: 'Update ViralMSA (current version: 1.1.46)'
    inputBinding:
      position: 101
      prefix: --update
  - id: viralmsa_dir
    type:
      - 'null'
      - Directory
    doc: ViralMSA Cache Directory
    inputBinding:
      position: 101
      prefix: --viralmsa_dir
outputs:
  - id: output
    type: Directory
    doc: Output Directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralmsa:1.1.46--hdfd78af_0
