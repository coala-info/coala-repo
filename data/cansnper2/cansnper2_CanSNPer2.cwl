cwlVersion: v1.2
class: CommandLineTool
baseCommand: CanSNPer2
label: cansnper2_CanSNPer2
doc: "CanSNPer2\n\nTool homepage: https://github.com/FOI-Bioinformatics/CanSNPer2"
inputs:
  - id: query
    type:
      - 'null'
      - type: array
        items: File
    doc: File(s) to align (fasta)
    inputBinding:
      position: 1
  - id: database
    type: string
    doc: CanSNP database
    inputBinding:
      position: 102
      prefix: -db
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 102
      prefix: --debug
  - id: keep_going
    type:
      - 'null'
      - boolean
    doc: If Error occurs, continue with the rest of samples
    inputBinding:
      position: 102
      prefix: --keep_going
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: keep temporary files
    inputBinding:
      position: 102
      prefix: --keep_temp
  - id: logdir
    type:
      - 'null'
      - boolean
    doc: Specify log directory
    inputBinding:
      position: 102
      prefix: --logdir
  - id: min_required_hits
    type:
      - 'null'
      - int
    doc: Minimum sequential hits to call a SNP!
    inputBinding:
      position: 102
      prefix: --min_required_hits
  - id: no_snpfiles
    type:
      - 'null'
      - boolean
    doc: Don't save output files.
    inputBinding:
      position: 102
      prefix: --no_snpfiles
  - id: read_input
    type:
      - 'null'
      - boolean
    doc: Select if input is reads not fasta
    inputBinding:
      position: 102
      prefix: --read_input
  - id: refdir
    type:
      - 'null'
      - boolean
    doc: Specify reference directory
    inputBinding:
      position: 102
      prefix: --refdir
  - id: rerun
    type:
      - 'null'
      - boolean
    doc: "Rerun already processed files (else skip if result\n                   \
      \     file exists)"
    inputBinding:
      position: 102
      prefix: --rerun
  - id: save_tree
    type:
      - 'null'
      - boolean
    doc: Save tree as PDF using ETE3
    inputBinding:
      position: 102
      prefix: --save_tree
  - id: skip_mauve
    type:
      - 'null'
      - boolean
    doc: If xmfa files already exists skip step
    inputBinding:
      position: 102
      prefix: --skip_mauve
  - id: strictness
    type:
      - 'null'
      - float
    doc: Percent of snps in path reqired for calling SNP
    inputBinding:
      position: 102
      prefix: --strictness
  - id: summary
    type:
      - 'null'
      - boolean
    doc: "Output a summary file and tree with all called SNPs\n                  \
      \      not affected by no_snpfiles"
    inputBinding:
      position: 102
      prefix: --summary
  - id: supress
    type:
      - 'null'
      - boolean
    doc: Supress warnings
    inputBinding:
      position: 102
      prefix: --supress
  - id: tmpdir
    type:
      - 'null'
      - boolean
    doc: Specify reference directory
    inputBinding:
      position: 102
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: workdir
    type:
      - 'null'
      - boolean
    doc: Change workdir default (./)
    inputBinding:
      position: 102
      prefix: --workdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansnper2:2.0.6--py_0
