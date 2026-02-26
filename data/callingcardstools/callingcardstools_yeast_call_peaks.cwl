cwlVersion: v1.2
class: CommandLineTool
baseCommand: yeast_call_peaks
label: callingcardstools_yeast_call_peaks
doc: "Call peaks for yeast calling cards data.\n\nTool homepage: https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: experiment_data_paths
    type:
      type: array
      items: File
    doc: paths to the experiment data files.
    inputBinding:
      position: 1
  - id: background_data_path
    type: File
    doc: path to the background data file.
    inputBinding:
      position: 102
      prefix: --background_data_path
  - id: background_orig_chr_convention
    type: string
    doc: the chromosome naming convention used in the background data file.
    inputBinding:
      position: 102
      prefix: --background_orig_chr_convention
  - id: chrmap_data_path
    type: File
    doc: path to the chromosome map file. this must include the data files' 
      current naming conventions, the desired naming, and a column `type` that 
      indicates whether the chromosome is 'genomic' or something else, eg 
      'mitochondrial' or 'plasmid'.
    inputBinding:
      position: 102
      prefix: --chrmap_data_path
  - id: compress_output
    type:
      - 'null'
      - boolean
    doc: set this flag to gzip the output csv file.
    inputBinding:
      position: 102
      prefix: --compress_output
  - id: deduplicate_experiment
    type:
      - 'null'
      - boolean
    doc: set this flag to deduplicate the experiment data based on `chr`, 
      `start` and `end` such that if an insertion is found at the same 
      coordinate on different strands, only one of those records will be 
      retained.
    inputBinding:
      position: 102
      prefix: --deduplicate_experiment
  - id: experiment_orig_chr_convention
    type: string
    doc: the chromosome naming convention used in the experiment data file.
    inputBinding:
      position: 102
      prefix: --experiment_orig_chr_convention
  - id: genomic_only
    type:
      - 'null'
      - boolean
    doc: set this flag to include only genomic chromosomes in the experiment and
      background.
    inputBinding:
      position: 102
      prefix: --genomic_only
  - id: log_level
    type:
      - 'null'
      - string
    doc: log level
    inputBinding:
      position: 102
      prefix: --log_level
  - id: promoter_data_path
    type: File
    doc: path to the promoter data file.
    inputBinding:
      position: 102
      prefix: --promoter_data_path
  - id: promoter_orig_chr_convention
    type: string
    doc: the chromosome naming convention used in the promoter data file.
    inputBinding:
      position: 102
      prefix: --promoter_orig_chr_convention
  - id: pseudocount
    type:
      - 'null'
      - float
    doc: pseudocount to use when calculating poisson pvalue. Note that this is 
      used only when the background hops are 0 for a given promoter.
    inputBinding:
      position: 102
      prefix: --pseudocount
  - id: unified_chr_convention
    type:
      - 'null'
      - string
    doc: the chromosome naming convention to use in the output DataFrame.
    inputBinding:
      position: 102
      prefix: --unified_chr_convention
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: path to the output file.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
