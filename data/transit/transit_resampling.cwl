cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transit
  - resampling
label: transit_resampling
doc: "Permutation test (resampling) for conditional essentiality between a control and an experimental condition. Use either the wig-file mode or the combined-wig mode (combined_wig_file, samples_metadata_file and the two condition names).\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: control_files
    type: File[]?
    doc: "Comma-separated .wig control files (wig-file mode)"
    inputBinding:
      position: 1
      itemSeparator: ','
  - id: combined_wig_file
    type: ['null', File]
    doc: "Combined wig file (combined-wig mode)"
    inputBinding:
      position: 1
      prefix: -c
  - id: experimental_files
    type: File[]?
    doc: "Comma-separated .wig experimental files (wig-file mode)"
    inputBinding:
      position: 2
      itemSeparator: ','
  - id: samples_metadata_file
    type: ['null', File]
    doc: "Samples metadata file (combined-wig mode)"
    inputBinding:
      position: 2
  - id: ctrl_condition_name
    type: ['null', string]
    doc: "Control condition name; must match a Condition name in the samples_metadata file (combined-wig mode)"
    inputBinding:
      position: 3
  - id: exp_condition_name
    type: ['null', string]
    doc: "Experimental condition name; must match a Condition name in the samples_metadata file (combined-wig mode)"
    inputBinding:
      position: 4
  - id: annotation_file
    type: File
    doc: "Annotation .prot_table or GFF3 file"
    inputBinding:
      position: 5
  - id: output_filename
    type: string
    doc: "Output file name"
    inputBinding:
      position: 6
  - id: number_of_samples
    type: ['null', int]
    doc: "Number of samples. Default: 10000"
    inputBinding:
      position: 20
      prefix: -s
  - id: normalization_method
    type: ['null', string]
    doc: "Normalization method. Default: TTR"
    inputBinding:
      position: 20
      prefix: -n
  - id: output_histogram
    type: ['null', boolean]
    doc: "Output histogram of the permutations for each gene. Default: Turned Off."
    inputBinding:
      position: 20
      prefix: -h
  - id: adaptive_resampling
    type: ['null', boolean]
    doc: "Perform adaptive resampling. Default: Turned Off."
    inputBinding:
      position: 20
      prefix: -a
  - id: exclude_zero_rows
    type: ['null', boolean]
    doc: "Exclude rows with zero across conditions. Default: Turned off (i.e. include rows with zeros)."
    inputBinding:
      position: 20
      prefix: -ez
  - id: pseudocounts
    type: ['null', float]
    doc: "Pseudocounts used in calculating LFC. Default: 1"
    inputBinding:
      position: 20
      prefix: -PC
  - id: loess_correction
    type: ['null', boolean]
    doc: "Perform LOESS Correction; Helps remove possible genomic position bias. Default: Turned Off."
    inputBinding:
      position: 20
      prefix: -l
  - id: ignore_n_terminus_percentage
    type: ['null', int]
    doc: "Ignore TAs occuring within given percentage (as integer) of the N terminus. Default: 0"
    inputBinding:
      position: 20
      prefix: -iN
  - id: ignore_c_terminus_percentage
    type: ['null', int]
    doc: "Ignore TAs occuring within given percentage (as integer) of the C terminus. Default: 0"
    inputBinding:
      position: 20
      prefix: -iC
  - id: control_library_order
    type: ['null', string]
    doc: "String of letters representing library of control files in order e.g. 'AABB'. Letters used must also be used in --exp_lib. If non-empty, resampling will limit permutations to within-libraries."
    inputBinding:
      position: 20
      prefix: --ctrl_lib
  - id: experimental_library_order
    type: ['null', string]
    doc: "String of letters representing library of experimental files in order e.g. 'ABAB'. Letters used must also be used in --ctrl_lib. If non-empty, resampling will limit permutations to within-libraries."
    inputBinding:
      position: 20
      prefix: --exp_lib
  - id: winsorize_counts
    type: ['null', boolean]
    doc: "Winsorize insertion counts for each gene in each condition (replace max cnt in each gene with 2nd highest; helps mitigate effect of outliers)"
    inputBinding:
      position: 20
      prefix: -winz
  - id: site_restricted_resampling
    type: ['null', boolean]
    doc: "Site-restricted resampling; more sensitive, might find a few more significant conditionally essential genes"
    inputBinding:
      position: 20
      prefix: -sr
outputs:
  - id: output_file
    type: File
    doc: "Output file"
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
