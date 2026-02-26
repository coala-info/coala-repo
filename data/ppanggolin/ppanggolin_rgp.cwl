cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ppanggolin
  - rgp
label: ppanggolin_rgp
doc: "For genomic islands and spots of insertion detection, please cite: Bazin A et
  al. (2020) panRGP: a pangenome-based method to predict genomic islands and explore
  their diversity. Bioinformatics, Volume 36, Issue Supplement_2, Pages i651–i658,
  https://doi.org/10.1093/bioinformatics/btaa792\n\nTool homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Specify command arguments through a YAML configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: dup_margin
    type:
      - 'null'
      - float
    doc: Minimum ratio of genomes where the family is present in which the 
      family must have multiple genes for it to be considered 'duplicated'
    inputBinding:
      position: 101
      prefix: --dup_margin
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length (bp) of a region to be considered a RGP
    inputBinding:
      position: 101
      prefix: --min_length
  - id: min_score
    type:
      - 'null'
      - float
    doc: Minimal score wanted for considering a region as being a RGP
    inputBinding:
      position: 101
      prefix: --min_score
  - id: pangenome
    type: File
    doc: The pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: persistent_penalty
    type:
      - 'null'
      - float
    doc: Penalty score to apply to persistent genes
    inputBinding:
      position: 101
      prefix: --persistent_penalty
  - id: variable_gain
    type:
      - 'null'
      - float
    doc: Gain score to apply to variable genes
    inputBinding:
      position: 101
      prefix: --variable_gain
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
