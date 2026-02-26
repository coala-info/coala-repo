cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python3
  - /usr/local/bin/transit
  - resampling
label: transit_resampling
doc: "Performs resampling for differential analysis of transit data.\n\nTool homepage:
  http://github.com/mad-lab/transit"
inputs:
  - id: control_files
    type:
      type: array
      items: File
    doc: Comma-separated .wig control files
    inputBinding:
      position: 1
  - id: experimental_files
    type:
      type: array
      items: File
    doc: Comma-separated .wig experimental files
    inputBinding:
      position: 2
  - id: annotation_file
    type: File
    doc: Annotation .prot_table or GFF3 file
    inputBinding:
      position: 3
  - id: adaptive_resampling
    type:
      - 'null'
      - boolean
    doc: Perform adaptive resampling
    default: false
    inputBinding:
      position: 104
      prefix: -a
  - id: annotation_prot_table
    type: File
    doc: Annotation .prot_table file
    inputBinding:
      position: 104
      prefix: -c
  - id: combined_wig_file
    type: File
    doc: Combined wig file
    inputBinding:
      position: 104
      prefix: -c
  - id: control_library_order
    type:
      - 'null'
      - string
    doc: String of letters representing library of control files in order (e.g.,
      'AABB'). Letters used must also be used in --exp_lib. If non-empty, 
      resampling will limit permutations to within-libraries.
    default: ''
    inputBinding:
      position: 104
      prefix: --ctrl_lib
  - id: ctrl_condition_name
    type: string
    doc: Control condition name
    inputBinding:
      position: 104
      prefix: -c
  - id: exclude_zero_rows
    type:
      - 'null'
      - boolean
    doc: Exclude rows with zero across conditions (include rows with zeros by 
      default)
    default: false
    inputBinding:
      position: 104
      prefix: -ez
  - id: exp_condition_name
    type: string
    doc: Experimental condition name
    inputBinding:
      position: 104
      prefix: -c
  - id: experimental_library_order
    type:
      - 'null'
      - string
    doc: String of letters representing library of experimental files in order 
      (e.g., 'ABAB'). Letters used must also be used in --ctrl_lib. If 
      non-empty, resampling will limit permutations to within-libraries.
    default: ''
    inputBinding:
      position: 104
      prefix: --exp_lib
  - id: ignore_c_terminus_percentage
    type:
      - 'null'
      - int
    doc: Ignore TAs occurring within given percentage (as integer) of the C 
      terminus
    default: 0
    inputBinding:
      position: 104
      prefix: -iC
  - id: ignore_n_terminus_percentage
    type:
      - 'null'
      - int
    doc: Ignore TAs occurring within given percentage (as integer) of the N 
      terminus
    default: 0
    inputBinding:
      position: 104
      prefix: -iN
  - id: loess_correction
    type:
      - 'null'
      - boolean
    doc: Perform LOESS Correction; Helps remove possible genomic position bias
    default: false
    inputBinding:
      position: 104
      prefix: -l
  - id: normalization_method
    type:
      - 'null'
      - string
    doc: Normalization method
    default: TTR
    inputBinding:
      position: 104
      prefix: -n
  - id: number_of_samples
    type:
      - 'null'
      - int
    doc: Number of samples
    default: 10000
    inputBinding:
      position: 104
      prefix: -s
  - id: output_histogram
    type:
      - 'null'
      - boolean
    doc: Output histogram of the permutations for each gene
    default: false
    inputBinding:
      position: 104
      prefix: -h
  - id: pseudocounts
    type:
      - 'null'
      - float
    doc: Pseudocounts used in calculating LFC
    default: 1.0
    inputBinding:
      position: 104
      prefix: -PC
  - id: samples_metadata_file
    type: File
    doc: Samples metadata file
    inputBinding:
      position: 104
      prefix: -c
  - id: site_restricted_resampling
    type:
      - 'null'
      - boolean
    doc: Site-restricted resampling; more sensitive, might find a few more 
      significant conditionally essential genes
    inputBinding:
      position: 104
      prefix: -sr
  - id: winsorize_counts
    type:
      - 'null'
      - boolean
    doc: Winsorize insertion counts for each gene in each condition (replace max
      cnt in each gene with 2nd highest; helps mitigate effect of outliers)
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
