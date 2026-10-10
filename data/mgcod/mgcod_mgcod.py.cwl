cwlVersion: v1.2
class: CommandLineTool
baseCommand: mgcod.py
label: mgcod_mgcod.py
doc: "Mgcod segments contigs based on genetic code usage and performs genetic-code-informed\n\
  annotation of coding regions using MetaGeneMark. Can be run on any prokaryotic sequences\n\
  with(-out) stop codon reassignment\n\nTool homepage: https://github.com/gatech-genemark/Mgcod"
inputs:
  - id: path_to_genome
    type: File
    doc: Path to input file, FASTA format
    inputBinding:
      position: 1
      prefix: --path_to_genome
  - id: path_to_mgm_predictions
    type: string
    default: mgm_results
    doc: Directory where to save MGM predictions so that they can be re-used. If
      path does not exist, it will be created.
    inputBinding:
      position: 2
      prefix: --path_to_mgm_predictions
  - id: path_to_output
    type: string
    default: results
    doc: Directory where to save final gene annotations and supporting outputs. 
      If path does not exist, it will be created. If -AA or -NT flag is set, 
      sequences will be saved here, too.
    inputBinding:
      position: 3
      prefix: --path_to_output
  - id: path_to_plots
    type:
      - 'null'
      - string
    doc: Directory where to save plots. Plots logodd ratio per window for 
      different MGM models. Only available with isoform prediction. If path does
      not exist, it will be created
    inputBinding:
      position: 4
      prefix: --path_to_plots
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Set if sequence is circular. Only relevant for isoform prediction
    inputBinding:
      position: 5
      prefix: --circular
  - id: isoforms
    type:
      - 'null'
      - boolean
    doc: Enable prediction of isoforms
    inputBinding:
      position: 5
      prefix: --isoforms
  - id: consecutive_windows
    type:
      - 'null'
      - int
    doc: Number of consecutive windows to be required with same genetic code to 
      keep. Only relevant for isoform prediction. Minimum is 2. [3]
    inputBinding:
      position: 5
      prefix: --consecutive_windows
  - id: consecutive_gene_labels
    type:
      - 'null'
      - int
    doc: Number of consecutive gene labels to be required with same genetic code
      to keep. Only relevant for isoform prediction. Minimum is 2. [5]
    inputBinding:
      position: 5
      prefix: --consecutive_gene_labels
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size in bp applied to search for isoform. Only relevant for 
      isoform prediction. [5000]
    inputBinding:
      position: 5
      prefix: --window_size
  - id: stride
    type:
      - 'null'
      - int
    doc: Step size in bp, with which window will be moved along sequence. Only 
      relevant for isoform prediction. [If sequence <= 100kb 2500 bp else 5000 
      bp]
    inputBinding:
      position: 5
      prefix: --stride
  - id: tolerance
    type:
      - 'null'
      - int
    doc: The maximally tolerated difference in prediction of gene start or gene 
      stop to consider the prediction of two models isoforms. Only relevent for 
      isoform prediction. [30]
    inputBinding:
      position: 5
      prefix: --tolerance
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete intermediary files (prediction of the different MGM models).
    inputBinding:
      position: 5
      prefix: --delete
  - id: amino_acids
    type:
      - 'null'
      - boolean
    doc: Extract amino acid sequences of predicted proteins.
    inputBinding:
      position: 5
      prefix: --amino_acids
  - id: nucleotides
    type:
      - 'null'
      - boolean
    doc: Extract nucleotide sequences of predicted proteins.
    inputBinding:
      position: 5
      prefix: --nucleotides
  - id: short_contigs
    type:
      - 'null'
      - boolean
    doc: Predict genetic codes of contigs < 5000bp. Prediction may not be 
      reliable
    inputBinding:
      position: 5
      prefix: --short_contigs
  - id: logfile_path
    type:
      - 'null'
      - string
    doc: Path to log file
    inputBinding:
      position: 5
      prefix: --logfile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose
    inputBinding:
      position: 5
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Final gene annotations and supporting outputs
    outputBinding:
      glob: $(inputs.path_to_output)
  - id: mgm_predictions_dir
    type:
      - 'null'
      - Directory
    doc: MGM predictions of the different genetic-code models
    outputBinding:
      glob: $(inputs.path_to_mgm_predictions)
  - id: plots_dir
    type:
      - 'null'
      - Directory
    doc: Plots of the log-odd ratio per window (isoform prediction only)
    outputBinding:
      glob: $(inputs.path_to_plots)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.logfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgcod:1.0.2--hdfd78af_0
