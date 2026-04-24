cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python3
  - transit.py
  - anova
label: transit_anova
doc: "Performs ANOVA analysis on combined wig files based on samples metadata and
  annotation.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: combined_wig_file
    type: File
    doc: Combined wig file
    inputBinding:
      position: 1
  - id: samples_metadata_file
    type: File
    doc: Samples metadata file
    inputBinding:
      position: 2
  - id: annotation_prot_table
    type: File
    doc: Annotation .prot_table file
    inputBinding:
      position: 3
  - id: alpha
    type:
      - 'null'
      - float
    doc: Value added to MSE in F-test for moderated anova (makes genes with low 
      counts less significant)
    inputBinding:
      position: 104
      prefix: -alpha
  - id: exclude_conditions
    type:
      - 'null'
      - string
    doc: Comma-separated list of conditions to exclude
    inputBinding:
      position: 104
      prefix: --exclude-conditions
  - id: ignore_c_terminus_percentage
    type:
      - 'null'
      - int
    doc: Ignore TAs within given percentage of C terminus
    inputBinding:
      position: 104
      prefix: -iC
  - id: ignore_n_terminus_percentage
    type:
      - 'null'
      - int
    doc: Ignore TAs within given percentage of N terminus
    inputBinding:
      position: 104
      prefix: -iN
  - id: include_conditions
    type:
      - 'null'
      - string
    doc: Comma-separated list of conditions to use for analysis
    inputBinding:
      position: 104
      prefix: --include-conditions
  - id: normalization_method
    type:
      - 'null'
      - string
    doc: Normalization method
    inputBinding:
      position: 104
      prefix: -n
  - id: pseudocounts
    type:
      - 'null'
      - int
    doc: Pseudocounts to use for calculating LFCs
    inputBinding:
      position: 104
      prefix: -PC
  - id: reference_condition
    type:
      - 'null'
      - string
    doc: Which condition(s) to use as a reference for calculating LFCs 
      (comma-separated if multiple conditions)
    inputBinding:
      position: 104
      prefix: --ref
  - id: winsorize_insertion_counts
    type:
      - 'null'
      - boolean
    doc: Winsorize insertion counts for each gene in each condition (replace max
      cnt with 2nd highest; helps mitigate effect of outliers)
    inputBinding:
      position: 104
      prefix: -winz
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
