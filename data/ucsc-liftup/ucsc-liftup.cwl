cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftUp
label: ucsc-liftup
doc: "Change coordinates of .psl, .agp, .gap, .gl, .out, .align, .gff, .gtf, .bscore,
  .tab, .gdup, .axt, .chain, .net, .gp, .genepred, .wab, .bed, .bed3, or .bed8 files
  to the parent coordinate system. DestFile will contain the merged and lifted source
  files, with the coordinates translated as per liftSpec.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: dest_file
    type: string
    doc: Name of the output file that contains the merged and lifted source files.
      The file type is inferred from its suffix unless type is given.
    inputBinding:
      position: 1
  - id: lift_spec
    type: File
    doc: 'Tab-delimited lift specification, each line: offset oldName oldSize newName
      newSize (optional sixth column: + or - strand).'
    inputBinding:
      position: 2
  - id: how
    type: string
    doc: 'What to do with items that are not in the liftSpec: carry (carried to dest
      without translation), drop (silently dropped), warn (dropped, with a warning)
      or error (generates an error).'
    inputBinding:
      position: 3
  - id: inserts
    type:
      - 'null'
      - File
    doc: Large inserts file; required only when the destination is an .agp file (use
      /dev/null and gapsize if there are no inserts).
    inputBinding:
      position: 4
  - id: source_files
    type:
      type: array
      items: File
    doc: Source file(s) to lift.
    inputBinding:
      position: 5
  - id: type
    type:
      - 'null'
      - string
    doc: Type of files to lift, a file suffix such as .psl or .bed. If omitted the
      type is inferred from the suffix of destFile.
    inputBinding:
      position: 100
      prefix: -type=
      separate: false
  - id: nohead
    type:
      - 'null'
      - boolean
    doc: No header written for .psl files
    inputBinding:
      position: 100
      prefix: -nohead
  - id: dots
    type:
      - 'null'
      - int
    doc: Output a dot every N lines processed
    inputBinding:
      position: 100
      prefix: -dots=
      separate: false
  - id: psl_q
    type:
      - 'null'
      - boolean
    doc: Lift query (rather than target) side of psl
    inputBinding:
      position: 100
      prefix: -pslQ
  - id: axt_q
    type:
      - 'null'
      - boolean
    doc: Lift query (rather than target) side of axt
    inputBinding:
      position: 100
      prefix: -axtQ
  - id: chain_q
    type:
      - 'null'
      - boolean
    doc: Lift query (rather than target) side of chain
    inputBinding:
      position: 100
      prefix: -chainQ
  - id: net_q
    type:
      - 'null'
      - boolean
    doc: Lift query (rather than target) side of net
    inputBinding:
      position: 100
      prefix: -netQ
  - id: waba_q
    type:
      - 'null'
      - boolean
    doc: Lift query (rather than target) side of waba alignment (waba lifts only
      work with query side at this time)
    inputBinding:
      position: 100
      prefix: -wabaQ
  - id: nosort
    type:
      - 'null'
      - boolean
    doc: Do not sort bed, gff, or gdup files, to save memory
    inputBinding:
      position: 100
      prefix: -nosort
  - id: gapsize
    type:
      - 'null'
      - int
    doc: Change contig gapsize from default
    inputBinding:
      position: 100
      prefix: -gapsize=
      separate: false
  - id: ignore_versions
    type:
      - 'null'
      - boolean
    doc: Ignore NCBI-style version number in sequence ids of input files
    inputBinding:
      position: 100
      prefix: -ignoreVersions
  - id: ext_gene_pred
    type:
      - 'null'
      - boolean
    doc: Lift extended genePred
    inputBinding:
      position: 100
      prefix: -extGenePred
outputs:
  - id: out_dest_file
    type: File
    doc: Merged and lifted output file
    outputBinding:
      glob: $(inputs.dest_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-liftup:482--h0b57e2e_0
