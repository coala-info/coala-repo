cwlVersion: v1.2
class: CommandLineTool
baseCommand: corgi
label: corgi
doc: "Classify DNA sequences using a pretrained model.\n\nTool homepage: https://pypi.org/project/bio-corgi/"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --batch-size
  - id: fasta_file
    type: File
    doc: A fasta file with sequences to be classified.
    inputBinding:
      position: 101
      prefix: --file
  - id: max_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-length
  - id: max_seqs
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-seqs
  - id: min_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --min-length
  - id: no_gpu
    type:
      - 'null'
      - boolean
    doc: Whether or not to use a GPU for processing if available.
    inputBinding:
      position: 101
      prefix: --no-gpu
  - id: no_reload
    type:
      - 'null'
      - boolean
    doc: Should the pretrained model be downloaded again if it is online and 
      already present locally.
    inputBinding:
      position: 101
      prefix: --no-reload
  - id: no_save_filtered
    type:
      - 'null'
      - boolean
    doc: Whether or not to save the filtered sequences.
    inputBinding:
      position: 101
      prefix: --no-save-filtered
  - id: pretrained_model
    type:
      - 'null'
      - string
    doc: The location (URL or filepath) of a pretrained model.
    inputBinding:
      position: 101
      prefix: --pretrained
  - id: reload_pretrained
    type:
      - 'null'
      - boolean
    doc: Should the pretrained model be downloaded again if it is online and 
      already present locally.
    inputBinding:
      position: 101
      prefix: --reload
  - id: save_filtered
    type:
      - 'null'
      - boolean
    doc: Whether or not to save the filtered sequences.
    inputBinding:
      position: 101
      prefix: --save-filtered
  - id: threshold
    type:
      - 'null'
      - float
    doc: The threshold to use for filtering. If not given, then only the most 
      likely category used for filtering.
    inputBinding:
      position: 101
      prefix: --threshold
  - id: use_gpu
    type:
      - 'null'
      - boolean
    doc: Whether or not to use a GPU for processing if available.
    inputBinding:
      position: 101
      prefix: --gpu
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: A path to output the results as a CSV.
    outputBinding:
      glob: $(inputs.output_dir)
  - id: csv_output_file
    type:
      - 'null'
      - File
    doc: A path to output the results as a CSV. If not given then a default name
      is chosen inside the output directory.
    outputBinding:
      glob: $(inputs.csv_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/corgi:0.4.3--pyhdfd78af_0
