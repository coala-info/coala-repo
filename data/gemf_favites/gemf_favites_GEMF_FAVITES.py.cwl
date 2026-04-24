cwlVersion: v1.2
class: CommandLineTool
baseCommand: GEMF_FAVITES.py
label: gemf_favites_GEMF_FAVITES.py
doc: "User-friendly GEMF wrapper for use in FAVITES (or elsewhere). Niema Moshiri\n\
  2022\n\nTool homepage: https://github.com/niemasd/GEMF"
inputs:
  - id: contact_network
    type: File
    doc: Contact Network (TSV)
    inputBinding:
      position: 101
      prefix: --contact_network
  - id: end_time
    type: float
    doc: End Time
    inputBinding:
      position: 101
      prefix: --end_time
  - id: gemf_path
    type:
      - 'null'
      - string
    doc: Path to GEMF Executable
    inputBinding:
      position: 101
      prefix: --gemf_path
  - id: infected_states
    type: File
    doc: Infected States (one per line)
    inputBinding:
      position: 101
      prefix: --infected_states
  - id: initial_states
    type: File
    doc: Initial States (TSV)
    inputBinding:
      position: 101
      prefix: --initial_states
  - id: max_events
    type:
      - 'null'
      - int
    doc: Max Number of Events
    inputBinding:
      position: 101
      prefix: --max_events
  - id: output_all_transitions
    type:
      - 'null'
      - boolean
    doc: Output All Transition Events (slower)
    inputBinding:
      position: 101
      prefix: --output_all_transitions
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress log messages
    inputBinding:
      position: 101
      prefix: --quiet
  - id: rates
    type: File
    doc: State Transition Rates (TSV)
    inputBinding:
      position: 101
      prefix: --rates
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: Random Number Generation Seed
    inputBinding:
      position: 101
      prefix: --rng_seed
outputs:
  - id: output
    type: Directory
    doc: Output Directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemf_favites:1.0.3--h7b50bb2_1
