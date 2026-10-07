cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run_dbcan
  - gff_process
label: dbcan_gff_process
doc: "Generate GFF for CGC identification. need --input_gff when --input_raw_data is protein sequence. if --input_gff is not provided, will set default <output_dir>/uniInput.gff.\n\nTool homepage: http://bcb.unl.edu/dbCAN2/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - |-
        ${ if (inputs.input_dir) { return [{"entry": inputs.input_dir, "entryname": inputs.output_dir, "writable": true}]; } return []; }
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable verbose logging (equivalent to --log-level DEBUG)"
    inputBinding:
      position: 102
      prefix: --verbose
  - id: log_file
    type:
      - 'null'
      - string
    doc: "Write logs to file in addition to console"
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Set logging level (default: WARNING, only shows warnings and errors) (one of DEBUG, INFO, WARNING, ERROR, CRITICAL)"
    inputBinding:
      position: 102
      prefix: --log-level
  - id: db_dir
    type: Directory
    doc: "Directory for the database [required]"
    inputBinding:
      position: 102
      prefix: --db_dir
  - id: output_dir
    type: string
    doc: "Directory for the output files [required]"
    inputBinding:
      position: 102
      prefix: --output_dir
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads"
    inputBinding:
      position: 102
      prefix: --threads
  - id: coverage_threshold_stp
    type:
      - 'null'
      - float
    doc: "Coverage threshold for STP HMMER"
    inputBinding:
      position: 102
      prefix: --coverage_threshold_stp
  - id: e_value_threshold_stp
    type:
      - 'null'
      - float
    doc: "E-value threshold for STP HMMER"
    inputBinding:
      position: 102
      prefix: --e_value_threshold_stp
  - id: fungi
    type:
      - 'null'
      - boolean
    doc: "Enable fungi mode for TF HMMER"
    inputBinding:
      position: 102
      prefix: --fungi
  - id: no_fungi
    type:
      - 'null'
      - boolean
    doc: "Turn off: Enable fungi mode for TF HMMER"
    inputBinding:
      position: 102
      prefix: --no-fungi
  - id: coverage_threshold_tf
    type:
      - 'null'
      - float
    doc: "Coverage threshold for TF HMMER"
    inputBinding:
      position: 102
      prefix: --coverage_threshold_tf
  - id: e_value_threshold_tf
    type:
      - 'null'
      - float
    doc: "E-value threshold for TF HMMER"
    inputBinding:
      position: 102
      prefix: --e_value_threshold_tf
  - id: prokaryotic
    type:
      - 'null'
      - boolean
    doc: "Enable prokaryotic mode for TF"
    inputBinding:
      position: 102
      prefix: --prokaryotic
  - id: no_prokaryotic
    type:
      - 'null'
      - boolean
    doc: "Turn off: Enable prokaryotic mode for TF"
    inputBinding:
      position: 102
      prefix: --no-prokaryotic
  - id: coverage_threshold_tf_diamond
    type:
      - 'null'
      - float
    doc: "Coverage threshold for TF"
    inputBinding:
      position: 102
      prefix: --coverage_threshold_tf_diamond
  - id: e_value_threshold_tf_diamond
    type:
      - 'null'
      - float
    doc: "E-value threshold for TF"
    inputBinding:
      position: 102
      prefix: --e_value_threshold_tf_diamond
  - id: coverage_threshold_tc
    type:
      - 'null'
      - float
    doc: "Coverage threshold for TC"
    inputBinding:
      position: 102
      prefix: --coverage_threshold_tc
  - id: e_value_threshold_tc
    type:
      - 'null'
      - float
    doc: "E-value threshold for TC"
    inputBinding:
      position: 102
      prefix: --e_value_threshold_tc
  - id: coverage_threshold_sulfatase
    type:
      - 'null'
      - float
    doc: "Coverage threshold for Sulfatase"
    inputBinding:
      position: 102
      prefix: --coverage_threshold_sulfatase
  - id: e_value_threshold_sulfatase
    type:
      - 'null'
      - float
    doc: "E-value threshold for Sulfatase"
    inputBinding:
      position: 102
      prefix: --e_value_threshold_sulfatase
  - id: coverage_threshold_peptidase
    type:
      - 'null'
      - float
    doc: "Coverage threshold for Peptidase"
    inputBinding:
      position: 102
      prefix: --coverage_threshold_peptidase
  - id: e_value_threshold_peptidase
    type:
      - 'null'
      - float
    doc: "E-value threshold for Peptidase"
    inputBinding:
      position: 102
      prefix: --e_value_threshold_peptidase
  - id: gff_type
    type:
      - 'null'
      - string
    doc: "GFF file type. Auto-set to prodigal when --mode != protein"
    inputBinding:
      position: 102
      prefix: --gff_type
  - id: input_gff
    type:
      - 'null'
      - File
    doc: "Input GFF file. When --mode != protein this is auto-set to <output_dir>/uniInput.gff"
    inputBinding:
      position: 102
      prefix: --input_gff
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: "Results folder of an earlier run_dbcan step; it is copied (writable) to --output_dir so this step can read and add to it"
outputs:
  - id: output
    type: Directory
    doc: Output folder
    outputBinding:
      glob: $(inputs.output_dir)
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
