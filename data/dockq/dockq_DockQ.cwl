cwlVersion: v1.2
class: CommandLineTool
baseCommand: DockQ
label: dockq_DockQ
doc: "Quality measure for protein-protein docking models\n\nTool homepage: https://github.com/bjornwallner/DockQ"
inputs:
  - id: model
    type: File
    doc: Path to model file
    inputBinding:
      position: 1
  - id: native
    type: File
    doc: Path to native file
    inputBinding:
      position: 2
  - id: allowed_mismatches
    type:
      - 'null'
      - int
    doc: Number of allowed mismatches when mapping model sequence to native 
      sequence.
    inputBinding:
      position: 103
      prefix: --allowed_mismatches
  - id: capri_peptide
    type:
      - 'null'
      - boolean
    doc: use version for capri_peptide (DockQ cannot not be trusted for this 
      setting)
    inputBinding:
      position: 103
      prefix: --capri_peptide
  - id: mapping
    type:
      - 'null'
      - string
    doc: "Specify a chain mapping between model and native structure. If the native
      contains two chains \"H\" and \"L\" while the model contains two chains \"A\"\
      \ and \"B\", and chain A is a model of native chain H and chain B is a model
      of native chain L, the flag can be set as: '--mapping AB:HL'. This can also
      help limit the search to specific native interfaces. For example, if the native
      is a tetramer (ABCD) but the user is only interested in the interface between
      chains B and C, the flag can be set as: '--mapping :BC' or the equivalent '--mapping
      *:BC'."
    inputBinding:
      position: 103
      prefix: --mapping
  - id: max_chunk
    type:
      - 'null'
      - int
    doc: Maximum size of chunks given to the cores, actual chunksize is 
      min(max_chunk,combos/cpus)
    inputBinding:
      position: 103
      prefix: --max_chunk
  - id: n_cpu
    type:
      - 'null'
      - int
    doc: Number of cores to use
    inputBinding:
      position: 103
      prefix: --n_cpu
  - id: no_align
    type:
      - 'null'
      - boolean
    doc: Do not align native and model using sequence alignments, but use the 
      numbering of residues instead
    inputBinding:
      position: 103
      prefix: --no_align
  - id: short
    type:
      - 'null'
      - boolean
    doc: Short output
    inputBinding:
      position: 103
      prefix: --short
  - id: small_molecule
    type:
      - 'null'
      - boolean
    doc: If the docking pose of a small molecule should be evaluated
    inputBinding:
      position: 103
      prefix: --small_molecule
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: json
    type:
      - 'null'
      - File
    doc: Write outputs to a chosen json file
    outputBinding:
      glob: $(inputs.json)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dockq:2.1.3--py312h031d066_0
