cwlVersion: v1.2
class: CommandLineTool
baseCommand: codonw
label: codonw
doc: "A program for codon usage analysis, including correspondence analysis and calculation
  of various indices.\n\nTool homepage: http://codonw.sourceforge.net"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input sequence file
    inputBinding:
      position: 1
  - id: all_indices
    type:
      - 'null'
      - boolean
    doc: All the above indices
    inputBinding:
      position: 102
      prefix: -all_indices
  - id: amino_acid_usage
    type:
      - 'null'
      - boolean
    doc: Amino Acid Usage (AAU)
    inputBinding:
      position: 102
      prefix: -aau
  - id: aromaticity
    type:
      - 'null'
      - boolean
    doc: Calculate aromaticity of protein
    inputBinding:
      position: 102
      prefix: -aro
  - id: base_composition
    type:
      - 'null'
      - boolean
    doc: Detailed report of codon G+C composition
    inputBinding:
      position: 102
      prefix: -base
  - id: cai
    type:
      - 'null'
      - boolean
    doc: calculate Codon Adaptation Index (CAI)
    inputBinding:
      position: 102
      prefix: -cai
  - id: cai_file
    type:
      - 'null'
      - File
    doc: User input file of CAI values
    inputBinding:
      position: 102
      prefix: -cai_file
  - id: cai_type
    type:
      - 'null'
      - int
    doc: Cai fitness values as defined by menu 3 option 7
    inputBinding:
      position: 102
      prefix: -c_type
  - id: cbi
    type:
      - 'null'
      - boolean
    doc: calculate Codon Bias Index (CBI)
    inputBinding:
      position: 102
      prefix: -cbi
  - id: cbi_file
    type:
      - 'null'
      - File
    doc: User input file of CBI values
    inputBinding:
      position: 102
      prefix: -cbi_file
  - id: coa_aa
    type:
      - 'null'
      - boolean
    doc: COA of amino acid usage frequencies
    inputBinding:
      position: 102
      prefix: -coa_aa
  - id: coa_axes
    type:
      - 'null'
      - int
    doc: Select number of axis to record
    inputBinding:
      position: 102
      prefix: -coa_axes
  - id: coa_cu
    type:
      - 'null'
      - boolean
    doc: COA of codon usage frequencies
    inputBinding:
      position: 102
      prefix: -coa_cu
  - id: coa_expert
    type:
      - 'null'
      - boolean
    doc: Generate detailed(expert) statistics on COA
    inputBinding:
      position: 102
      prefix: -coa_expert
  - id: coa_num
    type:
      - 'null'
      - string
    doc: Select number of genes to use to identify optimal codons (whole numbers
      or percentage)
    inputBinding:
      position: 102
      prefix: -coa_num
  - id: coa_rscu
    type:
      - 'null'
      - boolean
    doc: COA of Relative Synonymous Codon Usage
    inputBinding:
      position: 102
      prefix: -coa_rscu
  - id: codon_usage
    type:
      - 'null'
      - boolean
    doc: Codon Usage (CU) (default)
    inputBinding:
      position: 102
      prefix: -cu
  - id: codon_usage_tab
    type:
      - 'null'
      - boolean
    doc: Tabulation of codon usage
    inputBinding:
      position: 102
      prefix: -cutab
  - id: codon_usage_total
    type:
      - 'null'
      - boolean
    doc: Tabulation of dataset's codon usage
    inputBinding:
      position: 102
      prefix: -cutot
  - id: column_separator
    type:
      - 'null'
      - string
    doc: Column separator to be used in output files (comma,tab,space)
    inputBinding:
      position: 102
      prefix: -t
  - id: dinucleotide
    type:
      - 'null'
      - boolean
    doc: Dinucleotide usage of the three codon pos.
    inputBinding:
      position: 102
      prefix: -dinuc
  - id: enc
    type:
      - 'null'
      - boolean
    doc: Effective Number of Codons (ENc)
    inputBinding:
      position: 102
      prefix: -enc
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: fasta format
    inputBinding:
      position: 102
      prefix: -fasta
  - id: fop
    type:
      - 'null'
      - boolean
    doc: calculate Frequency of OPtimal codons index (FOP)
    inputBinding:
      position: 102
      prefix: -fop
  - id: fop_cbi_type
    type:
      - 'null'
      - int
    doc: Fop/CBI codons as defined by menu 3 option 6
    inputBinding:
      position: 102
      prefix: -f_type
  - id: fop_file
    type:
      - 'null'
      - File
    doc: User input file of Fop values
    inputBinding:
      position: 102
      prefix: -fop_file
  - id: gc
    type:
      - 'null'
      - boolean
    doc: G+C content of gene (all 3 codon positions)
    inputBinding:
      position: 102
      prefix: -gc
  - id: gcs3
    type:
      - 'null'
      - boolean
    doc: GC of synonymous codons 3rd positions
    inputBinding:
      position: 102
      prefix: -gcs3
  - id: genetic_code
    type:
      - 'null'
      - int
    doc: Genetic code as defined under menu 3 option 5
    inputBinding:
      position: 102
      prefix: -code
  - id: human
    type:
      - 'null'
      - boolean
    doc: Human readable output
    inputBinding:
      position: 102
      prefix: -human
  - id: hydropathicity
    type:
      - 'null'
      - boolean
    doc: Calculate hydropathicity of protein
    inputBinding:
      position: 102
      prefix: -hyd
  - id: l_aa
    type:
      - 'null'
      - boolean
    doc: Total number of synonymous and non-synonymous codons
    inputBinding:
      position: 102
      prefix: -L_aa
  - id: l_sym
    type:
      - 'null'
      - boolean
    doc: Number of synonymous codons
    inputBinding:
      position: 102
      prefix: -L_sym
  - id: machine
    type:
      - 'null'
      - boolean
    doc: Machine readable output
    inputBinding:
      position: 102
      prefix: -machine
  - id: no_bulk_output
    type:
      - 'null'
      - boolean
    doc: No bulk output to be written to file
    inputBinding:
      position: 102
      prefix: -noblk
  - id: no_menu
    type:
      - 'null'
      - boolean
    doc: Prevent the menu interface being displayed
    inputBinding:
      position: 102
      prefix: -nomenu
  - id: no_warn
    type:
      - 'null'
      - boolean
    doc: Prevent warnings about sequences being displayed
    inputBinding:
      position: 102
      prefix: -nowarn
  - id: reader
    type:
      - 'null'
      - boolean
    doc: Reader format (codons are separated by spaces)
    inputBinding:
      position: 102
      prefix: -reader
  - id: relative_amino_acid_usage
    type:
      - 'null'
      - boolean
    doc: Relative Amino Acid Usage (RAAU)
    inputBinding:
      position: 102
      prefix: -raau
  - id: rscu
    type:
      - 'null'
      - boolean
    doc: Relative Synonymous Codon Usage (RSCU)
    inputBinding:
      position: 102
      prefix: -rscu
  - id: sil_base
    type:
      - 'null'
      - boolean
    doc: Base composition at synonymous third codon positions
    inputBinding:
      position: 102
      prefix: -sil_base
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Overwrite files silently
    inputBinding:
      position: 102
      prefix: -silent
  - id: tidy
    type:
      - 'null'
      - boolean
    doc: fasta format
    inputBinding:
      position: 102
      prefix: -tidy
  - id: totals
    type:
      - 'null'
      - boolean
    doc: Concatenate all genes in inputfile
    inputBinding:
      position: 102
      prefix: -totals
  - id: translate
    type:
      - 'null'
      - boolean
    doc: Conceptual translation of DNA to amino acid
    inputBinding:
      position: 102
      prefix: -transl
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Main output file
    outputBinding:
      glob: '*.out'
  - id: bulk_output_file
    type:
      - 'null'
      - File
    doc: Bulk output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/codonw:v1.4.4-4-deb_cv1
