cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run_dbcan
  - substrate_prediction
label: dbcan_substrate_prediction
doc: "Predict the substrates of CAZyme gene clusters (CGCs) found by an earlier run_dbcan step, using dbCAN-PUL and dbCAN-sub.\n\nTool homepage: http://bcb.unl.edu/dbCAN2/"
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
    doc: "database folder [required]"
    inputBinding:
      position: 102
      prefix: --db_dir
  - id: odbcanpul
    type:
      - 'null'
      - boolean
    doc: "export dbcan pul sub result"
    inputBinding:
      position: 102
      prefix: --odbcanpul
  - id: odbcan_sub
    type:
      - 'null'
      - string
    doc: "export dbcan-sub sub result"
    inputBinding:
      position: 102
      prefix: --odbcan_sub
  - id: env
    type:
      - 'null'
      - string
    doc: "run environment"
    inputBinding:
      position: 102
      prefix: --env
  - id: rerun
    type:
      - 'null'
      - boolean
    doc: "re run the prediction"
    inputBinding:
      position: 102
      prefix: --rerun
  - id: workdir
    type:
      - 'null'
      - string
    doc: "work directory"
    inputBinding:
      position: 102
      prefix: --workdir
  - id: out
    type:
      - 'null'
      - string
    doc: "substrate prediction result"
    inputBinding:
      position: 102
      prefix: --out
  - id: pul
    type:
      - 'null'
      - File
    doc: "dbCAN-PUL PUL.faa"
    inputBinding:
      position: 102
      prefix: --pul
  - id: mode
    type: string
    doc: "Mode of input sequence [required]"
    inputBinding:
      position: 102
      prefix: --mode
  - id: output_dir
    type: string
    doc: "Directory for the output files [required]"
    inputBinding:
      position: 102
      prefix: --output_dir
  - id: input_raw_data
    type: File
    doc: "Path to the input raw data [required]"
    inputBinding:
      position: 102
      prefix: --input_raw_data
  - id: evalue_cutoff
    type:
      - 'null'
      - float
    doc: "evalue"
    inputBinding:
      position: 102
      prefix: --evalue_cutoff
  - id: bitscore_cutoff
    type:
      - 'null'
      - float
    doc: "bit score"
    inputBinding:
      position: 102
      prefix: --bitscore_cutoff
  - id: coverage_cutoff
    type:
      - 'null'
      - float
    doc: "coverage"
    inputBinding:
      position: 102
      prefix: --coverage_cutoff
  - id: identity_cutoff
    type:
      - 'null'
      - float
    doc: "identity"
    inputBinding:
      position: 102
      prefix: --identity_cutoff
  - id: extra_pair_type_num
    type:
      - 'null'
      - string
    doc: "extra pair number"
    inputBinding:
      position: 102
      prefix: --extra_pair_type_num
  - id: extra_pair_type
    type:
      - 'null'
      - string
    doc: "extra pair type"
    inputBinding:
      position: 102
      prefix: --extra_pair_type
  - id: total_pair_num
    type:
      - 'null'
      - int
    doc: "total pair number"
    inputBinding:
      position: 102
      prefix: --total_pair_num
  - id: CAZyme_pair_num
    type:
      - 'null'
      - int
    doc: "num of CAZyme"
    inputBinding:
      position: 102
      prefix: --CAZyme_pair_num
  - id: uniq_query_cgc_gene_num
    type:
      - 'null'
      - int
    doc: "num of uniq gene hit of cgc"
    inputBinding:
      position: 102
      prefix: --uniq_query_cgc_gene_num
  - id: uniq_pul_gene_hit_num
    type:
      - 'null'
      - int
    doc: "num of uniq gene hit of pul"
    inputBinding:
      position: 102
      prefix: --uniq_pul_gene_hit_num
  - id: substrate_scors
    type:
      - 'null'
      - int
    doc: "substrate score"
    inputBinding:
      position: 102
      prefix: --substrate_scors
  - id: num_of_protein_substrate_cutoff
    type:
      - 'null'
      - int
    doc: "num of protein substrate"
    inputBinding:
      position: 102
      prefix: --num_of_protein_substrate_cutoff
  - id: num_of_domains_substrate_cutoff
    type:
      - 'null'
      - int
    doc: "num of domains substrate"
    inputBinding:
      position: 102
      prefix: --num_of_domains_substrate_cutoff
  - id: hmmevalue
    type:
      - 'null'
      - float
    doc: "HMM evalue"
    inputBinding:
      position: 102
      prefix: --hmmevalue
  - id: hmmcov
    type:
      - 'null'
      - float
    doc: "hmm coverage"
    inputBinding:
      position: 102
      prefix: --hmmcov
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
