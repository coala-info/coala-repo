cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run_dbcan
  - Pfam_null_cgc
label: dbcan_Pfam_null_cgc
doc: "identify CAZyme Gene Clusters(CGCs)\n\nTool homepage: http://bcb.unl.edu/dbCAN2/"
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
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads"
    inputBinding:
      position: 102
      prefix: --threads
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
  - id: null_from_gff
    type:
      - 'null'
      - boolean
    doc: "Extract null genes from cgc.gff instead of cgc_standard_out.tsv"
    inputBinding:
      position: 102
      prefix: --null_from_gff
  - id: coverage_threshold_pfam
    type:
      - 'null'
      - float
    doc: "Coverage threshold for Pfam HMMER"
    inputBinding:
      position: 102
      prefix: --coverage_threshold_pfam
  - id: e_value_threshold_pfam
    type:
      - 'null'
      - float
    doc: "E-value threshold for Pfam HMMER"
    inputBinding:
      position: 102
      prefix: --e_value_threshold_pfam
  - id: run_pfam
    type:
      - 'null'
      - boolean
    doc: "Run Pfam HMMER for CGC null gene annotation"
    inputBinding:
      position: 102
      prefix: --run_pfam
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
