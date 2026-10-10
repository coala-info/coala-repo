cwlVersion: v1.2
class: CommandLineTool
baseCommand: [modle_tools, annotate-barriers]
label: modle_tools_annotate_barriers
doc: "Helper tool to generate an extrusion barrier annotation for MoDLE.\n\nTool homepage: https://github.com/paulsengroup/MoDLE"
inputs:
  - id: chip_bigwig
    type: File
    doc: Path to a BigWig file. This is usually a ChIP-seq BigWig file with the
      fold-change over control for CTCF/RAD21. Values from this file are used to
      compute extrusion barrier occupancies.
    inputBinding:
      position: 1
  - id: binding_sites
    type: File
    doc: Path to a BED6+ file with the list of candidate extrusion barriers. This
      is usually the ChIP-seq broad/narrowPeak for CTCF/RAD21.
    inputBinding:
      position: 2
  - id: scaling_factor
    type:
      - 'null'
      - float
    doc: Scaling factor to use in the logistic transformation. This value is used
      to divide peak summits read from the bigWig file provided as input.
    inputBinding:
      position: 101
      prefix: --scaling-factor
  - id: occupancy_lower_bound
    type:
      - 'null'
      - float
    doc: Lower bound for the barrier occupancy. Bins with an occupancy smaller
      than this value will be discarded or clamped, depending on whether
      --clamp-occupancy was specified.
    inputBinding:
      position: 101
      prefix: --occupancy-lower-bound
  - id: occupancy_upper_bound
    type:
      - 'null'
      - float
    doc: Upper bound for the barrier occupancy. Bins with an occupancy greater
      than this value will be discarded or clamped, depending on whether
      --clamp-occupancy was specified.
    inputBinding:
      position: 101
      prefix: --occupancy-upper-bound
  - id: clamp_occupancy
    type:
      - 'null'
      - boolean
    doc: Clamp occupancy values falling outside of the interval specified through
      --lb and --ub.
    inputBinding:
      position: 101
      prefix: --clamp-occupancy
  - id: no_clamp_occupancy
    type:
      - 'null'
      - boolean
    doc: Do not clamp occupancy values falling outside of the interval specified
      through --lb and --ub.
    inputBinding:
      position: 101
      prefix: --no-clamp-occupancy
outputs:
  - id: stdout
    type: stdout
    doc: Extrusion barrier annotation in BED format
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/modle:1.1.0--h63853f4_0
stdout: modle_tools_annotate_barriers.bed
