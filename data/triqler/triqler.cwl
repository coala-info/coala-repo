cwlVersion: v1.2
class: CommandLineTool
baseCommand: triqler
label: triqler
doc: "Triqler version 0.9.1\n\nTool homepage: https://github.com/statisticalbiotechnology/triqler"
inputs:
  - id: in_file
    type: string
    doc: List of PSMs with abundances (not log transformed!) and search engine 
      score. See README for a detailed description of the columns.
    inputBinding:
      position: 1
  - id: csv_field_size_limit
    type:
      - 'null'
      - string
    doc: Set a new maximum CSV field size
    default: None
    inputBinding:
      position: 102
      prefix: --csv-field-size-limit
  - id: decoy_pattern
    type:
      - 'null'
      - string
    doc: Prefix for decoy proteins.
    default: decoy_
    inputBinding:
      position: 102
      prefix: --decoy_pattern
  - id: fold_change_eval
    type:
      - 'null'
      - float
    doc: log2 fold change evaluation threshold.
    default: 1.0
    inputBinding:
      position: 102
      prefix: --fold_change_eval
  - id: min_samples
    type:
      - 'null'
      - int
    doc: Minimum number of samples a peptide needed to be quantified in.
    default: 2
    inputBinding:
      position: 102
      prefix: --min_samples
  - id: missing_value_prior
    type:
      - 'null'
      - string
    doc: Distribution to fit for missing value prior. Use "DIA" for using means 
      of NaNs to fit the censored normal distribution. The "default" option fits
      the censored normal distribution with all observed XIC values.
    default: default
    inputBinding:
      position: 102
      prefix: --missing_value_prior
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads, by default this is equal to the number of CPU cores 
      available on the device.
    default: 20
    inputBinding:
      position: 102
      prefix: --num_threads
  - id: protein_name_separator
    type:
      - 'null'
      - string
    doc: Separator used in tab delimited input and output for separating protein
      names.
    default: ''
    inputBinding:
      position: 102
      prefix: --protein_name_separator
  - id: ttest
    type:
      - 'null'
      - boolean
    doc: Use t-test for evaluating differential expression instead of posterior 
      probabilities.
    default: false
    inputBinding:
      position: 102
      prefix: --ttest
  - id: write_spectrum_quants
    type:
      - 'null'
      - boolean
    doc: Write quantifications for consensus spectra. Only works if consensus 
      spectrum index are given in input.
    default: false
    inputBinding:
      position: 102
      prefix: --write_spectrum_quants
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Path to output file (writing in TSV format). N.B. if more than 2 
      treatment groups are present, suffixes will be added before the file 
      extension.
    outputBinding:
      glob: $(inputs.out_file)
  - id: write_protein_posteriors
    type:
      - 'null'
      - File
    doc: Write raw data of protein posteriors to the specified file in TSV 
      format.
    outputBinding:
      glob: $(inputs.write_protein_posteriors)
  - id: write_group_posteriors
    type:
      - 'null'
      - File
    doc: Write raw data of treatment group posteriors to the specified file in 
      TSV format.
    outputBinding:
      glob: $(inputs.write_group_posteriors)
  - id: write_fold_change_posteriors
    type:
      - 'null'
      - File
    doc: Write raw data of fold change posteriors to the specified file in TSV 
      format.
    outputBinding:
      glob: $(inputs.write_fold_change_posteriors)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/triqler:0.9.1--pyhdfd78af_0
