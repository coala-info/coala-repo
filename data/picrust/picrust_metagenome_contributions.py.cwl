cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagenome_contributions.py
label: picrust_metagenome_contributions.py
doc: "Partition the predicted contribution to the metagenomes from each organism in
  the given OTU table\n\nTool homepage: http://picrust.github.com"
inputs:
  - id: gg_version
    type:
      - 'null'
      - string
    doc: 'Version of GreenGenes that was used for OTU picking. Valid choices are:
      13_5, 18may2012'
    inputBinding:
      position: 101
      prefix: --gg_version
  - id: input_count_table
    type:
      - 'null'
      - File
    doc: 'Precalculated function predictions on per otu basis in biom format (can
      be gzipped). Note: using this option overrides --type_of_prediction and --gg_version.'
    inputBinding:
      position: 101
      prefix: --input_count_table
  - id: input_otu_table
    type: File
    doc: the input otu table in biom format
    inputBinding:
      position: 101
      prefix: --input_otu_table
  - id: limit_to_function
    type:
      - 'null'
      - string
    doc: If provided, only output predictions for the specified function ids. 
      Multiple function ids can be passed using comma delimiters.
    inputBinding:
      position: 101
      prefix: --limit_to_function
  - id: limit_to_functional_categories
    type:
      - 'null'
      - string
    doc: If provided only output prediction for functions that match the 
      specified functional category. Multiple categories can be passed as a list
      separated by |
    inputBinding:
      position: 101
      prefix: --limit_to_functional_categories
  - id: load_precalc_file_in_biom
    type:
      - 'null'
      - boolean
    doc: Instead of loading the precalculated file in tab- delimited format 
      (with otu ids as row ids and traits as columns) load the data in biom 
      format (with otu as SampleIds and traits as ObservationIds)
    inputBinding:
      position: 101
  - id: suppress_subset_loading
    type:
      - 'null'
      - boolean
    doc: Normally, only counts for OTUs present in the sample are loaded. If 
      this flag is passed, the full biom table is loaded. This makes no 
      difference for the analysis, but may result in faster load times (at the 
      cost of more memory usage)
    inputBinding:
      position: 101
  - id: type_of_prediction
    type:
      - 'null'
      - string
    doc: 'Type of functional predictions. Valid choices are: ko, cog, rfam'
    inputBinding:
      position: 101
      prefix: --type_of_prediction
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print information during execution -- useful for debugging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_fp
    type: File
    doc: the output file for the metagenome contributions
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust:1.1.4--pyh24bf2e0_0
