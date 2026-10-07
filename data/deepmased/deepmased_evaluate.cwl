cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - DeepMAsED
  - evaluate
label: deepmased_evaluate
doc: "Evaluate model\n\nTool homepage: https://github.com/leylabmpi/DeepMAsED"
inputs:
  - id: feature_file_table
    type: File
    doc: Table listing feature table files (columns rep, assembler, feature_file)
    inputBinding:
      position: 2
  - id: model_path
    type:
      - 'null'
      - Directory
    doc: 'Directory containing the model (default: /usr/local/lib/python3.7/site-packages/DeepMAsED/Model)'
    inputBinding:
      position: 1
      prefix: --model-path
  - id: model_name
    type:
      - 'null'
      - string
    doc: 'Model name in the model_path (default: deepmased_model.h5)'
    inputBinding:
      position: 1
      prefix: --model-name
  - id: mstd_name
    type:
      - 'null'
      - string
    doc: 'Data mean and std name in the model_path (default: deepmased_mean_std.pkl)'
    inputBinding:
      position: 1
      prefix: --mstd-name
  - id: save_path
    type:
      - 'null'
      - string
    doc: 'Directory where to save output (default: .)'
    default: deepmased_evaluate
    inputBinding:
      position: 1
      prefix: --save-path
  - id: save_name
    type:
      - 'null'
      - string
    doc: 'Prefix for name in the save_path (default: deepmased)'
    inputBinding:
      position: 1
      prefix: --save-name
  - id: save_plot
    type:
      - 'null'
      - string
    doc: 'Where to save plots (default: None)'
    inputBinding:
      position: 1
      prefix: --save-plot
  - id: max_len
    type:
      - 'null'
      - int
    doc: 'Max contig len, fixed input for CNN (default: 10000)'
    inputBinding:
      position: 1
      prefix: --max-len
  - id: technology
    type:
      - 'null'
      - string
    doc: 'Assembler name in the data_path. "all-asmbl" will use all assemblers (default: all-asmbl)'
    inputBinding:
      position: 1
      prefix: --technology
  - id: norm_raw
    type:
      - 'null'
      - int
    doc: 'Whether to normalize the four one-hot feature of raw (default: 1)'
    inputBinding:
      position: 1
      prefix: --norm-raw
  - id: is_synthetic
    type:
      - 'null'
      - int
    doc: 'Whether the data is synthetic and thus has ground truth (default: 1)'
    inputBinding:
      position: 1
      prefix: --is-synthetic
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: 'Force re-creation of pickle files (default: False)'
    inputBinding:
      position: 1
      prefix: --force-overwrite
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Seed used for numpy.random (default: 12)'
    inputBinding:
      position: 1
      prefix: --seed
  - id: n_procs
    type:
      - 'null'
      - int
    doc: 'Number of parallel processes (default: 1)'
    inputBinding:
      position: 1
      prefix: --n-procs
  - id: data_files
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: Files and folders named in the input table (feature tables, or BAM files with their
      .bai index and FASTA files; the image has no samtools to index BAM files), staged writable
      in the working directory so the relative paths in the table resolve and the tool can
      write pickles or indexes beside them
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: Evaluation scores pickle (<save-name>_<technology>.pkl) and plots
    outputBinding:
      glob: $(inputs.save_path)
  - id: pickled_features
    type:
      type: array
      items: File
    doc: Pickled feature tables written beside the staged feature files
    outputBinding:
      glob:
        - '*.pkl'
        - '*/*.pkl'
        - '*/*/*.pkl'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.data_files ? inputs.data_files : [])'
        writable: true
      - entry: '$({class: ''Directory'', basename: inputs.save_path, listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmased:0.3.1--pyh5ca1d4c_0
stdout: deepmased_evaluate.out
