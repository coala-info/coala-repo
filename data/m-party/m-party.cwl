cwlVersion: v1.2
class: CommandLineTool
baseCommand: m-party
label: m-party
doc: "PlastEDMA's main script\n\nTool homepage: https://github.com/ozefreitas/M-PARTY"
inputs:
  - id: concat_hmm_models
    type:
      - 'null'
      - boolean
    doc: concatenate HMM models into a single file
    inputBinding:
      position: 101
      prefix: --concat_hmm_models
  - id: config_file
    type:
      - 'null'
      - File
    doc: user defined config file. Only recommended for advanced users. Defaults
      to 'config.yaml'. If given, overrides config file construction from input
    inputBinding:
      position: 101
      prefix: --config_file
  - id: database
    type:
      - 'null'
      - File
    doc: FASTA database to run against the also user inputted sequences. DIAMOND
      is performed in order to expand the data and build the models. PlastEDMA 
      has no in-built database for this matter. If flag is given, download of 
      the default database will start and model built from that. Defaults to 
      UniProt DataBase.
    inputBinding:
      position: 101
      prefix: --database
  - id: display_config
    type:
      - 'null'
      - boolean
    doc: declare to output the written config file together with results. Useful
      in case of debug
    inputBinding:
      position: 101
      prefix: --display_config
  - id: hmm_db_name
    type:
      - 'null'
      - string
    doc: name to be assigned to the hmm database to be created. Its recomended 
      to give a name that that describes the family or other characteristic of 
      the given sequences
    inputBinding:
      position: 101
      prefix: --hmm_db_name
  - id: hmm_models
    type:
      - 'null'
      - Directory
    doc: path to a directory containing HMM models previously created by the 
      user. By default PlastEDMA uses the built-in HMMs from database in 
      'resources/Data/HMMs/After_tcoffee_UPI/'
    inputBinding:
      position: 101
      prefix: --hmm_models
  - id: hmms_output_type
    type:
      - 'null'
      - string
    doc: chose output type of hmmsearch run from 'out', 'tsv' or 'pfam' format. 
      Defaults to 'tsv'
    inputBinding:
      position: 101
      prefix: --hmms_output_type
  - id: input
    type:
      - 'null'
      - File
    doc: input FASTA file containing a list of protein sequences to be analysed
    inputBinding:
      position: 101
      prefix: --input
  - id: input_seqs_db_const
    type:
      - 'null'
      - File
    doc: input a FASTA file with a set of sequences from which the user wants to
      create the HMM database from scratch
    inputBinding:
      position: 101
      prefix: --input_seqs_db_const
  - id: input_type
    type:
      - 'null'
      - string
    doc: specifies the nature of the sequences in the input file between 
      'protein', 'nucleic' or 'metagenome'. Defaults to 'protein'
    inputBinding:
      position: 101
      prefix: --input_type
  - id: negative_db
    type:
      - 'null'
      - File
    doc: path to a user defined negative control database. Default use of human 
      gut microbiome
    inputBinding:
      position: 101
      prefix: --negative_db
  - id: output
    type:
      - 'null'
      - Directory
    doc: name for the output directory. Defaults to 'PlastEDMA_results'
    inputBinding:
      position: 101
      prefix: --output
  - id: output_type
    type:
      - 'null'
      - string
    doc: choose report table outpt format from 'tsv', 'csv' or 'excel'. Defaults
      to 'tsv'
    inputBinding:
      position: 101
      prefix: --output_type
  - id: produce_inter_tables
    type:
      - 'null'
      - boolean
    doc: call if user wants to save intermediate tables as parseale .csv files 
      (tables from hmmsearch results processing)
    inputBinding:
      position: 101
      prefix: --produce_inter_tables
  - id: report_text
    type:
      - 'null'
      - boolean
    doc: decides whether to produce or not a friendly report in txt format with 
      easy to read information
    inputBinding:
      position: 101
      prefix: --report_text
  - id: snakefile
    type:
      - 'null'
      - File
    doc: user defined snakemake workflow Snakefile. Defaults to 
      '/workflow/Snakefile
    inputBinding:
      position: 101
      prefix: --snakefile
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads for Snakemake to use. Defaults to 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: could be required after forced workflow termination
    inputBinding:
      position: 101
      prefix: --unlock
  - id: validation
    type:
      - 'null'
      - boolean
    doc: decides whether to perform models validation and filtration with the 
      'leave-one-out' cross validation methods. Call to set to True. Defaults to
      False
    inputBinding:
      position: 101
      prefix: --validation
  - id: workflow
    type:
      - 'null'
      - string
    doc: defines the workflow to follow, between "annotation", 
      "database_construction" and "both". Latter keyword makes the database 
      construction first and posterior annotation. Defaults to "annotation"
    inputBinding:
      position: 101
      prefix: --workflow
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/m-party:0.2.2--hdfd78af_0
stdout: m-party.out
