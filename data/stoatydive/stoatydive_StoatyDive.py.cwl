cwlVersion: v1.2
class: CommandLineTool
baseCommand: StoatyDive.py
label: stoatydive_StoatyDive.py
doc: "The tool can evalute the profile of peaks. Provide the peaks you want to evalutate
  in bed6 format and the reads\nyou used for the peak detection in bed or bam format.
  The user obtains a distributions of the coefficient of variation (CV)\nwhich can
  be used to evaluate the profile landscape. In addition, the tool generates ranked
  list for the peaks based\non the CV. The table hast the following columns: Chr Start
  End ID VC Strand bp r p Max_Norm_VC\nLeft_Border_Center_Difference Right_Border_Center_Difference.
  See StoatyDive's development page for a detailed description.\n\nTool homepage:
  https://github.com/heylf/StoatyDive"
inputs:
  - id: border_penalty
    type:
      - 'null'
      - boolean
    doc: Adds a penalty for non-centered peaks.
    inputBinding:
      position: 101
      prefix: --border_penalty
  - id: chr_file
    type: File
    doc: Path to the chromosome length file.
    inputBinding:
      position: 101
      prefix: --chr_file
  - id: input_bam
    type: File
    doc: "Path to the read file used for the peak calling in bed\nor bam format."
    inputBinding:
      position: 101
      prefix: --input_bam
  - id: input_bed
    type: File
    doc: Path to the peak file in bed6 format.
    inputBinding:
      position: 101
      prefix: --input_bed
  - id: lam
    type:
      - 'null'
      - float
    doc: "Parameter for the peak profile classification. Set\nlambda for the smoothing
      of the peak profiles. A\nhigher value (> default) will underfit. A lower value\n\
      (< default) will overfit."
    inputBinding:
      position: 101
      prefix: --lam
  - id: max_norm_value
    type:
      - 'null'
      - float
    doc: "Provide a maximum value for CV to make the normalized\nCV plot more comparable."
    inputBinding:
      position: 101
      prefix: --max_norm_value
  - id: max_translocate
    type:
      - 'null'
      - boolean
    doc: "Set this flag if you want to shift the peak profiles\nbased on the maximum
      value inside the profile instead\nof a Gaussian blur translocation."
    inputBinding:
      position: 101
      prefix: --max_translocate
  - id: maxcl
    type:
      - 'null'
      - int
    doc: "Maximal number of clusters of the kmeans clustering of\nthe peak profiles.
      The algorithm will be optimized,\ni.e., the parameter is just a constraint and
      not\nabsolute."
    inputBinding:
      position: 101
      prefix: --maxcl
  - id: numcl
    type:
      - 'null'
      - int
    doc: "You can forcefully set the number of cluster of peak\nprofiles."
    inputBinding:
      position: 101
      prefix: --numcl
  - id: peak_correction
    type:
      - 'null'
      - boolean
    doc: "Activate peak correction. The peaks are recentered\n(shifted) for the correct
      sumit."
    inputBinding:
      position: 101
      prefix: --peak_correction
  - id: peak_length
    type:
      - 'null'
      - int
    doc: Set maximum peak length for the constant peak length.
    inputBinding:
      position: 101
      prefix: --peak_length
  - id: scale_max
    type:
      - 'null'
      - float
    doc: Provide a maximum value for the CV plot.
    inputBinding:
      position: 101
      prefix: --scale_max
  - id: sm
    type:
      - 'null'
      - boolean
    doc: "Turn on the peak profile smoothing for the peak\nprofile classification.
      It is recommended to turn it\non."
    inputBinding:
      position: 101
      prefix: --sm
  - id: thresh
    type:
      - 'null'
      - float
    doc: "Set a normalized CV threshold to divide the peak\nprofiles into more specific
      (0) and more unspecific\n(1)."
    inputBinding:
      position: 101
      prefix: --thresh
  - id: turn_off_classification
    type:
      - 'null'
      - boolean
    doc: Turn off the peak profile classification.
    inputBinding:
      position: 101
      prefix: --turn_off_classification
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Write results to this path.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stoatydive:1.1.1--pyh5e36f6f_0
