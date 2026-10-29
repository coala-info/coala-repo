cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_backproject_2d
label: relion_relion_backproject_2d
doc: "Reconstruct 2D class averages by back-projection (class-average post-processing).\n\nTool homepage:\
  \ https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: output
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --o
  - id: input
    type:
      - 'null'
      - File
    doc: Input file (e.g. run_it023_data.star)
    inputBinding:
      position: 101
      prefix: --i
  - id: reextract
    type:
      - 'null'
      - boolean
    doc: Extract particles from the micrographs
    inputBinding:
      position: 101
      prefix: --reextract
  - id: dual_contrast
    type:
      - 'null'
      - boolean
    doc: Perform a dual-contrast reconstruction
    inputBinding:
      position: 101
      prefix: --dual_contrast
  - id: SNR
    type:
      - 'null'
      - float
    doc: 'Assumed signal-to-noise ratio (RELION default: 0.1)'
    inputBinding:
      position: 101
      prefix: --SNR
  - id: m
    type:
      - 'null'
      - int
    doc: 'Margin around the particle [Px] (RELION default: 20)'
    inputBinding:
      position: 101
      prefix: --m
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
