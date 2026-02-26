cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepnog train
label: deepnog_train
doc: "Train a DeepNOG model.\n\nTool homepage: https://github.com/univieCUBE/deepnog"
inputs:
  - id: train_sequence_file
    type: File
    doc: File containing protein sequences training set.
    inputBinding:
      position: 1
  - id: val_sequence_file
    type: File
    doc: File containing protein sequences validation set.
    inputBinding:
      position: 2
  - id: train_labels_file
    type: File
    doc: Orthologous group labels for training set protein sequences.
    inputBinding:
      position: 3
  - id: val_labels_file
    type: File
    doc: Orthologous group labels for training and validation set protein 
      sequences. Both training and validation labels Must be in CSV files that 
      are parseable by pandas.read_csv(..., index_col=1). The first column must 
      be a numerical index. The other columns should be named 'protein_id' and 
      'eggnog_id', or be in order sequence_identifier first, label_identifier 
      second.
    inputBinding:
      position: 4
  - id: architecture
    type:
      - 'null'
      - string
    doc: Network architecture to use for classification.
    inputBinding:
      position: 105
      prefix: --architecture
  - id: batch_size
    type:
      - 'null'
      - int
    doc: The batch size determines how many sequences are processed by the 
      network at once. If 1, process the protein sequences sequentially 
      (recommended on CPUs). Larger batch sizes speed up the inference and 
      training on GPUs. Batch size can influence the learning process.
    inputBinding:
      position: 105
      prefix: --batch-size
  - id: database_name
    type: string
    doc: Orthologous group database name
    inputBinding:
      position: 105
      prefix: --database
  - id: device
    type:
      - 'null'
      - string
    doc: Define device for calculating protein sequence classification. Auto 
      chooses GPU if available, otherwise CPU.
    inputBinding:
      position: 105
      prefix: --device
  - id: file_format
    type:
      - 'null'
      - string
    doc: File format of protein sequences. Must be supported by Biopythons 
      Bio.SeqIO class.
    inputBinding:
      position: 105
      prefix: --fformat
  - id: l2_coeff
    type:
      - 'null'
      - float
    doc: Regularization coefficient λ for L2 regularization. If None, L2 
      regularization is disabled.
    inputBinding:
      position: 105
      prefix: --l2-coeff
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: Initial learning rate, subject to adaptations by chosen optimizer and 
      scheduler.
    inputBinding:
      position: 105
      prefix: --learning-rate
  - id: learning_rate_decay
    type:
      - 'null'
      - float
    doc: Decay for learning rate step scheduler. (lr_epoch_t2 = gamma * 
      lr_epoch_t1)
    inputBinding:
      position: 105
      prefix: --gamma
  - id: n_epochs
    type:
      - 'null'
      - int
    doc: Number of training epochs, that is, passes over the complete data set.
    inputBinding:
      position: 105
      prefix: --n-epochs
  - id: num_workers
    type:
      - 'null'
      - int
    doc: 'Number of subprocesses (workers) to use for data loading. Set to a value
      <= 0 to use single-process data loading. Note: Only use multi-process data loading
      if you are calculating on a gpu (otherwise inefficient)!'
    inputBinding:
      position: 105
      prefix: --num-workers
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Seed the random number generators of numpy and PyTorch during training for
      reproducibility. Also affects cuDNN determinism. Default: None (disables reproducibility)'
    inputBinding:
      position: 105
      prefix: --random-seed
  - id: save_each_epoch
    type:
      - 'null'
      - boolean
    doc: Save the model after each epoch.
    inputBinding:
      position: 105
      prefix: --save-each-epoch
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: Shuffle the training sequences. Note that a shuffle buffer is used in 
      combination with an iterable dataset. That is, not all sequences have 
      equal probability to be chosen. If you have highly structured sequence 
      files consider shuffling them in advance. Default buffer size = 65536
    inputBinding:
      position: 105
      prefix: --shuffle
  - id: taxonomic_level
    type: string
    doc: Taxonomic level in specified database
    inputBinding:
      position: 105
      prefix: --tax
  - id: verbose
    type:
      - 'null'
      - int
    doc: Define verbosity of DeepNOGs output written to stdout or stderr. 0 only
      writes errors to stderr which cause DeepNOG to abort and exit. 1 also 
      writes warnings to stderr if e.g. a protein without an ID was found and 
      skipped. 2 additionally writes general progress messages to stdout. 3 
      includes a dynamic progress bar of the prediction stage using tqdm.
    inputBinding:
      position: 105
      prefix: --verbose
  - id: weights_file
    type:
      - 'null'
      - File
    doc: Custom weights file path (optional)
    inputBinding:
      position: 105
      prefix: --weights
outputs:
  - id: out_dir
    type: Directory
    doc: Store training results to files in the given directory. Results include
      the trained model,training/validation loss and accuracy values,and the 
      ground truth plus predicted classes per training epoch, if requested.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepnog:1.2.4--pyh7e72e81_0
