cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - poppunk
label: poppunk_qc-db
doc: "Run quality control on a PopPUNK reference database and write the passing samples to\
  \ a new database (poppunk --qc-db).\n\nTool homepage: https://github.com/johnlees/PopPUNK"
arguments:
  - position: 100
    valueFrom: --qc-db
inputs:
  - id: ref_db
    type: Directory
    doc: Reference database folder made by --create-db (holds <name>.h5 and <name>.dists.*).
    inputBinding:
      position: 101
      prefix: --ref-db
  - id: output
    type: string
    doc: Output folder (prefix for output files).
    default: poppunk_qc
    inputBinding:
      position: 101
      prefix: --output
  - id: qc_keep
    type:
      - 'null'
      - boolean
    doc: Only write failing sequences to a file, don't remove them from the database file.
    inputBinding:
      position: 101
      prefix: --qc-keep
  - id: remove_samples
    type:
      - 'null'
      - File
    doc: File with a list of sample names to remove from the database (regardless of any other
      QC).
    inputBinding:
      position: 101
      prefix: --remove-samples
  - id: retain_failures
    type:
      - 'null'
      - boolean
    doc: Retain sketches of genomes that do not pass QC filters in separate database.
    inputBinding:
      position: 101
      prefix: --retain-failures
  - id: max_a_dist
    type:
      - 'null'
      - float
    doc: Maximum accessory distance to permit [default = 0.5].
    inputBinding:
      position: 101
      prefix: --max-a-dist
  - id: max_pi_dist
    type:
      - 'null'
      - float
    doc: Maximum core distance to permit [default = 0.1].
    inputBinding:
      position: 101
      prefix: --max-pi-dist
  - id: max_zero_dist
    type:
      - 'null'
      - float
    doc: Maximum proportion of zero distances to permit [default = 0.05].
    inputBinding:
      position: 101
      prefix: --max-zero-dist
  - id: length_sigma
    type:
      - 'null'
      - float
    doc: Number of standard deviations of length distribution beyond which sequences will
      be excluded [default = 5].
    inputBinding:
      position: 101
      prefix: --length-sigma
  - id: length_range
    type:
      - 'null'
      - type: array
        items: long
    doc: 'Allowed length range (two values: lower and upper bounds); sequences outside are
      excluded.'
    inputBinding:
      position: 101
      prefix: --length-range
  - id: prop_n
    type:
      - 'null'
      - float
    doc: Threshold ambiguous base proportion above which sequences will be excluded [default
      = 0.1].
    inputBinding:
      position: 101
      prefix: --prop-n
  - id: upper_n
    type:
      - 'null'
      - int
    doc: Threshold ambiguous base count above which sequences will be excluded.
    inputBinding:
      position: 101
      prefix: --upper-n
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use [default = 1].
    inputBinding:
      position: 101
      prefix: --threads
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite any existing database files.
    inputBinding:
      position: 101
      prefix: --overwrite
outputs:
  - id: output_dir
    type: Directory
    doc: Output folder.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
