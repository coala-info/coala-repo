cwlVersion: v1.2
class: CommandLineTool
baseCommand: [moca, find_motifs]
label: moca_find_motifs
doc: "Search motifs and create conservation plots\n\nTool homepage: https://github.com/saketkc/moca"
inputs:
  - id: bedfile
    type: File
    doc: Bed file input
    inputBinding:
      position: 101
      prefix: --bedfile
  - id: configuration
    type: File
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: --configuration
  - id: cores
    type: int
    doc: Number of parallel MEME jobs
    inputBinding:
      position: 101
      prefix: --cores
  - id: flank_motif
    type:
      - 'null'
      - int
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
  - id: n_motif
    type:
      - 'null'
      - int
    doc: Number of motifs
    inputBinding:
      position: 101
      prefix: --n-motif
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: Print progress
    inputBinding:
      position: 101
      prefix: --show-progress
  - id: slop_length
    type:
      - 'null'
      - int
    doc: Flanking sequence length
    inputBinding:
      position: 101
      prefix: --slop-length
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
