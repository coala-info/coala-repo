cwlVersion: v1.2
class: CommandLineTool
baseCommand: disulfinder
label: disulfinder
doc: "Predicts disulfide bonding state and connectivity from protein sequences.
  Input is a PSI-BLAST profile (psi2 format) or a FASTA file; FASTA input needs
  blastpgp and a BLAST database (-d).\n\nTool homepage: https://github.com/ajvenkat/disulfinder-test"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
      - Directory
    doc: 'input in fasta format, either as single file or directory'
    inputBinding:
      position: 101
      prefix: --fasta
  - id: psi2
    type:
      - 'null'
      - File
      - Directory
    doc: 'input in psi2 format, either a single file or a directory'
    inputBinding:
      position: 101
      prefix: --psi2
  - id: input_list
    type:
      - 'null'
      - File
    doc: 'file containing list of input files from directory (assumes -p or -f specify
      a directory)'
    inputBinding:
      position: 101
      prefix: --input
  - id: alternatives
    type:
      - 'null'
      - int
    doc: alternative connectivity patterns (default=3)
    inputBinding:
      position: 101
      prefix: --alternatives
  - id: format
    type:
      - 'null'
      - string
    doc: output format type (ascii or html default=ascii)
    inputBinding:
      position: 101
      prefix: --format
  - id: output_dir
    type: string
    default: predictions
    doc: output dir where predictions will be saved (default=PWD); created before
      the run
    inputBinding:
      position: 101
      prefix: --output
  - id: rootdir
    type:
      - 'null'
      - string
    doc: predictor working directory (default=~/disulfinder)
    inputBinding:
      position: 101
      prefix: --rootdir
  - id: pkgdatadir
    type:
      - 'null'
      - Directory
    doc: predictor data directory (default=/usr/share/disulfinder)
    inputBinding:
      position: 101
      prefix: --pkgdatadir
  - id: blastdb
    type:
      - 'null'
      - File
    doc: blastpgp -d option (default=/data/sp+trembl)
    secondaryFiles:
      - pattern: .phr
        required: false
      - pattern: .pin
        required: false
      - pattern: .psq
        required: false
    inputBinding:
      position: 101
      prefix: --blastdb
  - id: cleanpred
    type:
      - 'null'
      - boolean
    doc: cleanup intermediate prediction files (default=false)
    inputBinding:
      position: 101
      prefix: --cleanpred
  - id: usepssm
    type:
      - 'null'
      - boolean
    doc: use pssm instead of counts for profiles (default=false)
    inputBinding:
      position: 101
      prefix: --usepssm
  - id: knownbondingstate
    type:
      - 'null'
      - boolean
    doc: assume bonding state is known (one file for each chain in directory
      <rootdir>/Predictions/Bondstate/Viterbi) (default=false)
    inputBinding:
      position: 101
      prefix: --knownbondingstate
outputs:
  - id: predictions
    type:
      type: array
      items: File
    doc: Prediction files, one per input chain, named after the input file
    outputBinding:
      glob: $(inputs.output_dir)/*
  - id: predictions_dir
    type: Directory
    doc: Output directory with the predictions
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: PWD
        envValue: $(runtime.outdir)
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_dir)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/disulfinder:v1.2.11-8-deb_cv1
