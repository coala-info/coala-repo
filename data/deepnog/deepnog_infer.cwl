cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepnog_infer
label: deepnog_infer
doc: "Infer orthologous groups for protein sequences.\n\nTool homepage: https://github.com/univieCUBE/deepnog"
inputs:
  - id: sequence_file
    type: File
    doc: File containing protein sequences for orthology inference.
    inputBinding:
      position: 1
  - id: architecture
    type:
      - 'null'
      - string
    doc: Network architecture to use for classification.
    default: deepnog
    inputBinding:
      position: 102
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
      position: 102
      prefix: --batch-size
  - id: confidence_threshold
    type:
      - 'null'
      - float
    doc: If provided, predictions below the threshold are discarded.By default, 
      any confidence threshold stored in the model is applied, if present.
    inputBinding:
      position: 102
      prefix: --confidence-threshold
  - id: database
    type:
      - 'null'
      - string
    doc: Orthologous group/family database to use.
    default: eggNOG5
    inputBinding:
      position: 102
      prefix: --database
  - id: device
    type:
      - 'null'
      - string
    doc: Define device for calculating protein sequence classification. Auto 
      chooses GPU if available, otherwise CPU.
    default: auto
    inputBinding:
      position: 102
      prefix: --device
  - id: file_format
    type:
      - 'null'
      - string
    doc: File format of protein sequences. Must be supported by Biopythons 
      Bio.SeqIO class.
    inputBinding:
      position: 102
      prefix: --fformat
  - id: num_workers
    type:
      - 'null'
      - int
    doc: 'Number of subprocesses (workers) to use for data loading. Set to a value
      <= 0 to use single-process data loading. Note: Only use multi-process data loading
      if you are calculating on a gpu (otherwise inefficient)!'
    inputBinding:
      position: 102
      prefix: --num-workers
  - id: outformat
    type:
      - 'null'
      - string
    doc: Output file format
    default: csv
    inputBinding:
      position: 102
      prefix: --outformat
  - id: taxonomic_level
    type:
      - 'null'
      - string
    doc: Taxonomic level to use in specified database, e.g. 1 = root, 2 = 
      bacteria
    inputBinding:
      position: 102
      prefix: --tax
  - id: test_labels_file
    type:
      - 'null'
      - File
    doc: Measure model performance on a test set. If provided, this file must 
      contain the ground-truth labels for the provided sequences. Otherwise, 
      only perform inference.
    inputBinding:
      position: 102
      prefix: --test_labels
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
      position: 102
      prefix: --verbose
  - id: weights_file
    type:
      - 'null'
      - File
    doc: Custom weights file path (optional)
    inputBinding:
      position: 102
      prefix: --weights
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Store orthologous group predictions to outputfile. Per default, write 
      predictions to stdout.
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepnog:1.2.4--pyh7e72e81_0
