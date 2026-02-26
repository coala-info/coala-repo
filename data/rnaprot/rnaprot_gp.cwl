cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaprot gp
label: rnaprot_gp
doc: "Predicts RBP binding sites using a trained model.\n\nTool homepage: https://github.com/BackofenLab/RNAProt"
inputs:
  - id: additional_features_file
    type:
      - 'null'
      - File
    doc: Provide tabular file with additional position-wise genomic region 
      features (infos and paths to BED files) to add. BE SURE to use the same 
      file as used for generating the training dataset (rnaprot gt --feat-in) 
      for training the model from --train-in! NOTE that this does not apply if 
      --in == FASTA sequences. Here input file format changes from BED to 
      tabular (see documentation), and files need to contain values for --in 
      sequences
    inputBinding:
      position: 101
      prefix: --feat-in
  - id: gene_filter
    type:
      - 'null'
      - boolean
    doc: Filter --in sites based on gene coverage (gene annotations from --gtf)
    default: false
    inputBinding:
      position: 101
      prefix: --gene-filter
  - id: genomic_sequences_2bit
    type:
      - 'null'
      - File
    doc: Genomic sequences .2bit file
    inputBinding:
      position: 101
      prefix: --gen
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: Genomic annotations GTF file (.gtf or .gtf.gz)
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input_sites
    type: string
    doc: Genomic or transcript RBP binding sites file in BED (6-column format) 
      or FASTA format. If --in FASTA, only --str is supported as additional 
      feature. If --in BED, --gtf and --gen become mandatory
    inputBinding:
      position: 101
      prefix: --in
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Define mode for --in BED site extraction. (1) Take the center of each site,
      (2) Take the complete site, (3) Take the upstream end for each site. Use --seq-ext
      to extend center sites again (default: 2)'
    default: '1'
    inputBinding:
      position: 101
      prefix: --mode
  - id: output_prediction_folder
    type: Directory
    doc: Output prediction dataset folder (== input folder to rnaprot predict)
    inputBinding:
      position: 101
      prefix: --out
  - id: phastcons_bigwig
    type:
      - 'null'
      - File
    doc: Genomic .bigWig file with phastCons conservation scores to add as 
      annotations
    inputBinding:
      position: 101
      prefix: --phastcons
  - id: phylop_bigwig
    type:
      - 'null'
      - File
    doc: Genomic .bigWig file with phyloP conservation scores to add as 
      annotations
    inputBinding:
      position: 101
      prefix: --phylop
  - id: report
    type:
      - 'null'
      - boolean
    doc: Output an .html report providing various training set statistics and 
      plots
    default: false
    inputBinding:
      position: 101
      prefix: --report
  - id: report_theme
    type:
      - 'null'
      - string
    doc: 'Set theme for .html report (1: palm beach, 2: midnight sunset)'
    default: '1'
    inputBinding:
      position: 101
      prefix: --theme
  - id: seq_extension
    type:
      - 'null'
      - int
    doc: Up- and downstream sequence extension length of --in sites (if --in 
      BED, site definition by --mode)
    default: 'False'
    inputBinding:
      position: 101
      prefix: --seq-ext
  - id: training_input_folder
    type: string
    doc: Training input folder (output folder of rnaprot train) to extract the 
      same features for --in sites which were used to train the model (info 
      stored in --train-in folder)
    inputBinding:
      position: 101
      prefix: --train-in
  - id: transcript_id_list
    type:
      - 'null'
      - File
    doc: Supply file with transcript IDs (one ID per row) for exon-intron 
      labeling (using the corresponding exon regions from --gtf). By default, 
      exon regions of the most prominent transcripts (automatically selected 
      from --gtf) are used
    default: 'False'
    inputBinding:
      position: 101
      prefix: --tr-list
  - id: use_all_exons
    type:
      - 'null'
      - boolean
    doc: Use all annotated exons in --gtf file, instead of exons of most 
      prominent transcripts or exon defined by --tr-list. Set this and --tr-list
      will be effective only for --tra. NOTE that by default --eia-all-ex is 
      disabled, even if --train-in model was trained with --eia-all-ex
    default: false
    inputBinding:
      position: 101
      prefix: --eia-all-ex
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaprot:0.5--pyhdfd78af_1
stdout: rnaprot_gp.out
