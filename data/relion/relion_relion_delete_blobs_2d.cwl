cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_delete_blobs_2d
label: relion_relion_delete_blobs_2d
doc: "Remove blob-like objects (ice contaminations, carbon edges) from micrographs.\n\nTool homepage:\
  \ https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Micrograph lists filename
    inputBinding:
      position: 101
      prefix: --i
  - id: md
    type: string
    doc: Micrographs directory
    inputBinding:
      position: 101
      prefix: --md
  - id: bd
    type: string
    doc: Initial blobs directory
    inputBinding:
      position: 101
      prefix: --bd
  - id: output
    type: string
    doc: Output filename pattern
    inputBinding:
      position: 101
      prefix: --o
  - id: ptc
    type:
      - 'null'
      - File
    doc: Optional particles file for phase flipping
    inputBinding:
      position: 101
      prefix: --ptc
  - id: ring_min
    type:
      - 'null'
      - float
    doc: 'Inner radius of ring to isolate (relative to blob surface) (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --ring_min
  - id: ring_max
    type:
      - 'null'
      - float
    doc: 'Outer radius of ring to isolate (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --ring_max
  - id: ring_edge_sigma
    type:
      - 'null'
      - float
    doc: 'Smoothness sigma of isolation ring (RELION default: 32)'
    inputBinding:
      position: 101
      prefix: --ring_edge_sigma
  - id: c2f
    type:
      - 'null'
      - boolean
    doc: Apply a coarse-to-fine progression instead of initialising with a global pre-fit
    inputBinding:
      position: 101
      prefix: --c2f
  - id: rnd
    type:
      - 'null'
      - float
    doc: 'Roundedness prior (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --rnd
  - id: smt
    type:
      - 'null'
      - float
    doc: 'Outline average smoothness (negative means full average) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --smt
  - id: sig
    type:
      - 'null'
      - float
    doc: 'Weight of initial position (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --sig
  - id: bin0
    type:
      - 'null'
      - float
    doc: 'Initial (maximal) binning factor (RELION default: 8)'
    inputBinding:
      position: 101
      prefix: --bin0
  - id: bin1
    type:
      - 'null'
      - float
    doc: 'Final (minimal) binning factor (RELION default: 4)'
    inputBinding:
      position: 101
      prefix: --bin1
  - id: nomask
    type:
      - 'null'
      - boolean
    doc: Do not mask out neighbouring blobs
    inputBinding:
      position: 101
      prefix: --nomask
  - id: diag
    type:
      - 'null'
      - boolean
    doc: Write out diagnostic information
    inputBinding:
      position: 101
      prefix: --diag
  - id: n
    type:
      - 'null'
      - int
    doc: 'Number of frequencies (RELION default: 12)'
    inputBinding:
      position: 101
      prefix: --n
  - id: th
    type:
      - 'null'
      - float
    doc: 'Blob thickness [fraction of radius] (RELION default: 0.25)'
    inputBinding:
      position: 101
      prefix: --th
  - id: hp
    type:
      - 'null'
      - float
    doc: 'High-pass sigma [Å, real space] (RELION default: 300)'
    inputBinding:
      position: 101
      prefix: --hp
  - id: max_iters
    type:
      - 'null'
      - float
    doc: 'Maximum number of iterations (RELION default: 1000)'
    inputBinding:
      position: 101
      prefix: --max_iters
  - id: cth
    type:
      - 'null'
      - float
    doc: 'Convergence threshold (RELION default: 0.02)'
    inputBinding:
      position: 101
      prefix: --cth
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of OMP threads (RELION default: 6)'
    inputBinding:
      position: 101
      prefix: --j
  - id: theme
    type:
      - 'null'
      - string
    doc: 'Select display theme (RELION default: molten)'
    inputBinding:
      position: 101
      prefix: --theme
  - id: list_themes
    type:
      - 'null'
      - boolean
    doc: List available themes and quit
    inputBinding:
      position: 101
      prefix: --list_themes
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Output files written with the output filename pattern
    outputBinding:
      glob: $(inputs.output)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_delete_blobs_2d.out
