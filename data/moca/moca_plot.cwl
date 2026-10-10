cwlVersion: v1.2
class: CommandLineTool
baseCommand: [moca, plot]
label: moca_plot
doc: "Create conservation plots\n\nTool homepage: https://github.com/saketkc/moca"
inputs:
  - id: centrimo_dir
    type: Directory
    doc: Centrimo output directory
    inputBinding:
      position: 101
      prefix: --centrimo-dir
  - id: configuration
    type: File
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: --configuration
  - id: fimo_dir_control
    type: Directory
    doc: Control fimo.txt
    inputBinding:
      position: 101
      prefix: --fimo-dir-control
  - id: fimo_dir_sample
    type: Directory
    doc: Sample fimo.txt
    inputBinding:
      position: 101
      prefix: --fimo-dir-sample
  - id: flank_motif
    type: int
    doc: Length of sequence flanking motif
    inputBinding:
      position: 101
      prefix: --flank-motif
  - id: genome_build
    type: string
    doc: Key denoting genome build to use in configuration file
    inputBinding:
      position: 101
      prefix: --genome-build
  - id: meme_dir
    type: Directory
    doc: MEME output directory
    inputBinding:
      position: 101
      prefix: --meme-dir
  - id: motif
    type:
      - 'null'
      - int
    doc: Motif number
    inputBinding:
      position: 101
      prefix: --motif
  - id: name
    type:
      - 'null'
      - string
    doc: Plot title
    inputBinding:
      position: 101
      prefix: --name
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: Print progress
    inputBinding:
      position: 101
      prefix: --show-progress
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the configuration file (genome FASTA, chromosome sizes,
      conservation bigWig). They are staged in the working directory.
  - id: oc
    type: string
    doc: Output Directory
    inputBinding:
      position: 102
      prefix: --oc
outputs:
  - id: oc_dir
    type: Directory
    doc: Output Directory
    outputBinding:
      glob: $(inputs.oc)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fimo_dir_sample)
        writable: true
      - entry: $(inputs.fimo_dir_control)
        writable: true
      - $(inputs.staged_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moca:0.4.3--py27_0
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONWARNINGS
        envValue: ignore
      - envName: MPLCONFIGDIR
        envValue: /tmp
