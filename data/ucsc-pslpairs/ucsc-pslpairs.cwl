cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslPairs
label: ucsc-pslpairs
doc: "join paired ends in psl alignments\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_file
    type: File
    doc: "Filtered psl alignments of ends from a kluster run."
    inputBinding:
      position: 1
  - id: pair_file
    type: File
    doc: "Three column tab separated file: forward, reverse, cloneId; forward and reverse columns can be comma separated end ids."
    inputBinding:
      position: 2
  - id: psl_table_name
    type: string
    doc: "Table name the psl alignments have been loaded into."
    inputBinding:
      position: 3
  - id: out_prefix
    type: string
    doc: "Prefix used for each output file name."
    inputBinding:
      position: 4
  - id: max
    type:
      - 'null'
      - int
    doc: "Maximum length of clone sequence (default 47000)."
    inputBinding:
      position: 0
      prefix: "-max="
      separate: false
  - id: min
    type:
      - 'null'
      - int
    doc: "Minimum length of clone sequence (default 32000)."
    inputBinding:
      position: 0
      prefix: "-min="
      separate: false
  - id: slopval
    type:
      - 'null'
      - int
    doc: "Deviation from max/min clone lengths allowed for slop report (default 5000)."
    inputBinding:
      position: 0
      prefix: "-slopval="
      separate: false
  - id: near_top
    type:
      - 'null'
      - float
    doc: "Maximum deviation from best match allowed (default 0.001)."
    inputBinding:
      position: 0
      prefix: "-nearTop="
      separate: false
  - id: min_id
    type:
      - 'null'
      - float
    doc: "Minimum pct ID of at least one end (default 0.96)."
    inputBinding:
      position: 0
      prefix: "-minId="
      separate: false
  - id: min_orphan_id
    type:
      - 'null'
      - float
    doc: "Minimum pct ID for orphan alignment (default 0.96)."
    inputBinding:
      position: 0
      prefix: "-minOrphanId="
      separate: false
  - id: t_insert
    type:
      - 'null'
      - int
    doc: "Maximum insert bases allowed in sequence alignment (default 500)."
    inputBinding:
      position: 0
      prefix: "-tInsert="
      separate: false
  - id: hard_max
    type:
      - 'null'
      - int
    doc: "Absolute maximum clone length for long report (default 75000)."
    inputBinding:
      position: 0
      prefix: "-hardMax="
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Display all informational messages."
    inputBinding:
      position: 0
      prefix: "-verbose"
  - id: no_bin
    type:
      - 'null'
      - boolean
    doc: "Do not include bin column in output file."
    inputBinding:
      position: 0
      prefix: "-noBin"
  - id: no_random
    type:
      - 'null'
      - boolean
    doc: "Do not include placements on random portions (length(chr name) < 7)."
    inputBinding:
      position: 0
      prefix: "-noRandom"
  - id: slop
    type:
      - 'null'
      - boolean
    doc: "Create <outFilePrefix>.slop file of pairs that fall within slop length."
    inputBinding:
      position: 0
      prefix: "-slop"
  - id: short
    type:
      - 'null'
      - boolean
    doc: "Create <outFilePrefix>.short file of pairs shorter than min size."
    inputBinding:
      position: 0
      prefix: "-short"
  - id: long
    type:
      - 'null'
      - boolean
    doc: "Create <outFilePrefix>.long file of pairs longer than max size, but less than hardMax size."
    inputBinding:
      position: 0
      prefix: "-long"
  - id: mismatch
    type:
      - 'null'
      - boolean
    doc: "Create <outFilePrefix>.mismatch file of pairs with bad orientation of ends."
    inputBinding:
      position: 0
      prefix: "-mismatch"
  - id: orphan
    type:
      - 'null'
      - boolean
    doc: "Create <outFilePrefix>.orphan file of unmatched end sequences."
    inputBinding:
      position: 0
      prefix: "-orphan"
outputs:
  - id: pairs
    type: File
    doc: "Pairs file."
    outputBinding:
      glob: $(inputs.out_prefix).pairs
  - id: all_files
    type: File[]
    doc: "All files written with the output prefix (.pairs and the optional .slop, .short, .long, .mismatch and .orphan reports)."
    outputBinding:
      glob: $(inputs.out_prefix).*
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: stderr
    type: stderr
    doc: "Standard error"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslpairs:482--h0b57e2e_0
stdout: ucsc-pslpairs.out
stderr: ucsc-pslpairs.err
