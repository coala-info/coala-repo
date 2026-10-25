cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslMap
label: ucsc-pslmap_pslMap
doc: "map PSLs alignments to new targets using alignments of the old target to the new target. Given inPsl and mapPsl, where the target of inPsl is the query of mapPsl, create a new PSL with the query of inPsl aligned to all the targets of mapPsl.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: "Input PSL file."
    inputBinding:
      position: 1
  - id: map_file
    type: File
    doc: "Map PSL file (or chain file with -chainMapFile)."
    inputBinding:
      position: 2
  - id: out_psl
    type: string
    doc: "Output PSL file name."
    inputBinding:
      position: 3
  - id: chain_map_file
    type:
      - 'null'
      - boolean
    doc: "mapFile is a chain file instead of a psl file."
    inputBinding:
      position: 0
      prefix: "-chainMapFile"
  - id: swap_map
    type:
      - 'null'
      - boolean
    doc: "Swap query and target sides of map file."
    inputBinding:
      position: 0
      prefix: "-swapMap"
  - id: swap_in
    type:
      - 'null'
      - boolean
    doc: "Swap query and target sides of inPsl file."
    inputBinding:
      position: 0
      prefix: "-swapIn"
  - id: check
    type:
      - 'null'
      - boolean
    doc: "Validate input, mapping, and mapped PSLs (slower)."
    inputBinding:
      position: 0
      prefix: "-check"
  - id: suffix
    type:
      - 'null'
      - string
    doc: "Append str to the query ids in the output alignment."
    inputBinding:
      position: 0
      prefix: "-suffix="
      separate: false
  - id: keep_translated
    type:
      - 'null'
      - boolean
    doc: "If either psl is translated, the output psl will be translated (both strands explicit)."
    inputBinding:
      position: 0
      prefix: "-keepTranslated"
  - id: map_file_with_in_qname
    type:
      - 'null'
      - boolean
    doc: "The first column of the mapFile PSL records is a qName, the remainder is a standard PSL; only mapping records with the corresponding qName are used."
    inputBinding:
      position: 0
      prefix: "-mapFileWithInQName"
  - id: in_type
    type:
      - 'null'
      - string
    doc: "Input alignment type (prot-port, prot-na, na-na), after swapping if -swapIn is given."
    inputBinding:
      position: 0
      prefix: "-inType="
      separate: false
  - id: map_type
    type:
      - 'null'
      - string
    doc: "Map alignment type (prot-port, prot-na, na-na), after swapping if -swapMap is given."
    inputBinding:
      position: 0
      prefix: "-mapType="
      separate: false
  - id: map_info
    type:
      - 'null'
      - string
    doc: "Output a file with information about each mapping."
    inputBinding:
      position: 0
      prefix: "-mapInfo="
      separate: false
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: "Write the mapInfo output as a TSV rather than autoSql format file."
    inputBinding:
      position: 0
      prefix: "-tsv"
  - id: mapping_psls
    type:
      - 'null'
      - string
    doc: "Write mapping alignments that were used in PSL format to this file."
    inputBinding:
      position: 0
      prefix: "-mappingPsls="
      separate: false
  - id: simplify_mapping_ids
    type:
      - 'null'
      - boolean
    doc: "Simplify mapping ids before matching: drop everything after the last '-', then everything after the last remaining '.'."
    inputBinding:
      position: 0
      prefix: "-simplifyMappingIds"
  - id: verbose
    type:
      - 'null'
      - int
    doc: "Verbose output; 2 shows each overlap and the mapping."
    inputBinding:
      position: 0
      prefix: "-verbose="
      separate: false
outputs:
  - id: out_file
    type: File
    doc: "Mapped PSL file."
    outputBinding:
      glob: $(inputs.out_psl)
  - id: map_info_file
    type:
      - 'null'
      - File
    doc: "Mapping information."
    outputBinding:
      glob: $(inputs.map_info)
  - id: mapping_psls_file
    type:
      - 'null'
      - File
    doc: "Mapping alignments that were used."
    outputBinding:
      glob: $(inputs.mapping_psls)
  - id: stderr
    type: stderr
    doc: "Standard error"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslmap:482--h0b57e2e_0
stderr: ucsc-pslmap_pslMap.err
