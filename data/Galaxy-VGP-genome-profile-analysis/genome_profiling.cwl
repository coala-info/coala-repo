class: Workflow
cwlVersion: v1.2.0-dev2
doc: 'Abstract CWL Automatically generated from the Galaxy workflow file: VGP genome
  profile analysis'
inputs:
  Collection of Pacbio Data:
    doc: Collection of Pacbio Data in fastq format.
    format: data
    type: File
outputs: {}
steps:
  1_Input parameter:
    in: {}
    out: []
    run:
      class: Operation
      id: null
      inputs: {}
      outputs: {}
  2_Input parameter:
    in: {}
    out: []
    run:
      class: Operation
      id: null
      inputs: {}
      outputs: {}
  3_Meryl:
    in:
      operation_type|input_reads: Collection of Pacbio Data
      operation_type|options_kmer_size|input_kmer_size: 1_Input parameter/output
    out:
    - read_db
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_meryl_meryl_1_3+galaxy4
      inputs:
        operation_type|input_reads:
          format: Any
          type: File
        operation_type|options_kmer_size|input_kmer_size:
          format: Any
          type: File
      outputs:
        read_db:
          doc: meryldb
          type: File
  4_Meryl:
    in:
      operation_type|input_meryldb_02: 3_Meryl/read_db
    out:
    - read_db
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_meryl_meryl_1_3+galaxy4
      inputs:
        operation_type|input_meryldb_02:
          format: Any
          type: File
      outputs:
        read_db:
          doc: meryldb
          type: File
  5_Meryl:
    in:
      operation_type|input_meryldb_02: 4_Meryl/read_db
    out:
    - read_db_hist
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_meryl_meryl_1_3+galaxy4
      inputs:
        operation_type|input_meryldb_02:
          format: Any
          type: File
      outputs:
        read_db_hist:
          doc: tabular
          type: File
  6_GenomeScope:
    in:
      input: 5_Meryl/read_db_hist
      kmer_length: 1_Input parameter/output
      ploidy: 2_Input parameter/output
    out:
    - linear_plot
    - log_plot
    - transformed_linear_plot
    - transformed_log_plot
    - model
    - summary
    - model_params
    run:
      class: Operation
      id: toolshed_g2_bx_psu_edu_repos_iuc_genomescope_genomescope_2_0+galaxy1
      inputs:
        input:
          format: Any
          type: File
        kmer_length:
          format: Any
          type: File
        ploidy:
          format: Any
          type: File
      outputs:
        linear_plot:
          doc: png
          type: File
        log_plot:
          doc: png
          type: File
        model:
          doc: txt
          type: File
        model_params:
          doc: tabular
          type: File
        summary:
          doc: txt
          type: File
        transformed_linear_plot:
          doc: png
          type: File
        transformed_log_plot:
          doc: png
          type: File

