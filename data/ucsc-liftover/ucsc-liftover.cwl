cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftOver
label: ucsc-liftover
doc: Move annotations from one assembly to another
inputs:
  - id: old_file
    type: File
    doc: oldFile in bed format by default, or GFF/other formats with appropriate
      flags
    inputBinding:
      position: 1
  - id: map_chain
    type:
      - 'null'
      - File
    doc: The map.chain file has the old genome as the target and the new genome 
      as the query
    inputBinding:
      position: 2
  - id: new_file
    type: string
    doc: Output mapped file
    inputBinding:
      position: 3
  - id: unmapped
    type: string
    doc: Output unmapped file
    inputBinding:
      position: 4
  - id: min_match
    type:
      - 'null'
      - float
    doc: Minimum ratio of bases that must remap. Default 0.95
    inputBinding:
      position: 105
      prefix: -minMatch=
      separate: false
  - id: gff
    type:
      - 'null'
      - boolean
    doc: File is in gff/gtf format. Note that the gff lines are converted 
      separately. It would be good to have a separate check after this that the 
      lines that make up a gene model still make a plausible gene after liftOver
    inputBinding:
      position: 105
      prefix: -gff
  - id: gene_pred
    type:
      - 'null'
      - boolean
    doc: File is in genePred format
    inputBinding:
      position: 105
      prefix: -genePred
  - id: sample
    type:
      - 'null'
      - boolean
    doc: File is in sample format
    inputBinding:
      position: 105
      prefix: -sample
  - id: bed_plus
    type:
      - 'null'
      - int
    doc: File is bed N+ format (i.e. first N fields conform to bed format)
    inputBinding:
      position: 105
      prefix: -bedPlus=
      separate: false
  - id: positions
    type:
      - 'null'
      - boolean
    doc: File is in browser "position" format
    inputBinding:
      position: 105
      prefix: -positions
  - id: has_bin
    type:
      - 'null'
      - boolean
    doc: File has bin value (used only with -bedPlus)
    inputBinding:
      position: 105
      prefix: -hasBin
  - id: tab
    type:
      - 'null'
      - boolean
    doc: Separate by tabs rather than space (used only with -bedPlus)
    inputBinding:
      position: 105
      prefix: -tab
  - id: psl_t
    type:
      - 'null'
      - boolean
    doc: File is in psl format, map target side only
    inputBinding:
      position: 105
      prefix: -pslT
  - id: ends
    type:
      - 'null'
      - int
    doc: Lift the first and last N bases of each record and combine the result. 
      This is useful for lifting large regions like BAC end pairs.
    inputBinding:
      position: 105
      prefix: -ends=
      separate: false
  - id: min_blocks
    type:
      - 'null'
      - float
    doc: Minimum ratio of alignment blocks or exons that must map (default 1.00)
    inputBinding:
      position: 105
      prefix: -minBlocks=
      separate: false
  - id: fudge_thick
    type:
      - 'null'
      - boolean
    doc: (bed 12 or 12+ only) If thickStart/thickEnd is not mapped, use the 
      closest mapped base. Recommended if using -minBlocks.
    inputBinding:
      position: 105
      prefix: -fudgeThick
  - id: multiple
    type:
      - 'null'
      - boolean
    doc: Allow multiple output regions
    inputBinding:
      position: 105
      prefix: -multiple
  - id: no_serial
    type:
      - 'null'
      - boolean
    doc: In -multiple mode, do not put a serial number in the 5th BED column
    inputBinding:
      position: 105
      prefix: -noSerial
  - id: min_chain_t
    type:
      - 'null'
      - int
    doc: Minimum chain size in target, when mapping to multiple output regions 
      (default 0)
    inputBinding:
      position: 105
      prefix: -minChainT
  - id: min_chain_q
    type:
      - 'null'
      - int
    doc: Minimum chain size in query, when mapping to multiple output regions 
      (default 0)
    inputBinding:
      position: 105
      prefix: -minChainQ
  - id: min_size_t
    type:
      - 'null'
      - int
    doc: deprecated synonym for -minChainT (ENCODE compat.)
    inputBinding:
      position: 105
      prefix: -minSizeT
  - id: min_size_q
    type:
      - 'null'
      - int
    doc: Min matching region size in query with -multiple.
    inputBinding:
      position: 105
      prefix: -minSizeQ
  - id: chain_table
    type:
      - 'null'
      - string
    doc: Used with -multiple, format is db.tablename, to extend chains from net 
      (preserves dups)
    inputBinding:
      position: 105
      prefix: -chainTable
  - id: error_help
    type:
      - 'null'
      - boolean
    doc: Explain error messages
    inputBinding:
      position: 105
      prefix: -errorHelp
  - id: preserve_input
    type:
      - 'null'
      - boolean
    doc: Attach positions from the input file to item names, to assist in 
      determining what got mapped where (bed4+, gff, genePred, sample only)
    inputBinding:
      position: 105
      prefix: -preserveInput
outputs:
  - id: out_new_file
    type: File
    doc: Output mapped file
    outputBinding:
      glob: $(inputs.new_file)
  - id: out_unmapped
    type: File
    doc: Output unmapped file
    outputBinding:
      glob: $(inputs.unmapped)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-liftover:482--h0b57e2e_0
s:url: https://hgdownload.cse.ucsc.edu/admin/exe
$namespaces:
  s: https://schema.org/
