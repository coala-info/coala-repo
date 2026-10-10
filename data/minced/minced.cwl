cwlVersion: v1.2
class: CommandLineTool
baseCommand: minced
label: minced
doc: MinCED, a program to find CRISPRs in shotgun DNA sequences or full genomes
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file containing shotgun DNA sequences or full genomes
    inputBinding:
      position: 11
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file for CRISPR results
    inputBinding:
      position: 12
  - id: output_gff
    type:
      - 'null'
      - string
    doc: Output GFF file
    inputBinding:
      position: 13
  - id: search_window_length
    type:
      - 'null'
      - int
    doc: 'Length of search window used to discover CRISPRs (range: 6-9)'
    inputBinding:
      position: 1
      prefix: -searchWL
  - id: min_repeats
    type:
      - 'null'
      - int
    doc: Minimum number of repeats a CRISPR must contain
    inputBinding:
      position: 1
      prefix: -minNR
  - id: min_repeat_length
    type:
      - 'null'
      - int
    doc: Minimum length of the CRISPR repeats
    inputBinding:
      position: 1
      prefix: -minRL
  - id: max_repeat_length
    type:
      - 'null'
      - int
    doc: Maximum length of the CRISPR repeats
    inputBinding:
      position: 1
      prefix: -maxRL
  - id: min_spacer_length
    type:
      - 'null'
      - int
    doc: Minimum length of the CRISPR spacers
    inputBinding:
      position: 1
      prefix: -minSL
  - id: max_spacer_length
    type:
      - 'null'
      - int
    doc: Maximum length of the CRISPR spacers
    inputBinding:
      position: 1
      prefix: -maxSL
  - id: gff
    type:
      - 'null'
      - boolean
    doc: Output summary results in gff format containing only the positions of 
      the CRISPR arrays
    inputBinding:
      position: 1
      prefix: -gff
  - id: gff_full
    type:
      - 'null'
      - boolean
    doc: Output detailed results in gff format containing positions of CRISPR 
      arrays and all repeat units
    inputBinding:
      position: 1
      prefix: -gffFull
  - id: spacers
    type:
      - 'null'
      - boolean
    doc: Output a fasta formatted file containing the spacers
    inputBinding:
      position: 1
      prefix: -spacers
outputs:
  - id: out_output_file
    type:
      - 'null'
      - File
    doc: Output file for CRISPR results
    outputBinding:
      glob: $(inputs.output_file)
  - id: out_output_gff
    type:
      - 'null'
      - File
    doc: Output GFF file
    outputBinding:
      glob: $(inputs.output_gff)
  - id: out_spacers_fasta
    type:
      - 'null'
      - File
    doc: FASTA file of the spacers (written when -spacers is used)
    outputBinding:
      glob: '*_spacers.fa'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minced:0.4.2--0
s:url: https://github.com/ctSkennerton/minced
$namespaces:
  s: https://schema.org/
