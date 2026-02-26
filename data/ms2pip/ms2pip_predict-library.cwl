cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ms2pip
  - predict-library
label: ms2pip_predict-library
doc: "Predict spectral library from protein FASTA file.\n\nTool homepage: http://compomics.github.io/projects/ms2pip_c"
inputs:
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Protein FASTA file
    inputBinding:
      position: 1
  - id: add_ion_mobility
    type:
      - 'null'
      - boolean
    doc: Add ion mobility to output
    inputBinding:
      position: 102
      prefix: --add-ion-mobility
  - id: add_retention_time
    type:
      - 'null'
      - boolean
    doc: Add retention time to output
    inputBinding:
      position: 102
      prefix: --add-retention-time
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of spectra to predict in each batch
    inputBinding:
      position: 102
      prefix: --batch-size
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file
    inputBinding:
      position: 102
      prefix: --config
  - id: model
    type:
      - 'null'
      - string
    doc: Pre-trained model to use
    inputBinding:
      position: 102
      prefix: --model
  - id: model_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing pre-trained models
    inputBinding:
      position: 102
      prefix: --model-dir
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output file format
    inputBinding:
      position: 102
      prefix: --output-format
  - id: output_name
    type:
      - 'null'
      - string
    doc: Base name for output files
    inputBinding:
      position: 102
      prefix: --output-name
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of parallel processes to use
    inputBinding:
      position: 102
      prefix: --processes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ms2pip:4.1.0--py312h0fa9677_2
stdout: ms2pip_predict-library.out
