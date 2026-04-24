cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiprocess_mgcod.py
label: mgcod_multiprocess_mgcod.py
doc: "Runs Mgcod on many contigs in parallel.\n\nTool homepage: https://github.com/gatech-genemark/Mgcod"
inputs:
  - id: amino_acids
    type:
      - 'null'
      - boolean
    doc: Extract amino acid sequences of predicted proteins.
    inputBinding:
      position: 101
      prefix: --amino_acids
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size for multiprocessing.
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Set if sequence is circular. Only relevant for isoform prediction
    inputBinding:
      position: 101
      prefix: --circular
  - id: consecutive_gene_labels
    type:
      - 'null'
      - int
    doc: Number of consecutive gene labels to be required with same genetic code
      to keep. Only relevant for isoform prediction. Minimum is 2.
    inputBinding:
      position: 101
      prefix: --consecutive_gene_labels
  - id: consecutive_windows
    type:
      - 'null'
      - int
    doc: Number of consecutive windows to be required with same genetic code to 
      keep. Only relevant for isoform prediction. Minimum is 2.
    inputBinding:
      position: 101
      prefix: --consecutive_windows
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete intermediary files (prediction of the different MGM models).
    inputBinding:
      position: 101
      prefix: --delete
  - id: genomes
    type: File
    doc: path to txt file with genomes
    inputBinding:
      position: 101
      prefix: --genomes
  - id: isoforms
    type:
      - 'null'
      - boolean
    doc: Enable prediction of isoforms
    inputBinding:
      position: 101
      prefix: --isoforms
  - id: nucleotides
    type:
      - 'null'
      - boolean
    doc: Extract nucleotide sequences of predicted proteins.
    inputBinding:
      position: 101
      prefix: --nucleotides
  - id: path_to_mgm_predictions
    type:
      - 'null'
      - Directory
    doc: Directory where to save MGM predictions so that they can be re-used. If
      path does not exist, it will be created.
    inputBinding:
      position: 101
      prefix: --path_to_mgm_predictions
  - id: short_contigs
    type:
      - 'null'
      - boolean
    doc: Predict genetic codes of contigs < 5000bp. Prediction may not be 
      reliable
    inputBinding:
      position: 101
      prefix: --short_contigs
  - id: stride
    type:
      - 'null'
      - int
    doc: Step size in bp, with which window will be moved along sequence. Only 
      relevant for isoform prediction. [If sequence <= 100 kb 2500 bp else 5000 
      bp]
    inputBinding:
      position: 101
      prefix: --stride
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processes.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tolerance
    type:
      - 'null'
      - int
    doc: The maximally tolerated difference in prediction of gene start or gene 
      stop to consider the prediction of two models isoforms. Only relevent for 
      isoform prediction.
    inputBinding:
      position: 101
      prefix: --tolerance
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size in bp applied to search for isoform. Only relevant for 
      isoform prediction.
    inputBinding:
      position: 101
      prefix: --window_size
outputs:
  - id: path_to_output
    type:
      - 'null'
      - Directory
    doc: Directory where to save final gene annotations and supporting outputs. 
      If path does not exist, it will be created. If -AA or -NT flag is set, 
      sequences will be saved here, too.
    outputBinding:
      glob: $(inputs.path_to_output)
  - id: path_to_plots
    type:
      - 'null'
      - Directory
    doc: Directory where to save plots. Plots logodd ratio per window for 
      different MGM models. Only available with isoform prediction. If path does
      not exist, it will be created
    outputBinding:
      glob: $(inputs.path_to_plots)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Path to log file
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgcod:1.0.2--hdfd78af_0
