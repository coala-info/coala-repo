cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - filter
label: philosopher_filter
doc: "Filter peptides and proteins based on FDR levels and other criteria.\n\nTool
  homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: apply_picked_fdr
    type:
      - 'null'
      - boolean
    doc: apply the picked FDR algorithm before the protein scoring
    inputBinding:
      position: 101
      prefix: --picked
  - id: decoy_tag
    type:
      - 'null'
      - string
    doc: decoy tag
    inputBinding:
      position: 101
      prefix: --tag
  - id: inference
    type:
      - 'null'
      - boolean
    doc: extremely fast and efficient protein inference compatible with 2D and 
      Sequential filters
    inputBinding:
      position: 101
      prefix: --inference
  - id: ion_fdr_level
    type:
      - 'null'
      - float
    doc: peptide ion FDR level
    inputBinding:
      position: 101
      prefix: --ion
  - id: map_modifications
    type:
      - 'null'
      - boolean
    doc: map modifications
    inputBinding:
      position: 101
      prefix: --mapmods
  - id: min_peptide_length
    type:
      - 'null'
      - int
    doc: minimum peptide length criterion for protein probability assignment
    inputBinding:
      position: 101
      prefix: --minPepLen
  - id: peptide_fdr_level
    type:
      - 'null'
      - float
    doc: peptide FDR level
    inputBinding:
      position: 101
      prefix: --pep
  - id: peptide_uniqueness_threshold
    type:
      - 'null'
      - float
    doc: threshold for defining peptide uniqueness
    inputBinding:
      position: 101
      prefix: --weight
  - id: pepxml_file_or_directory
    type:
      - 'null'
      - string
    doc: pepXML file or directory containing a set of pepXML files
    inputBinding:
      position: 101
      prefix: --pepxml
  - id: print_model_distribution
    type:
      - 'null'
      - boolean
    doc: print model distribution
    inputBinding:
      position: 101
      prefix: --models
  - id: protein_fdr_level
    type:
      - 'null'
      - float
    doc: protein FDR level
    inputBinding:
      position: 101
      prefix: --prot
  - id: protein_probability_threshold
    type:
      - 'null'
      - float
    doc: protein probability threshold for the FDR filtering (not used with the 
      razor algorithm)
    inputBinding:
      position: 101
      prefix: --protProb
  - id: protxml_file
    type:
      - 'null'
      - string
    doc: protXML file path
    inputBinding:
      position: 101
      prefix: --protxml
  - id: psm_fdr_level
    type:
      - 'null'
      - float
    doc: psm FDR level
    inputBinding:
      position: 101
      prefix: --psm
  - id: top_peptide_probability_threshold
    type:
      - 'null'
      - float
    doc: top peptide probability threshold for the FDR filtering
    inputBinding:
      position: 101
      prefix: --pepProb
  - id: two_dimensional_fdr
    type:
      - 'null'
      - boolean
    doc: two-dimensional FDR filtering
    inputBinding:
      position: 101
      prefix: --2d
  - id: use_group_label
    type:
      - 'null'
      - boolean
    doc: use the group label to filter the data
    inputBinding:
      position: 101
      prefix: --group
  - id: use_razor_peptides
    type:
      - 'null'
      - boolean
    doc: use razor peptides for protein FDR scoring
    inputBinding:
      position: 101
      prefix: --razor
  - id: use_sequential_algorithm
    type:
      - 'null'
      - boolean
    doc: alternative algorithm that estimates FDR using both filtered PSM and 
      protein lists
    inputBinding:
      position: 101
      prefix: --sequential
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_filter.out
