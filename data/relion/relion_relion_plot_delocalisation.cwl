cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_plot_delocalisation
label: relion_relion_plot_delocalisation
doc: "Plot the delocalisation of the signal (CTF-induced information spread) of particles.\n\nTool homepage:\
  \ https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input particle *.star file
    inputBinding:
      position: 101
      prefix: --i
  - id: rad
    type: float
    doc: Particle radius [Å]
    inputBinding:
      position: 101
      prefix: --rad
  - id: output
    type: string
    doc: Output path
    inputBinding:
      position: 101
      prefix: --o
  - id: og
    type:
      - 'null'
      - int
    doc: 'Optics group (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --og
  - id: max_freq
    type:
      - 'null'
      - float
    doc: 'Max. image frequency [Å] (default is Nyquist) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --max_freq
  - id: min_freq
    type:
      - 'null'
      - float
    doc: 'Min. image frequency [Å] (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --min_freq
  - id: name
    type:
      - 'null'
      - string
    doc: Name of dataset (for the plot)
    inputBinding:
      position: 101
      prefix: --name
  - id: all_part
    type:
      - 'null'
      - boolean
    doc: Consider all particles, instead of only the first one in each micrograph
    inputBinding:
      position: 101
      prefix: --all_part
  - id: s
    type:
      - 'null'
      - int
    doc: 'Square size for estimation (RELION default: 256)'
    inputBinding:
      position: 101
      prefix: --s
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
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
    doc: Plots and tables
    outputBinding:
      glob: $(inputs.output)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_plot_delocalisation.out
