cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - motifscan
  - motif
label: motifscan_motif
doc: "Motif set (PFMs/PWMs) commands.\n\nMotifScan only detects the binding sites
  of known motifs. Before scanning, \nthe motif set should be installed and built
  with PFMs (Position Frequency \nMatrices). Since different assemblies have different
  genome contents, it \nis necessary to build the PFMs and get proper motif score
  cutoffs for every \ngenome assembly you want to scan later.\n\nTool homepage: https://github.com/shao-lab/MotifScan"
inputs:
  - id: build
    type:
      - 'null'
      - string
    doc: "Build an installed motif set for additional genome\n                   \
      \     assembly."
    inputBinding:
      position: 101
      prefix: --build
  - id: database
    type:
      - 'null'
      - string
    doc: "Which remote database is used to list/install motif\n                  \
      \      set (PFMs). Default: jaspar_core"
    inputBinding:
      position: 101
      prefix: --database
  - id: genome
    type:
      - 'null'
      - string
    doc: Genome assembly to build the motif set (PFMs) for.
    inputBinding:
      position: 101
      prefix: --genome
  - id: install
    type:
      - 'null'
      - boolean
    doc: Install a new motif set with PFMs.
    inputBinding:
      position: 101
      prefix: --install
  - id: list
    type:
      - 'null'
      - boolean
    doc: Display installed motif sets.
    inputBinding:
      position: 101
      prefix: --list
  - id: list_remote
    type:
      - 'null'
      - boolean
    doc: Display available remote motif sets.
    inputBinding:
      position: 101
      prefix: --list-remote
  - id: local_pfms_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Local motif PFMs file(s) to be installed.
    inputBinding:
      position: 101
      prefix: --install
  - id: max_n
    type:
      - 'null'
      - int
    doc: "The maximal number of `N` base allowed in each random\n                \
      \        sampled sequence. Default: 0"
    inputBinding:
      position: 101
      prefix: --max-n
  - id: motif_set_name
    type:
      - 'null'
      - string
    doc: Name of the motif set (PFMs) to be installed.
    inputBinding:
      position: 101
      prefix: --name
  - id: n_random
    type:
      - 'null'
      - int
    doc: "Generate N random background sequences to calculate\n                  \
      \      motif score cutoffs. Default: 1,000,000"
    inputBinding:
      position: 101
      prefix: --n-random
  - id: n_repeat
    type:
      - 'null'
      - int
    doc: "Repeat N rounds of random sampling and use the\n                       \
      \ averaged cutoff as final cutoff. Default: 1"
    inputBinding:
      position: 101
      prefix: --n-repeat
  - id: remote_pfms
    type:
      - 'null'
      - string
    doc: Download a remote motif PFMs set.
    inputBinding:
      position: 101
      prefix: --remote
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed used to generate background sequences.
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processes used to run in parallel.
    inputBinding:
      position: 101
      prefix: --threads
  - id: uninstall
    type:
      - 'null'
      - string
    doc: Uninstall a motif set.
    inputBinding:
      position: 101
      prefix: --uninstall
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose log messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Write to a given directory instead of the default\n                    \
      \    directory."
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motifscan:1.3.0--py310h4b81fae_3
