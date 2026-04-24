cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pvacseq
  - run
label: pvacseq_run
doc: "Run the pVACseq pipeline to identify neoantigens from a VCF file.\n\nTool homepage:
  https://github.com/griffithlab/pVAC-Seq"
inputs:
  - id: input_file
    type: File
    doc: A VEP-annotated single-sample VCF containing transcript, Wildtype 
      protein sequence, and Downstream protein sequence information
    inputBinding:
      position: 1
  - id: sample_name
    type: string
    doc: The name of the sample being processed. This will be used as a prefix 
      for output files
    inputBinding:
      position: 2
  - id: allele
    type: string
    doc: Name of the allele to use for epitope prediction. Multiple alleles can 
      be specified using a comma-separated list.
    inputBinding:
      position: 3
  - id: prediction_algorithms
    type:
      type: array
      items: string
    doc: The epitope prediction algorithms to use (e.g., NetMHC, NetMHCpan, 
      etc.). Multiple algorithms can be specified, separated by spaces.
    inputBinding:
      position: 4
  - id: additional_input_file_list
    type:
      - 'null'
      - File
    doc: yaml file of additional files to be used as inputs, e.g. cufflinks 
      output files.
    inputBinding:
      position: 105
      prefix: --additional-input-file-list
  - id: additional_report_columns
    type:
      - 'null'
      - string
    doc: Additional columns to output in the final report
    inputBinding:
      position: 105
      prefix: --additional-report-columns
  - id: binding_threshold
    type:
      - 'null'
      - int
    doc: Report only epitopes where the mutant allele has ic50 binding scores 
      below this value.
    inputBinding:
      position: 105
      prefix: --binding-threshold
  - id: downstream_sequence_length
    type:
      - 'null'
      - string
    doc: Cap to limit the downstream sequence length for frameshifts when 
      creating the fasta file.
    inputBinding:
      position: 105
      prefix: --downstream-sequence-length
  - id: epitope_length
    type:
      - 'null'
      - string
    doc: Length of subpeptides (neoepitopes) to predict. Multiple lengths can be
      specified using a comma-separated list.
    inputBinding:
      position: 105
      prefix: --epitope-length
  - id: expn_val
    type:
      - 'null'
      - float
    doc: Gene and Transcript Expression cutoff. Sites above this cutoff will be 
      considered.
    inputBinding:
      position: 105
      prefix: --expn-val
  - id: fasta_size
    type:
      - 'null'
      - int
    doc: Number of fasta entries per IEDB request. Needs to be an even number.
    inputBinding:
      position: 105
      prefix: --fasta-size
  - id: iedb_install_directory
    type:
      - 'null'
      - Directory
    doc: Directory that contains the local installation of IEDB MHC I and/or MHC
      II
    inputBinding:
      position: 105
      prefix: --iedb-install-directory
  - id: iedb_retries
    type:
      - 'null'
      - int
    doc: Number of retries when making requests to the IEDB RESTful web 
      interface.
    inputBinding:
      position: 105
      prefix: --iedb-retries
  - id: keep_tmp_files
    type:
      - 'null'
      - boolean
    doc: Keep intermediate output files. This migt be useful for debugging 
      purposes.
    inputBinding:
      position: 105
      prefix: --keep-tmp-files
  - id: minimum_fold_change
    type:
      - 'null'
      - float
    doc: Minimum fold change between mutant binding score and wild-type score.
    inputBinding:
      position: 105
      prefix: --minimum-fold-change
  - id: net_chop_method
    type:
      - 'null'
      - string
    doc: NetChop prediction method to use ("cterm" for C term 3.0, "20s" for 20S
      3.0).
    inputBinding:
      position: 105
      prefix: --net-chop-method
  - id: net_chop_threshold
    type:
      - 'null'
      - float
    doc: NetChop prediction threshold.
    inputBinding:
      position: 105
      prefix: --net-chop-threshold
  - id: netmhc_stab
    type:
      - 'null'
      - boolean
    doc: Run NetMHCStabPan after all filtering and add stability predictions to 
      predicted epitopes
    inputBinding:
      position: 105
      prefix: --netmhc-stab
  - id: normal_cov
    type:
      - 'null'
      - int
    doc: Normal Coverage Cutoff. Sites above this cutoff will be considered.
    inputBinding:
      position: 105
      prefix: --normal-cov
  - id: normal_vaf
    type:
      - 'null'
      - float
    doc: Normal VAF Cutoff. Sites BELOW this cutoff in normal will be 
      considered.
    inputBinding:
      position: 105
      prefix: --normal-vaf
  - id: peptide_sequence_length
    type:
      - 'null'
      - int
    doc: Length of the peptide sequence to use when creating the FASTA.
    inputBinding:
      position: 105
      prefix: --peptide-sequence-length
  - id: tdna_cov
    type:
      - 'null'
      - int
    doc: Tumor DNA Coverage Cutoff. Sites above this cutoff will be considered.
    inputBinding:
      position: 105
      prefix: --tdna-cov
  - id: tdna_vaf
    type:
      - 'null'
      - float
    doc: Tumor DNA VAF Cutoff. Sites above this cutoff will be considered.
    inputBinding:
      position: 105
      prefix: --tdna-vaf
  - id: top_result_per_mutation
    type:
      - 'null'
      - boolean
    doc: Output only the top scoring result for each allele-peptide length 
      combination for each variant.
    inputBinding:
      position: 105
      prefix: --top-result-per-mutation
  - id: top_score_metric
    type:
      - 'null'
      - string
    doc: The ic50 scoring metric to use when filtering epitopes by 
      binding-threshold or minimum fold change (lowest or median).
    inputBinding:
      position: 105
      prefix: --top-score-metric
  - id: trna_cov
    type:
      - 'null'
      - int
    doc: Tumor RNA Coverage Cutoff. Sites above this cutoff will be considered.
    inputBinding:
      position: 105
      prefix: --trna-cov
  - id: trna_vaf
    type:
      - 'null'
      - float
    doc: Tumor RNA VAF Cutoff. Sites above this cutoff will be considered.
    inputBinding:
      position: 105
      prefix: --trna-vaf
outputs:
  - id: output_dir
    type: Directory
    doc: The directory for writing all result files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pvacseq:4.0.10--py36_0
