cwlVersion: v1.2
class: CommandLineTool
baseCommand: maker
label: maker
doc: "MAKER is a program that produces gene annotations in GFF3 format using evidence
  such as EST alignments and protein homology. MAKER can be used to produce gene annotations
  for new genomes as well as update annotations from existing genome databases.\n\n\
  Tool homepage: http://www.yandell-lab.org/software/maker.html"
inputs:
  - id: maker_opts
    type: string
    doc: Control file for MAKER options
    inputBinding:
      position: 1
  - id: maker_bopts
    type: string
    doc: Control file for MAKER BLAST options
    inputBinding:
      position: 2
  - id: maker_exe
    type: string
    doc: Control file for MAKER executable options
    inputBinding:
      position: 3
  - id: BOPTS
    type:
      - 'null'
      - boolean
    doc: Generates just the maker_bopts.ctl file.
    inputBinding:
      position: 104
      prefix: --BOPTS
  - id: CTL
    type:
      - 'null'
      - boolean
    doc: Generate empty control files in the current directory.
    inputBinding:
      position: 104
      prefix: --CTL
  - id: EXE
    type:
      - 'null'
      - boolean
    doc: Generates just the maker_exe.ctl file.
    inputBinding:
      position: 104
      prefix: --EXE
  - id: OPTS
    type:
      - 'null'
      - boolean
    doc: Generates just the maker_opts.ctl file.
    inputBinding:
      position: 104
      prefix: --OPTS
  - id: TMP
    type:
      - 'null'
      - Directory
    doc: Specify temporary directory to use.
    inputBinding:
      position: 104
      prefix: --TMP
  - id: again
    type:
      - 'null'
      - boolean
    doc: Recalculate all annotations and output files even if no settings have 
      changed. Does not delete old analyses.
    inputBinding:
      position: 104
      prefix: --again
  - id: base
    type:
      - 'null'
      - string
    doc: Set the base name MAKER uses to save output files. MAKER uses the input
      genome file name by default.
    inputBinding:
      position: 104
      prefix: --base
  - id: cpus
    type:
      - 'null'
      - int
    doc: 'Tells how many cpus to use for BLAST analysis. Note: this is for BLAST and
      not for MPI!'
    inputBinding:
      position: 104
      prefix: --cpus
  - id: datastore
    type:
      - 'null'
      - boolean
    doc: Forcably turn on MAKER's deep directory structure for output. Always on
      by default.
    inputBinding:
      position: 104
      prefix: --datastore
  - id: dsindex
    type:
      - 'null'
      - boolean
    doc: Quickly generate datastore index file. Note that this will not check if
      run settings have changed on contigs
    inputBinding:
      position: 104
      prefix: --dsindex
  - id: force
    type:
      - 'null'
      - boolean
    doc: Forces MAKER to delete old files before running again. This will 
      require all blast analyses to be rerun.
    inputBinding:
      position: 104
      prefix: --force
  - id: genome
    type:
      - 'null'
      - File
    doc: Overrides the genome file path in the control files
    inputBinding:
      position: 104
      prefix: --genome
  - id: mwas_server_control
    type:
      - 'null'
      - string
    doc: 'Easy way to control mwas_server for web-based GUI. options: STOP, START,
      RESTART'
    inputBinding:
      position: 104
      prefix: --MWAS
  - id: nodatastore
    type:
      - 'null'
      - boolean
    doc: Forcably turn off MAKER's deep directory structure for output.
    inputBinding:
      position: 104
      prefix: --nodatastore
  - id: nolock
    type:
      - 'null'
      - boolean
    doc: Turn off file locks. May be useful on some file systems, but can cause 
      race conditions if running in parallel.
    inputBinding:
      position: 104
      prefix: --nolock
  - id: old_struct
    type:
      - 'null'
      - boolean
    doc: Use the old directory styles (MAKER 2.26 and lower)
    inputBinding:
      position: 104
      prefix: --old_struct
  - id: qq
    type:
      - 'null'
      - boolean
    doc: Even more quiet. There are no status messages.
    inputBinding:
      position: 104
      prefix: --qq
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Regular quiet. Only a handful of status messages.
    inputBinding:
      position: 104
      prefix: --quiet
  - id: repeat_masking_off
    type:
      - 'null'
      - boolean
    doc: Turns all repeat masking options off.
    inputBinding:
      position: 104
      prefix: --RM_off
  - id: tries
    type:
      - 'null'
      - int
    doc: Run contigs up to the specified number of tries.
    inputBinding:
      position: 104
      prefix: --tries
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maker:3.01.04--pl5321h7b50bb2_0
stdout: maker.out
