cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - anova
label: transit_anova
doc: "Anova (moderated) test for differences in essentiality among several conditions, from a combined wig file and a samples metadata file.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: combined_wig_file
    type: File
    doc: "Combined wig file"
    inputBinding:
      position: 1
  - id: samples_metadata_file
    type: File
    doc: "Samples metadata file"
    inputBinding:
      position: 2
  - id: annotation_prot_table
    type: File
    doc: "Annotation .prot_table file"
    inputBinding:
      position: 3
  - id: output_filename
    type: string
    doc: "Output file name"
    inputBinding:
      position: 4
  - id: normalization_method
    type: ['null', string]
    doc: "Normalization method. Default: TTR"
    inputBinding:
      position: 20
      prefix: -n
  - id: include_conditions
    type: ['null', string]
    doc: "Comma-separated list of conditions to use for analysis (Default: all)"
    inputBinding:
      position: 20
      prefix: --include-conditions
  - id: exclude_conditions
    type: ['null', string]
    doc: "Comma-separated list of conditions to exclude (Default: none)"
    inputBinding:
      position: 20
      prefix: --exclude-conditions
  - id: reference_condition
    type: ['null', string]
    doc: "Which condition(s) to use as a reference for calculating LFCs (comma-separated if multiple conditions)"
    inputBinding:
      position: 20
      prefix: --ref
  - id: ignore_n_terminus_percentage
    type: ['null', int]
    doc: "Ignore TAs within given percentage (e.g. 5) of N terminus. Default: 0"
    inputBinding:
      position: 20
      prefix: -iN
  - id: ignore_c_terminus_percentage
    type: ['null', int]
    doc: "Ignore TAs within given percentage (e.g. 5) of C terminus. Default: 0"
    inputBinding:
      position: 20
      prefix: -iC
  - id: pseudocounts
    type: ['null', int]
    doc: "Pseudocounts to use for calculating LFCs. Default: 5"
    inputBinding:
      position: 20
      prefix: -PC
  - id: alpha
    type: ['null', float]
    doc: "Value added to MSE in F-test for moderated anova (makes genes with low counts less significant). Default: 1000"
    inputBinding:
      position: 20
      prefix: -alpha
  - id: winsorize_insertion_counts
    type: ['null', boolean]
    doc: "Winsorize insertion counts for each gene in each condition (replace max cnt with 2nd highest; helps mitigate effect of outliers)"
    inputBinding:
      position: 20
      prefix: -winz
outputs:
  - id: output_file
    type: File
    doc: "Output file"
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
