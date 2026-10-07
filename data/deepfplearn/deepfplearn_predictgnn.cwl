cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dfpl
  - predictgnn
label: deepfplearn_predictgnn
doc: "Predict with your GNN models (chemprop D-MPNN). Options are read from the JSON config\
  \ file; a command-line option only overrides a key that is present in that file.\n\nTool\
  \ homepage: https://github.com/yigbt/deepFPlearn"
inputs:
  - id: configFile
    type:
      - 'null'
      - File
    doc: Input JSON file that contains all information for training/predicting.
    inputBinding:
      position: 1
      prefix: --configFile
  - id: gpu
    type:
      - 'null'
      - int
    doc: Which GPU to use
    inputBinding:
      position: 1
      prefix: --gpu
  - id: no_cuda
    type:
      - 'null'
      - boolean
    doc: Turn off cuda
    inputBinding:
      position: 1
      prefix: --no_cuda
  - id: num_workers
    type:
      - 'null'
      - int
    doc: Number of workers for the parallel data loading 0 means sequential
    inputBinding:
      position: 1
      prefix: --num_workers
  - id: no_cache
    type:
      - 'null'
      - boolean
    doc: Turn off caching mol2graph computation (passed as True or False)
    inputBinding:
      position: 1
      prefix: --no_cache
      valueFrom: '$(self ? "True" : "False")'
  - id: no_cache_mol
    type:
      - 'null'
      - boolean
    doc: Whether to not cache the RDKit molecule for each SMILES string to reduce memory usage
      cached by default (passed as True or False)
    inputBinding:
      position: 1
      prefix: --no_cache_mol
      valueFrom: '$(self ? "True" : "False")'
  - id: empty_cache
    type:
      - 'null'
      - boolean
    doc: Whether to empty all caches before training or predicting. This is necessary if multiple
      jobs are run within a single script and the atom or bond features change (passed as
      True or False)
    inputBinding:
      position: 1
      prefix: --empty_cache
      valueFrom: '$(self ? "True" : "False")'
  - id: preds_path
    type:
      - 'null'
      - string
    doc: Path to CSV file where predictions will be saved
    inputBinding:
      position: 1
      prefix: --preds_path
  - id: checkpoint_dir
    type:
      - 'null'
      - Directory
    doc: Directory from which to load model checkpoints(walks directory and ensembles all
      models that are found)
    inputBinding:
      position: 1
      prefix: --checkpoint_dir
  - id: checkpoint_path
    type:
      - 'null'
      - File
    doc: Path to model checkpoint (.pt file)
    inputBinding:
      position: 1
      prefix: --checkpoint_path
  - id: checkpoint_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to model checkpoint (.pt file)
    inputBinding:
      position: 1
      prefix: --checkpoint_paths
  - id: data_path
    type:
      - 'null'
      - File
    doc: Path to CSV file containing testing data for which predictions will be made
    inputBinding:
      position: 1
      prefix: --data_path
  - id: test_path
    type:
      - 'null'
      - File
    doc: Path to CSV file containing testing data for which predictions will be made
    inputBinding:
      position: 1
      prefix: --test_path
  - id: features_path
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to features to use in FNN (instead of features_generator)
    inputBinding:
      position: 1
      prefix: --features_path
  - id: atom_descriptors_path
    type:
      - 'null'
      - File
    doc: Path to the extra atom descriptors.
    inputBinding:
      position: 1
      prefix: --atom_descriptors_path
  - id: use_compound_names
    type:
      - 'null'
      - boolean
    doc: Use when test data file contains compound names in addition to SMILES strings
    inputBinding:
      position: 1
      prefix: --use_compound_names
  - id: no_features_scaling
    type:
      - 'null'
      - boolean
    doc: Turn off scaling of features
    inputBinding:
      position: 1
      prefix: --no_features_scaling
  - id: max_data_size
    type:
      - 'null'
      - int
    doc: Maximum number of data points to load
    inputBinding:
      position: 1
      prefix: --max_data_size
  - id: smiles_columns
    type:
      - 'null'
      - string
    doc: List of names of the columns containing SMILES strings.By default, uses the first
      number_of_molecules columns.
    inputBinding:
      position: 1
      prefix: --smiles_columns
  - id: number_of_molecules
    type:
      - 'null'
      - int
    doc: Number of molecules in each input to the model.This must equal the length of smiles_columns
      if not None
    inputBinding:
      position: 1
      prefix: --number_of_molecules
  - id: atom_descriptors
    type:
      - 'null'
      - boolean
    doc: Use or not atom descriptors (passed as True or False)
    inputBinding:
      position: 1
      prefix: --atom_descriptors
      valueFrom: '$(self ? "True" : "False")'
  - id: bond_features_size
    type:
      - 'null'
      - int
    doc: Size of the extra bond descriptors that will be used as bond features to featurize
      a given molecule
    inputBinding:
      position: 1
      prefix: --bond_features_size
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size
    inputBinding:
      position: 1
      prefix: --batch_size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: predictions
    type:
      - 'null'
      - File
    doc: Prediction CSV file (the preds_path key must be present in the config file)
    outputBinding:
      glob: $(inputs.preds_path)
  - id: log
    type: File
    doc: predictgnn.log
    outputBinding:
      glob: predictgnn.log
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepfplearn:2.1--pyh42286b9_1
stdout: deepfplearn_predictgnn.out
