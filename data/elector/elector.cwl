cwlVersion: v1.2
class: CommandLineTool
baseCommand: elector
label: elector
doc: "elector is a tool for correcting long reads.\n\nTool homepage: https://github.com/kamimrcht/ELECTOR"
inputs:
  - id: assemble
    type:
      - 'null'
      - boolean
    doc: Perform assembly of the corrected reads
    inputBinding:
      position: 101
      prefix: -assemble
  - id: corrected
    type:
      - 'null'
      - File
    doc: Fasta file with corrected reads (each read sequence on one line)
    inputBinding:
      position: 101
      prefix: -corrected
  - id: corrector
    type:
      - 'null'
      - string
    doc: "Corrector used (lowercase, in this list: canu, colormap, consent, daccord,
      ectools, flas, fmlrc, halc, hercules, hg-color, jabba, lsc, lordec, lorma, mecat,
      nas, nanocorr, pbdagcon, proovread). If no corrector name is provided, make
      sure the read's headers are correctly formatted (i.e. they correspond to those
      of uncorrected and reference files)"
    inputBinding:
      position: 101
      prefix: -corrector
  - id: dazz_db
    type:
      - 'null'
      - string
    doc: Reads database used for the correction, if the reads were corrected 
      with Daccord or PBDagCon
    inputBinding:
      position: 101
      prefix: -dazzDb
  - id: min_size
    type:
      - 'null'
      - int
    doc: Do not assess reads/fragments chose length is <= MINSIZE % of the 
      original read
    inputBinding:
      position: 101
      prefix: -minsize
  - id: noplot
    type:
      - 'null'
      - boolean
    doc: Do not output plots and PDF report with R/LaTeX
    inputBinding:
      position: 101
      prefix: -noplot
  - id: perfect
    type:
      - 'null'
      - File
    doc: Fasta file with reference read sequences (each read sequence on one 
      line)
    inputBinding:
      position: 101
      prefix: -perfect
  - id: reference
    type:
      - 'null'
      - File
    doc: Fasta file with reference genome sequences (each sequence on one line)
    inputBinding:
      position: 101
      prefix: -reference
  - id: remap
    type:
      - 'null'
      - boolean
    doc: Perform remapping of the corrected reads to the reference
    inputBinding:
      position: 101
      prefix: -remap
  - id: simulator
    type:
      - 'null'
      - string
    doc: Tool used for the simulation of the long reads (either nanosim, 
      simlord, or real). Value real should be used if assessing real data.
    inputBinding:
      position: 101
      prefix: -simulator
  - id: split
    type:
      - 'null'
      - boolean
    doc: Corrected reads are split
    inputBinding:
      position: 101
      prefix: -split
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -threads
  - id: uncorrected
    type:
      - 'null'
      - string
    doc: Prefix of the reads simulation files
    inputBinding:
      position: 101
      prefix: -uncorrected
outputs:
  - id: output_dir_path
    type:
      - 'null'
      - Directory
    doc: Name for output directory
    outputBinding:
      glob: $(inputs.output_dir_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elector:1.0.4--py312h719dbc0_5
