cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_find_fiducials
label: relion_relion_tomo_find_fiducials
doc: "Find gold fiducial markers in tomograms.\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: optimisation_set
    type:
      - 'null'
      - File
    doc: Optimisation set
    inputBinding:
      position: 101
      prefix: --i
  - id: tomogram_set
    type:
      - 'null'
      - File
    doc: Tomogram set
    inputBinding:
      position: 101
      prefix: --t
  - id: output
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --o
  - id: detection_threshold
    type:
      - 'null'
      - float
    doc: 'Detection threshold (RELION default: 5)'
    inputBinding:
      position: 101
      prefix: --d
  - id: bead_radius
    type:
      - 'null'
      - float
    doc: 'Bead radius [Å] (RELION default: 50)'
    inputBinding:
      position: 101
      prefix: --r
  - id: min_spacing
    type:
      - 'null'
      - float
    doc: 'Minimal bead spacing (as a multiple of radius, L^inf distance) (RELION default: 1.5)'
    inputBinding:
      position: 101
      prefix: --sp
  - id: search_binning
    type:
      - 'null'
      - int
    doc: 'Search binning level (RELION default: 4)'
    inputBinding:
      position: 101
      prefix: --bin0
  - id: cc_binning
    type:
      - 'null'
      - int
    doc: 'CC binning level (RELION default: 4)'
    inputBinding:
      position: 101
      prefix: --bin1
  - id: diag
    type:
      - 'null'
      - boolean
    doc: Write out diagnostic information
    inputBinding:
      position: 101
      prefix: --diag
  - id: max_tilt_series
    type:
      - 'null'
      - int
    doc: 'Last tilt series to consider (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --max_MG
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
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_find_fiducials.out
