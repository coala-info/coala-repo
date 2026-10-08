cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - alphafold
label: gget_alphafold
doc: 'Predicts the structure of a protein using a simplified version of AlphaFold
  v2.3.0 (https://doi.org/10.1038/s41586-021-03819-2).


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: sequence
    type:
      type: array
      items:
        - string
        - File
    doc: Sequence (str), list of sequences, or path to fasta file.
    inputBinding:
      position: 1
  - id: multimer_for_monomer
    type:
      - 'null'
      - boolean
    doc: Use multimer model for a monomer.
    inputBinding:
      position: 102
      prefix: --multimer_for_monomer
  - id: multimer_recycles
    type:
      - 'null'
      - int
    doc: 'The multimer model will continue recycling until the predictions stop changing,
      up to the limit set here. For higher accuracy, at the potential cost of longer
      inference times, set this to 20. (default: 3)'
    inputBinding:
      position: 102
      prefix: --multimer_recycles
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Does not print progress information.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: relax
    type:
      - 'null'
      - boolean
    doc: AMBER relax the best model.
    inputBinding:
      position: 102
      prefix: --relax
  - id: out_path
    type: string
    default: alphafold_prediction
    doc: Path to folder the predicted aligned error (json) and the prediction (PDB)
      will be saved in.
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Folder with the predicted aligned error (JSON) and the predicted structure
      (PDB).
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
