cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - zinb
label: transit_zinb
doc: "Zero-inflated negative binomial (ZINB) test for differences in essentiality among several conditions, from a combined wig file and a samples metadata file. Needs R and rpy2.\n\nTool homepage: http://github.com/mad-lab/transit"
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
  - id: exclude_conditions
    type: ['null', string]
    doc: "Comma-separated list of conditions to exclude from the analysis"
    inputBinding:
      position: 20
      prefix: --exclude-conditions
  - id: include_conditions
    type: ['null', string]
    doc: "Comma-separated list of conditions to include in the analysis; conditions not in this list are excluded"
    inputBinding:
      position: 20
      prefix: --include-conditions
  - id: reference_condition
    type: ['null', string]
    doc: "Which condition(s) to use as a reference for calculating LFCs (comma-separated if multiple conditions)"
    inputBinding:
      position: 20
      prefix: --ref
  - id: ignore_n_terminus_percentage
    type: ['null', float]
    doc: "Ignore TAs occuring within given percentage (as integer) of the N terminus. Default: 5"
    inputBinding:
      position: 20
      prefix: -iN
  - id: ignore_c_terminus_percentage
    type: ['null', float]
    doc: "Ignore TAs occuring within given percentage (as integer) of the C terminus. Default: 5"
    inputBinding:
      position: 20
      prefix: -iC
  - id: winsorize_counts
    type: ['null', boolean]
    doc: "Winsorize insertion counts for each gene in each condition (replace max cnt with 2nd highest; helps mitigate effect of outliers)"
    inputBinding:
      position: 20
      prefix: -winz
  - id: pseudocounts
    type: ['null', float]
    doc: "Pseudocounts to use for calculating LFCs. Default: 5"
    inputBinding:
      position: 20
      prefix: -PC
  - id: condition_column
    type: ['null', string]
    doc: "Column name (in the samples metadata file) to use as the Condition. Default: Condition"
    inputBinding:
      position: 20
      prefix: --condition
  - id: covariates
    type: ['null', string]
    doc: "Comma-separated list of covariates (in the metadata file) to include in the analysis"
    inputBinding:
      position: 20
      prefix: --covars
  - id: interactions
    type: ['null', string]
    doc: "Comma-separated list of covariates that interact with the condition. Must be factors"
    inputBinding:
      position: 20
      prefix: --interactions
  - id: prot_table_annotations
    type: ['null', File]
    doc: "Prot_table file used to append gene annotations to the output"
    inputBinding:
      position: 20
      prefix: --prot_table
  - id: gene
    type: ['null', string]
    doc: "Run the method for one gene (Rv number or gene name) and print the model output"
    inputBinding:
      position: 20
      prefix: --gene
outputs:
  - id: output_file
    type: File
    doc: "Output file"
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
