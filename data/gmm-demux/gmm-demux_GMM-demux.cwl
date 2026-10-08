cwlVersion: v1.2
class: CommandLineTool
baseCommand: GMM-demux
label: gmm-demux_GMM-demux
doc: "GMM-Demux Initialization\n\nTool homepage: https://github.com/CHPGenetics/GMM-demux"
inputs:
  - id: input_path
    type:
      - 'null'
      - Directory
      - File
    doc: The input path of mtx files from cellRanger pipeline (a Directory), or
      the csv file when csv is set. Not needed with skip.
    inputBinding:
      position: 1
  - id: hto_array
    type:
      - 'null'
      - string
    doc: Names of the HTO tags, separated by ',' without spaces (for example 
      HTO_1,HTO_2,HTO_3). Not needed with skip.
    inputBinding:
      position: 2
  - id: ambiguous
    type:
      - 'null'
      - float
    doc: The estimated chance of having a phony GEM getting included in a pure 
      type GEM cluster by the clustering algorithm. Requires a float in (0, 1). 
      Only executes if -e executes.
    inputBinding:
      position: 103
      prefix: --ambiguous
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Take input in csv format, instead of mmx format.
    inputBinding:
      position: 103
      prefix: --csv
  - id: examine
    type:
      - 'null'
      - File
    doc: Provide the cell list. Requires a file argument. Only executes if -u is
      set.
    inputBinding:
      position: 103
      prefix: --examine
  - id: extract
    type:
      - 'null'
      - string
    doc: Names of the HTO tag(s) to extract, separated by ','. Joint HTO samples
      are combined with '+', such as 'HTO_1+HTO_2'.
    inputBinding:
      position: 103
      prefix: --extract
  - id: full
    type:
      - 'null'
      - string
    doc: Generate the full classification report. Requires a path argument.
    inputBinding:
      position: 103
      prefix: --full
  - id: random_seed
    type:
      - 'null'
      - int
    doc: If provided, this is passed to the GaussianMixture random_state 
      parameter.
    inputBinding:
      position: 103
      prefix: --random_seed
  - id: report
    type:
      - 'null'
      - string
    doc: Store the data summary report. Requires a file argument. Only executes 
      if -u is set.
    inputBinding:
      position: 103
      prefix: --report
  - id: simplified
    type:
      - 'null'
      - string
    doc: Generate the simplified classification report. Requires a path 
      argument.
    inputBinding:
      position: 103
      prefix: --simplified
  - id: skip
    type:
      - 'null'
      - Directory
    doc: Load a full classification report and skip the mtx folder. Requires a 
      path argument to the full report folder. When specified, the user no 
      longer needs to provide the mtx folder.
    inputBinding:
      position: 103
      prefix: --skip
  - id: summary
    type:
      - 'null'
      - int
    doc: Generate the statstic summary of the dataset. Including MSM, SSM rates.
      Requires an estimated total number of cells in the assay as input.
    inputBinding:
      position: 103
      prefix: --summary
  - id: threshold
    type:
      - 'null'
      - float
    doc: Provide the confidence threshold value. Requires a float in (0,1).
    inputBinding:
      position: 103
      prefix: --threshold
  - id: output_path
    type:
      - 'null'
      - string
    doc: The path for storing the Same-Sample-Droplets (SSDs).
    inputBinding:
      position: 104
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type:
      - 'null'
      - Directory
    doc: The path for storing the Same-Sample-Droplets (SSDs). SSDs are stored 
      in mtx format. Requires a path argument.
    outputBinding:
      glob: "$(inputs.output_path ? inputs.output_path : 'SSD_mtx')"
  - id: full_report
    type:
      - 'null'
      - Directory
    doc: Full classification report folder (written when full is set)
    outputBinding:
      glob: "$(inputs.full ? inputs.full : 'no_full_report')"
  - id: simplified_report
    type:
      - 'null'
      - Directory
    doc: Simplified classification report folder (written when simplified is 
      set)
    outputBinding:
      glob: "$(inputs.simplified ? inputs.simplified : 'no_simplified_report')"
  - id: summary_report
    type:
      - 'null'
      - File
    doc: Data summary report file (written when summary and report are set)
    outputBinding:
      glob: "$(inputs.report ? inputs.report : 'no_summary_report')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmm-demux:0.2.2.3--pyh7e72e81_1
stdout: gmm-demux.out
