cwlVersion: v1.2
class: CommandLineTool
baseCommand: cassis
label: cassis
doc: "Compares two genomes based on orthologous genes or synteny blocks.\n\nTool homepage:
  http://pbil.univ-lyon1.fr/software/Cassis/"
inputs:
  - id: table
    type: File
    doc: Path for the file that contains the table of orthologous genes or 
      synteny blocks.
    inputBinding:
      position: 1
  - id: type
    type: string
    doc: 'Type of the table: G for orthologous genes and B for synteny blocks.'
    inputBinding:
      position: 2
  - id: dir_gr
    type: Directory
    doc: Path for the directory where the script can locate the FASTA files of 
      the chromosomes of the reference genome (GR).
    inputBinding:
      position: 3
  - id: dir_go
    type: Directory
    doc: Path for the directory where the script can locate the FASTA files of 
      the chromosomes of the genome (GO) which will be compared with the 
      reference genome.
    inputBinding:
      position: 4
  - id: output_dir
    type: Directory
    doc: Name of the directory where the script will write the results. The 
      directory must exist (the script will not try to create it).
    inputBinding:
      position: 5
  - id: extend_ab_by_adding_fragment
    type:
      - 'null'
      - int
    doc: 'Extend sequences SA and SB: N = integer bigger than or equal to zero. Extend
      sequences SA and SB by adding to them a fragment of length N from the sides
      that are not supposed to be orthologous. It is equivalent to add the non orthologous
      genes Co and Do to the sequences. Warning: This parameter is available only
      for table of synteny blocks.'
    default: 50000
    inputBinding:
      position: 106
      prefix: --extend_ab_by_adding_fragment
  - id: extend_ab_by_adding_gene
    type:
      - 'null'
      - boolean
    doc: 'Extend sequences SA and SB: True [T] or FALSE [F]. Extend sequences SA and
      SB by adding the non orthologous genes which are in the boundaries of them.
      (Non orthologous genes: Co and Do). Warning: This parameter is available only
      for table of orthologous genes.'
    default: T
    inputBinding:
      position: 106
      prefix: --extend_ab_by_adding_gene
  - id: extend_before
    type:
      - 'null'
      - boolean
    doc: 'Extend before verify length: True [T] or FALSE [F]. This parameter determines
      if the method verifies the minimum sequence length before (F) or after (T) extending
      the sequence.'
    default: T
    inputBinding:
      position: 106
      prefix: --extend_before
  - id: extend_by_adding_fragment
    type:
      - 'null'
      - int
    doc: 'Extend sequences SR, SA and SB: N = integer bigger than or equal to zero.
      Extend sequences SR, SA and SB by adding to them a fragment of length N from
      the sides that are supposed to be orthologous. It is equivalent to add the orthologous
      genes (Ar,Ao) and (Br,Bo) to the sequences. Warning: This parameter is available
      only for table of synteny blocks.'
    default: 50000
    inputBinding:
      position: 106
      prefix: --extend_by_adding_fragment
  - id: extend_by_adding_gene
    type:
      - 'null'
      - boolean
    doc: 'Extend sequences SR, SA and SB: True [T] or FALSE [F]. Extend sequences
      SR, SA and SB by adding the orthologous genes which are in the boundaries of
      them. (Orthologous genes: pairs (Ar,Ao) and (Br,Bo)). Warning: This parameter
      is available only for table of orthologous genes.'
    default: T
    inputBinding:
      position: 106
      prefix: --extend_by_adding_gene
  - id: lastz_level
    type:
      - 'null'
      - int
    doc: 'LASTZ level: N = 1, 2 or 3. Level 1: LASTZ parameters for closely related
      species. Level 2: Default level. Level 3: LASTZ parameters for distantly related
      species.'
    default: 2
    inputBinding:
      position: 106
      prefix: --lastzlevel
  - id: max_length_sab
    type:
      - 'null'
      - int
    doc: 'Maximum length for sequences SA and SB: N = integer bigger than zero. If
      SA (or SB) length is bigger than N, the length is corrected to fit this limit
      value.'
    default: 3000000
    inputBinding:
      position: 106
      prefix: --max_length_sab
  - id: max_length_sr
    type:
      - 'null'
      - int
    doc: 'Maximum length for sequence SR: N = integer bigger than zero. If SR length
      is bigger than N, the breakpoint receives the status -6 and it is not processed
      by the segmentation step.'
    default: 1000000000
    inputBinding:
      position: 106
      prefix: --max_length_sr
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: 'Minimum sequence length: N = integer bigger than zero. If one or more sequences
      have length smaller than N, the breakpoint receives one of the status -2, -3
      , -4 or -5 and it is not processed by the segmentation step.'
    default: 1 (for genes) or 50000 (for synteny blocks)
    inputBinding:
      position: 106
      prefix: --minimum_length
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cassis:0.0.20120106--hdfd78af_1
stdout: cassis.out
