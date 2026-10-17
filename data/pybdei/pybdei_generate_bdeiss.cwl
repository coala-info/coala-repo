cwlVersion: v1.2
class: CommandLineTool
baseCommand: generate_bdeiss
label: pybdei_generate_bdeiss
doc: "Simulates a tree (or a forest of trees) for given BDEISS-CT-Skyline model parameters. If a simulation leads to less than --min_tips tips, it is repeated.\n\nTool homepage: https://github.com/evolbioinfo/bdei"
inputs:
  - id: min_tips
    type: int
    doc: "desired minimal bound on the total number of simulated leaves."
    inputBinding:
      position: 10
      prefix: --min_tips
  - id: max_tips
    type: int
    doc: "desired maximal bound on the total number of simulated leaves."
    inputBinding:
      position: 10
      prefix: --max_tips
  - id: t
    type:
      - 'null'
      - double
    doc: "Total simulation time. If specified, a forest will be simulated instead of one tree."
    inputBinding:
      position: 10
      prefix: --T
  - id: mu_n
    type:
      type: array
      items: double
    doc: "List of exposed-to-normal spreader state change rates (one per skyline interval)."
    inputBinding:
      position: 10
      prefix: --mu_n
  - id: mu_s
    type:
      type: array
      items: double
    doc: "List of exposed-to-super spreader state change rates (one per skyline interval)."
    inputBinding:
      position: 10
      prefix: --mu_s
  - id: la_n
    type:
      type: array
      items: double
    doc: "List of transmission rates from normal spreaders (one per skyline interval)."
    inputBinding:
      position: 10
      prefix: --la_n
  - id: la_s
    type:
      type: array
      items: double
    doc: "List of transmission rates from super spreaders (one per skyline interval)."
    inputBinding:
      position: 10
      prefix: --la_s
  - id: psi
    type:
      type: array
      items: double
    doc: "List of removal rates (one per skyline interval)."
    inputBinding:
      position: 10
      prefix: --psi
  - id: p
    type:
      type: array
      items: double
    doc: "List of sampling probabilities (one per skyline interval)."
    inputBinding:
      position: 10
      prefix: --p
  - id: skyline_times
    type:
      - 'null'
      - type: array
        items: double
    doc: "List of time points specifying when to switch from model i to model i+1 in the Skyline. Must be sorted in ascending order and contain one less elements than the number of models in the Skyline."
    inputBinding:
      position: 10
      prefix: --skyline_times
  - id: upsilon
    type:
      - 'null'
      - type: array
        items: double
    doc: "List of notification probabilities (one per skyline interval). Omit for no contact tracing."
    inputBinding:
      position: 10
      prefix: --upsilon
  - id: phi
    type:
      - 'null'
      - type: array
        items: double
    doc: "List of notified removal rates (one per skyline interval). Only used if upsilon is specified."
    inputBinding:
      position: 10
      prefix: --phi
  - id: max_notified_contacts
    type:
      - 'null'
      - int
    doc: "Maximum notified contacts"
    inputBinding:
      position: 10
      prefix: --max_notified_contacts
  - id: allow_irremovable_states
    type:
      - 'null'
      - boolean
    doc: "If specified and the initial model included irremovable states (removal rate zero, e.g., E), then even after notification their removal rate will stay zero."
    inputBinding:
      position: 10
      prefix: --allow_irremovable_states
  - id: avg_recipients
    type:
      - 'null'
      - type: array
        items: double
    doc: "average number of recipients per transmission for each donor state (normal spreader, superspreader). By default one and one."
    inputBinding:
      position: 10
      prefix: --avg_recipients
  - id: root_state
    type:
      - 'null'
      - type: enum
        symbols: [E, I, S]
    doc: "state at the beginning of the root branch(es). By default, one of the model states will be chosen randomly (and independently for each tree) based on the state equilibrium frequencies."
    inputBinding:
      position: 10
      prefix: --root_state
  - id: log
    type:
      - 'null'
      - string
    doc: "output file to log BDEISS model parameters"
    inputBinding:
      position: 10
      prefix: --log
  - id: nwk
    type: string
    doc: "output tree or forest file"
    inputBinding:
      position: 10
      prefix: --nwk
  - id: ltt
    type:
      - 'null'
      - string
    doc: "output LTT file"
    inputBinding:
      position: 10
      prefix: --ltt
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "describe generation process"
    inputBinding:
      position: 10
      prefix: -v
  - id: seed
    type:
      - 'null'
      - int
    doc: "random seed for reproducibility"
    inputBinding:
      position: 10
      prefix: -s
outputs:
  - id: tree
    type: File
    doc: Simulated tree or forest
    outputBinding:
      glob: $(inputs.nwk)
  - id: params_log
    type:
      - 'null'
      - File
    doc: BDEI model parameters log
    outputBinding:
      glob: $(inputs.log)
  - id: ltt_file
    type:
      - 'null'
      - File
    doc: LTT file
    outputBinding:
      glob: $(inputs.ltt)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybdei:0.13--py310hef477bb_1
