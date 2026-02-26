cwlVersion: v1.2
class: CommandLineTool
baseCommand: ting
label: bio-ting_ting
doc: "TCR analysis tool\n\nTool homepage: https://github.com/FelixMoelder/ting"
inputs:
  - id: gliph_minp
    type:
      - 'null'
      - float
    doc: probability threshold for identifying significant k-mers by gliph test
    inputBinding:
      position: 101
      prefix: --gliph_minp
  - id: kmer_file
    type: File
    doc: tab separated file holding kmers in first row
    inputBinding:
      position: 101
      prefix: --kmer_file
  - id: kmers_gliph
    type:
      - 'null'
      - boolean
    doc: If set kmers are identified by the non-deterministic approach as 
      implemented by gliph
    inputBinding:
      position: 101
      prefix: --kmers_gliph
  - id: max_p_value
    type:
      - 'null'
      - float
    doc: p-value threshold for identifying significant k-mers by fisher exact 
      test
    inputBinding:
      position: 101
      prefix: --max_p_value
  - id: no_global
    type:
      - 'null'
      - boolean
    doc: If set global clustering is excluded
    inputBinding:
      position: 101
      prefix: --no_global
  - id: no_local
    type:
      - 'null'
      - boolean
    doc: If set local clustering is excluded
    inputBinding:
      position: 101
      prefix: --no_local
  - id: reference
    type: File
    doc: Reference fasta file of naive CDR3 amino acid sequences used for 
      estimation of significant k-mers.
    inputBinding:
      position: 101
      prefix: --reference
  - id: stringent_filtering
    type:
      - 'null'
      - boolean
    doc: If used only TCRs starting with a cystein and ending with phenylalanine
      will be used
    inputBinding:
      position: 101
      prefix: --stringent_filtering
  - id: tcr_sequences
    type: File
    doc: File holding TCRs
    inputBinding:
      position: 101
      prefix: --tcr_sequences
  - id: use_structural_boundaries
    type:
      - 'null'
      - boolean
    doc: First and last three amino acids are included in processing
    inputBinding:
      position: 101
      prefix: --use_structural_boundaries
outputs:
  - id: output
    type: File
    doc: path of output-file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio-ting:1.1.0--py_0
