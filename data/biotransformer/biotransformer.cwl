cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - biotransformer-4.0.jar
label: biotransformer
doc: "BioTransformer is a software tool that predicts small molecule metabolism in
  mammals, their gut microbiota, as well as the soil/aquatic microbiota. It also assists
  in metabolite identification based on metabolism prediction.\n\nTool homepage: https://bitbucket.org/djoumbou/biotransformer"
inputs:
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Search PuChem for each product, and store with CID and synonyms, when available.
    inputBinding:
      position: 101
      prefix: --annotate
  - id: b_sequence
    type:
      - 'null'
      - string
    doc: Define an ordered sequence of biotransformer/nr_of_steps to apply (e.g.,
      'cyp450:2; hgut:1').
    inputBinding:
      position: 101
      prefix: --bsequence
  - id: bt_type
    type:
      - 'null'
      - string
    doc: 'The type of biotransformer: ecbased, cyp450, phaseII, hgut, superbio, allHuman,
      or envimicro.'
    inputBinding:
      position: 101
      prefix: --btType
  - id: cyp450_mode
    type:
      - 'null'
      - int
    doc: 'Specify the CYP450 prediction Mode: 1) CypReact + BioTransformer rules;
      2) CyProduct only; 3) Combined.'
    default: 1
    inputBinding:
      position: 101
      prefix: --cyp450mode
  - id: formulas
    type:
      - 'null'
      - string
    doc: Semicolon-separated list of formulas of compounds to identify
    inputBinding:
      position: 101
      prefix: --formulas
  - id: mass_threshold
    type:
      - 'null'
      - int
    doc: Specify the mass threshold used to validate input substrates (in Da).
    default: 1500
    inputBinding:
      position: 101
      prefix: --massThreshold
  - id: mass_tolerance
    type:
      - 'null'
      - float
    doc: Mass tolerance for metabolite identification.
    default: 0.01
    inputBinding:
      position: 101
      prefix: --mTolerance
  - id: masses
    type:
      - 'null'
      - string
    doc: Semicolon-separated list of masses of compounds to identify
    inputBinding:
      position: 101
      prefix: --masses
  - id: mol_input
    type:
      - 'null'
      - File
    doc: The input, which can be a Mol file
    inputBinding:
      position: 101
      prefix: --molinput
  - id: multi_thread
    type:
      - 'null'
      - string
    doc: Parameters to run the multi-thread feature
    inputBinding:
      position: 101
      prefix: -multiThread
  - id: n_steps
    type:
      - 'null'
      - int
    doc: The number of steps for the prediction.
    default: 1
    inputBinding:
      position: 101
      prefix: --nsteps
  - id: phase_ii_mode
    type:
      - 'null'
      - int
    doc: 'Specify the PhaseII prediction Mode: 1) BioTransformer rules; 2) PhaseII
      predictor only; 3) Combined.'
    default: 1
    inputBinding:
      position: 101
      prefix: --phaseIImode
  - id: sdf_input
    type:
      - 'null'
      - File
    doc: The input, which can be an SDF file.
    inputBinding:
      position: 101
      prefix: --sdfinput
  - id: smiles_input
    type:
      - 'null'
      - string
    doc: The input, which can be a SMILES string
    inputBinding:
      position: 101
      prefix: --ismiles
  - id: task
    type:
      - 'null'
      - string
    doc: 'The task to be performed: pred for prediction, or cid for compound identification'
    inputBinding:
      position: 101
      prefix: --task
  - id: use_db
    type:
      - 'null'
      - string
    doc: Specify if you want to enable the retrieving from database feature (e.g.,
      true/false).
    inputBinding:
      position: 101
      prefix: -useDB
  - id: use_sub
    type:
      - 'null'
      - string
    doc: Specify if you want to enable using the first 14 characters of the InChIkey
      when retrieving from database.
    inputBinding:
      position: 101
      prefix: -useSub
outputs:
  - id: csv_output
    type:
      - 'null'
      - File
    doc: Select this option to return CSV output(s). You must enter an output filename
    outputBinding:
      glob: $(inputs.csv_output)
  - id: sdf_output
    type:
      - 'null'
      - File
    doc: Select this option to return SDF output(s). You must enter an output filename
    outputBinding:
      glob: $(inputs.sdf_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biotransformer:3.0.20230403--hdfd78af_0
