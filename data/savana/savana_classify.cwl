cwlVersion: v1.2
class: CommandLineTool
baseCommand: savana classify
label: savana_classify
doc: "Classify variants in a VCF file.\n\nTool homepage: https://github.com/cortes-ciriano-lab/savana"
inputs:
  - id: cna_rescue
    type:
      - 'null'
      - File
    doc: Copy number abberation output file for this sample (used to rescue 
      variants)
    inputBinding:
      position: 101
      prefix: --cna_rescue
  - id: cna_rescue_distance
    type:
      - 'null'
      - int
    doc: Maximum distance from a copy number abberation for a variant to be 
      rescued
    inputBinding:
      position: 101
      prefix: --cna_rescue_distance
  - id: confidence
    type:
      - 'null'
      - float
    doc: Confidence level for mondrian conformal prediction - suggested range 
      (0.70-0.99) (not used by default)
    inputBinding:
      position: 101
      prefix: --confidence
  - id: custom_model
    type:
      - 'null'
      - File
    doc: Pickle file of custom machine-learning model
    inputBinding:
      position: 101
      prefix: --custom_model
  - id: custom_params
    type:
      - 'null'
      - File
    doc: JSON file of custom filtering parameters
    inputBinding:
      position: 101
      prefix: --custom_params
  - id: legacy
    type:
      - 'null'
      - boolean
    doc: Legacy lenient/strict filtering
    inputBinding:
      position: 101
      prefix: --legacy
  - id: min_af
    type:
      - 'null'
      - float
    doc: Minimum allele-fraction for a PASS variant
    inputBinding:
      position: 101
      prefix: --min_af
  - id: min_support
    type:
      - 'null'
      - int
    doc: Minimum supporting reads for a PASS variant
    inputBinding:
      position: 101
      prefix: --min_support
  - id: ont
    type:
      - 'null'
      - boolean
    doc: Use the Oxford Nanopore (ONT) trained model to classify variants 
      (default)
    default: true
    inputBinding:
      position: 101
      prefix: --ont
  - id: pb
    type:
      - 'null'
      - boolean
    doc: Use PacBio thresholds to classify variants
    inputBinding:
      position: 101
      prefix: --pb
  - id: predict_germline
    type:
      - 'null'
      - boolean
    doc: Also predict germline events (reduces accuracy of somatic calls for 
      model)
    inputBinding:
      position: 101
      prefix: --predict_germline
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: tumour_only
    type:
      - 'null'
      - boolean
    doc: Classifying tumour-only data
    inputBinding:
      position: 101
      prefix: --tumour_only
  - id: vcf
    type: File
    doc: VCF file to classify
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: output
    type: File
    doc: Output VCF with PASS columns and CLASS added to INFO
    outputBinding:
      glob: $(inputs.output)
  - id: somatic_output
    type:
      - 'null'
      - File
    doc: Output VCF containing only PASS somatic variants
    outputBinding:
      glob: $(inputs.somatic_output)
  - id: germline_output
    type:
      - 'null'
      - File
    doc: Output VCF containing only PASS germline variants
    outputBinding:
      glob: $(inputs.germline_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
