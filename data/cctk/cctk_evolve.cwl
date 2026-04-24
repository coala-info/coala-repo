cwlVersion: v1.2
class: CommandLineTool
baseCommand: cctk_evolve
label: cctk_evolve
doc: "Run a simulation of array evolution and plot the resulting tree.\n\nTool homepage:
  https://github.com/Alan-Collins/CRISPR_comparison_toolkit"
inputs:
  - id: acquisition
    type:
      - 'null'
      - int
    doc: relative frequency of spacer acquisitions.
    inputBinding:
      position: 101
      prefix: --acquisition
  - id: branch_spacing
    type:
      - 'null'
      - float
    doc: vertical space between branches scaling
    inputBinding:
      position: 101
      prefix: --branch-spacing
  - id: branch_weight
    type:
      - 'null'
      - float
    doc: thickness of branch lines.
    inputBinding:
      position: 101
      prefix: --branch-weight
  - id: brlen_labels
    type:
      - 'null'
      - boolean
    doc: include branch lengths in tree plot
    inputBinding:
      position: 101
      prefix: --brlen-labels
  - id: brlen_scale
    type:
      - 'null'
      - float
    doc: factor to scale branch length
    inputBinding:
      position: 101
      prefix: --brlen-scale
  - id: deletion
    type:
      - 'null'
      - int
    doc: relative frequency of deletions .
    inputBinding:
      position: 101
      prefix: --deletion
  - id: dpi
    type:
      - 'null'
      - int
    doc: resolution of the output image.
    inputBinding:
      position: 101
      prefix: --dpi
  - id: font_override_annotations
    type:
      - 'null'
      - float
    doc: set annotation font size in pts
    inputBinding:
      position: 101
      prefix: --font-override-annotations
  - id: font_override_labels
    type:
      - 'null'
      - float
    doc: set label font size in pts
    inputBinding:
      position: 101
      prefix: --font-override-labels
  - id: initial_length
    type:
      - 'null'
      - int
    doc: length of the starting array.
    inputBinding:
      position: 101
      prefix: --initial-length
  - id: loss_rate
    type:
      - 'null'
      - int
    doc: rate arrays are lost after spawning descendant.
    inputBinding:
      position: 101
      prefix: --loss-rate
  - id: no_align
    type:
      - 'null'
      - boolean
    doc: draw array labels and cartoons at leaf nodes
    inputBinding:
      position: 101
      prefix: --no-align
  - id: no_emphasize_diffs
    type:
      - 'null'
      - boolean
    doc: don't emphasize events in each array since its ancestor
    inputBinding:
      position: 101
      prefix: --no-emphasize-diffs
  - id: no_fade_anc
    type:
      - 'null'
      - boolean
    doc: do not apply transparency to ancestral array depiction
    inputBinding:
      position: 101
      prefix: --no-fade-anc
  - id: num_events
    type: int
    doc: events to run the simulation
    inputBinding:
      position: 101
      prefix: --num-events
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: output directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: plot_height
    type:
      - 'null'
      - float
    doc: height of plot in inches.
    inputBinding:
      position: 101
      prefix: --plot-height
  - id: plot_width
    type:
      - 'null'
      - float
    doc: width of plot in inches.
    inputBinding:
      position: 101
      prefix: --plot-width
  - id: seed
    type:
      - 'null'
      - int
    doc: set seed for random processes
    inputBinding:
      position: 101
      prefix: --seed
  - id: trailer_loss
    type:
      - 'null'
      - int
    doc: relative frequency of trailer spacer decay.
    inputBinding:
      position: 101
      prefix: --trailer-loss
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cctk:1.0.3--pyhdfd78af_0
stdout: cctk_evolve.out
