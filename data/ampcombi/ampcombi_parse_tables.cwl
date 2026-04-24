cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ampcombi
  - parse_tables
label: ampcombi_parse_tables
doc: "Parse and summarize results from various AMP (Antimicrobial Peptide) prediction
  tools.\n\nTool homepage: https://github.com/Darcy220606/AMPcombi"
inputs:
  - id: aminoacid_length
    type:
      - 'null'
      - int
    doc: Enter the length of the aa sequences required. Any hits below that cutoff
      will be removed
    inputBinding:
      position: 101
      prefix: --aminoacid_length
  - id: amp_cutoff
    type:
      - 'null'
      - float
    doc: Enter the probability cutoff for AMPs for all tools except for HMMsearch
    inputBinding:
      position: 101
      prefix: --amp_cutoff
  - id: amp_database
    type:
      - 'null'
      - string
    doc: Enter the name of the database to be used to classify the AMPs. Can either
      be APD, DRAMP, or UniRef100
    inputBinding:
      position: 101
      prefix: --amp_database
  - id: amp_database_dir
    type:
      - 'null'
      - Directory
    doc: Enter the path to the folder containing the reference database files (.fa
      and .tsv)
    inputBinding:
      position: 101
      prefix: --amp_database_dir
  - id: amp_results
    type:
      - 'null'
      - Directory
    doc: Enter the path to the folder that contains the different tool's output files
      in sub-folders named by sample name.
    inputBinding:
      position: 101
      prefix: --amp_results
  - id: ampgram_file
    type:
      - 'null'
      - string
    doc: If AMPgram was used, enter the ending of the input files, e.g. 'ampgram.txt'
    inputBinding:
      position: 101
      prefix: --ampgram_file
  - id: ampir_file
    type:
      - 'null'
      - string
    doc: If AMPir was used, enter the ending of the input files, e.g. 'ampir.tsv'
    inputBinding:
      position: 101
      prefix: --ampir_file
  - id: amplify_file
    type:
      - 'null'
      - string
    doc: If AMPlify was used, enter the ending of the input files, e.g. 'amplify.tsv'
    inputBinding:
      position: 101
      prefix: --amplify_file
  - id: amptransformer_file
    type:
      - 'null'
      - string
    doc: If AMPtransformer was used, enter the ending of the input files, e.g. 'amptransformer.txt'
    inputBinding:
      position: 101
      prefix: --amptransformer_file
  - id: contig_metadata
    type:
      - 'null'
      - File
    doc: Path to a tsv-file containing contig metadata.
    inputBinding:
      position: 101
      prefix: --contig_metadata
  - id: db_evalue
    type:
      - 'null'
      - float
    doc: Enter the E-value cutoff for AMPs for the database diamond alignment.
    inputBinding:
      position: 101
      prefix: --db_evalue
  - id: ensemblamppred_file
    type:
      - 'null'
      - string
    doc: If EnsemblAMPpred was used, enter the ending of the input files, e.g. 'ensembleamppred.txt'
    inputBinding:
      position: 101
      prefix: --ensemblamppred_file
  - id: faa
    type:
      - 'null'
      - Directory
    doc: Enter the path to the folder containing the reference .faa files or to one
      .faa file.
    inputBinding:
      position: 101
      prefix: --faa
  - id: gbk
    type:
      - 'null'
      - Directory
    doc: Enter the path to the folder containing the reference .gbk/.gbff files or
      to one .gbk/.gbff file.
    inputBinding:
      position: 101
      prefix: --gbk
  - id: hmm_evalue
    type:
      - 'null'
      - float
    doc: Enter the E-value cutoff for AMPs for HMMsearch
    inputBinding:
      position: 101
      prefix: --hmm_evalue
  - id: hmmsearch_file
    type:
      - 'null'
      - string
    doc: If HMMer/HMMsearch was used, enter the ending of the input files, e.g. 'hmmsearch.txt'
    inputBinding:
      position: 101
      prefix: --hmmsearch_file
  - id: interproscan_filter
    type:
      - 'null'
      - string
    doc: Enter a comma seperated list of all keywords that describes the protein that
      is not required in the analysis.
      protein,RIBOSOMAL PROTEIN
    inputBinding:
      position: 101
      prefix: --interproscan_filter
  - id: interproscan_output
    type:
      - 'null'
      - Directory
    doc: Enter the path to the folder containing the output obtained from interproscan
      (i.e., in '*.faa.tsv').
    inputBinding:
      position: 101
      prefix: --interproscan_output
  - id: macrel_file
    type:
      - 'null'
      - string
    doc: If Macrel was used, enter the ending of the input files, e.g. 'macrel.tsv'
    inputBinding:
      position: 101
      prefix: --macrel_file
  - id: neubi_file
    type:
      - 'null'
      - string
    doc: If Neubi was used, enter the ending of the input files, e.g. 'neubi.fasta'
    inputBinding:
      position: 101
      prefix: --neubi_file
  - id: path_list
    type:
      - 'null'
      - type: array
        items: File
    doc: Enter the list of paths to the files to be summarized as a list of lists.
    inputBinding:
      position: 101
      prefix: --path_list
  - id: remove_stop_codons
    type:
      - 'null'
      - boolean
    doc: Removes any hits/CDSs that don't have a stop codon found in the window below
      or upstream of the CDS assigned by '--window_size_stop_codon'.
    inputBinding:
      position: 101
      prefix: --remove_stop_codons
  - id: sample_list
    type:
      - 'null'
      - type: array
        items: string
    doc: Enter a list of sample-names, e.g. sample_1 sample_2 sample_n.
    inputBinding:
      position: 101
      prefix: --sample_list
  - id: sample_metadata
    type:
      - 'null'
      - File
    doc: Path to a tsv-file containing sample metadata.
    inputBinding:
      position: 101
      prefix: --sample_metadata
  - id: threads
    type:
      - 'null'
      - int
    doc: Changes the threads used for DIAMOND alignment
    inputBinding:
      position: 101
      prefix: --threads
  - id: window_size_stop_codon
    type:
      - 'null'
      - int
    doc: Enter the length of the window size required to look for stop codons downstream
      and upstream of the CDS hits.
    inputBinding:
      position: 101
      prefix: --window_size_stop_codon
  - id: window_size_transporter
    type:
      - 'null'
      - int
    doc: Enter the length of the window size required to look for a 'transporter'
      e.g. ABC transporter downstream and upstream of the CDS hits.
    inputBinding:
      position: 101
      prefix: --window_size_transporter
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: Silences the standard output and captures it in a log file
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ampcombi:2.0.1--pyhdfd78af_0
