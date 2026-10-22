cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python
  - -m
  - tracegroomer
label: tracegroomer
doc: "A tool for grooming and normalizing labeled metabolomics data.\n\nTool homepage:
  https://github.com/cbib/TraceGroomer"
inputs:
  - id: alternative_div_amount_material
    type:
      - 'null'
      - boolean
    doc: When dividing values by the amount of material, also multiplies by 
      'mean(amountMaterial)' to stay in abundance units
    inputBinding:
      position: 101
      prefix: --alternative_div_amount_material
  - id: amount_material_path
    type:
      - 'null'
      - File
    doc: absolute path to the file having the amount of material (number of 
      cells, tissue weight, etc) by sample, for the normalization
    inputBinding:
      position: 101
      prefix: --amountMaterial_path
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file given as absolute path
    inputBinding:
      position: 101
      prefix: --config_file
  - id: div_isotopologues_by_amount_material
    type:
      - 'null'
      - boolean
    doc: Apply normalization by the amount of material, at the level of 
      isotopologue absolute values. After this, re-computes all derived metrics.
      If False, only total abundances are normalized
    inputBinding:
      position: 101
      prefix: --div_isotopologues_by_amount_material
  - id: fractions_stomp_values
    type:
      - 'null'
      - boolean
    doc: 'Stomps fractional contributions (synonym: mean enrichment), and isotopologue
      proportions, to max 1.0 and min 0.0'
    inputBinding:
      position: 101
      prefix: --fractions_stomp_values
  - id: isosprop_min_admitted
    type:
      - 'null'
      - float
    doc: Metabolites whose isotopologues proportions are less or equal to this 
      cutoff, are removed
    inputBinding:
      position: 101
      prefix: --isosprop_min_admitted
  - id: isotopologues_preview
    type:
      - 'null'
      - boolean
    doc: Plot isotopologue values, as given
    inputBinding:
      position: 101
      prefix: --isotopologues_preview
  - id: labeled_metabo_file
    type:
      - 'null'
      - File
    doc: Labeled metabolomics input file, absolute path
    inputBinding:
      position: 101
      prefix: --labeled_metabo_file
  - id: remove_these_metabolites
    type:
      - 'null'
      - File
    doc: 'Absolute path to the file with columns: compartment, metabolite; listing
      the metabolites to be completely excluded'
    inputBinding:
      position: 101
      prefix: --remove_these_metabolites
  - id: subtract_blankavg
    type:
      - 'null'
      - boolean
    doc: On VIB results. From samples' abundances, subtracts the average of the 
      blanks
    inputBinding:
      position: 101
      prefix: --subtract_blankavg
  - id: type_of_file
    type:
      - 'null'
      - string
    doc: 'One of the following: IsoCor_out_tsv|rule_tsv|VIBMEC_xlsx|generic_xlsx'
    inputBinding:
      position: 101
      prefix: --type_of_file
  - id: under_detection_limit_set_nan
    type:
      - 'null'
      - boolean
    doc: On VIB results. Any abundance < LOD (Limit Of Detection), is set as NaN
    inputBinding:
      position: 101
      prefix: --under_detection_limit_set_nan
  - id: use_internal_standard
    type:
      - 'null'
      - string
    doc: 'Internal Standard for performing the division: total_abundances/internal_standard,
      example: --use_internal_standard Myristic_acid_d27.'
    inputBinding:
      position: 101
      prefix: --use_internal_standard
  - id: no_alternative_div_amount_material
    type:
      - 'null'
      - boolean
    doc: "Turn off also multiplying by mean(amountMaterial) when dividing by the amount of material"
    inputBinding:
      position: 101
      prefix: --no-alternative_div_amount_material
  - id: no_div_isotopologues_by_amount_material
    type:
      - 'null'
      - boolean
    doc: "Turn off normalization by the amount of material at the isotopologue level (only total abundances are normalized)"
    inputBinding:
      position: 101
      prefix: --no-div_isotopologues_by_amount_material
  - id: no_isotopologues_preview
    type:
      - 'null'
      - boolean
    doc: Do not plot isotopologue values (default)
    inputBinding:
      position: 101
      prefix: --no-isotopologues_preview
  - id: no_fractions_stomp_values
    type:
      - 'null'
      - boolean
    doc: "Turn off stomping of fractional contributions and isotopologue proportions to the range 0.0 to 1.0"
    inputBinding:
      position: 101
      prefix: --no-fractions_stomp_values
  - id: no_under_detection_limit_set_nan
    type:
      - 'null'
      - boolean
    doc: "Turn off setting abundances below the limit of detection to NaN"
    inputBinding:
      position: 101
      prefix: --no-under_detection_limit_set_nan
  - id: no_subtract_blankavg
    type:
      - 'null'
      - boolean
    doc: "Turn off subtracting the average of the blanks"
    inputBinding:
      position: 101
      prefix: --no-subtract_blankavg
  - id: output_files_extension
    type:
      - 'null'
      - string
    doc: 'Extension for the output files, must be one of the following: csv|tsv|txt
      (default csv)'
    inputBinding:
      position: 101
      prefix: --output_files_extension
  - id: extra_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the configuration file (for example the sample metadata file)
      that must sit in the working directory
outputs:
  - id: groomed_files
    type:
      type: array
      items: File
    doc: Groomed and normalized tables, written as <name>.<extension>
    outputBinding:
      glob: "$('*.' + (inputs.output_files_extension ? inputs.output_files_extension : 'csv'))"
      outputEval: |
        ${
          var staged = (inputs.extra_files || []).map(function(f) { return f.basename; });
          return self.filter(function(f) { return staged.indexOf(f.basename) < 0; });
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.extra_files ? inputs.extra_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracegroomer:0.1.4--pyhdfd78af_0
