cwlVersion: v1.2
class: CommandLineTool
baseCommand: SCALOP
label: scalop_SCALOP
doc: "Sequence-based antibody Canonical LOoP structure annotation\n\nTool homepage:
  https://github.com/oxpig/SCALOP"
inputs:
  - id: arma_inc
    type:
      - 'null'
      - string
    doc: '[for updater] Resolution of structures to be clustered'
    inputBinding:
      position: 101
      prefix: --armadillo_include
  - id: bfactor_cutoff
    type:
      - 'null'
      - float
    doc: '[for updater] Maximum B factor of backbone atoms in the loop'
    inputBinding:
      position: 101
      prefix: --bfactor
  - id: cdr_definition
    type:
      - 'null'
      - string
    doc: CDR region definition
    inputBinding:
      position: 101
      prefix: --cdr_definition
  - id: db_version
    type:
      - 'null'
      - string
    doc: Database version in YYYY-MM (e.g. '2017-07') or YYYY for data included 
      by the end of the year
    inputBinding:
      position: 101
      prefix: --db_version
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: '[for updater] Loop database directory'
    inputBinding:
      position: 101
      prefix: --dbdir
  - id: hc
    type:
      - 'null'
      - string
    doc: Heavy Chain ID
    inputBinding:
      position: 101
      prefix: --hc
  - id: input_sequence
    type:
      - 'null'
      - string
    doc: Input sequence(s)
    inputBinding:
      position: 101
      prefix: --assign
  - id: lc
    type:
      - 'null'
      - string
    doc: Light Chain ID
    inputBinding:
      position: 101
      prefix: --lc
  - id: loopdb
    type:
      - 'null'
      - Directory
    doc: Loop structures directory
    inputBinding:
      position: 101
      prefix: --loopdb
  - id: numbering_scheme
    type:
      - 'null'
      - string
    doc: Antibody chain numbering scheme
    inputBinding:
      position: 101
      prefix: --numbering_scheme
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format
    inputBinding:
      position: 101
      prefix: --output_ext
  - id: pylib
    type:
      - 'null'
      - Directory
    doc: '[for updater] Location of ABDB python module (e.g. ~/bin/Python/ABDB)'
    inputBinding:
      position: 101
      prefix: --sabdabpydir
  - id: sabdabscript
    type:
      - 'null'
      - Directory
    doc: '[for updater] Location of SAbDab bin script (e.g. ~/bin/)'
    inputBinding:
      position: 101
      prefix: --sabdabdir
  - id: sabdabu
    type:
      - 'null'
      - string
    doc: '[for updater] Whether or not to update SAbDab ([yes]/no)'
    inputBinding:
      position: 101
      prefix: --sabdabu
  - id: struc_cutoff
    type:
      - 'null'
      - float
    doc: '[for updater] Resolution of structures to be clustered'
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: structure
    type:
      - 'null'
      - File
    doc: Input framework structure
    inputBinding:
      position: 101
      prefix: --structure
  - id: update
    type:
      - 'null'
      - boolean
    doc: Perform an update to a copy of the database that you have write 
      permissions for
    inputBinding:
      position: 101
      prefix: --update
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory (default = console output)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scalop:2021.01.27--py_0
