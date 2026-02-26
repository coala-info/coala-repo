cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslMap
label: ucsc-pslmap_pslMap
doc: "map PSLs alignments to new targets using alignments of the old target to the
  new target.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_psl
    type: File
    doc: Input PSL file
    inputBinding:
      position: 1
  - id: map_file
    type: File
    doc: Mapping file (PSL or chain)
    inputBinding:
      position: 2
  - id: chain_map_file
    type:
      - 'null'
      - boolean
    doc: mapFile is a chain file instead of a psl file
    inputBinding:
      position: 103
      prefix: -chainMapFile
  - id: check
    type:
      - 'null'
      - boolean
    doc: validate input, mapping, and mapped PSLs. This does slow down the 
      program some, so it is optional.
    inputBinding:
      position: 103
      prefix: -check
  - id: in_type
    type:
      - 'null'
      - string
    doc: input alignment type (prot-port, prot-na, na-na). This is the type 
      after swapping if -swapIn is supplied.
    inputBinding:
      position: 103
      prefix: -inType
  - id: keep_translated
    type:
      - 'null'
      - boolean
    doc: if either psl is translated, the output psl will be translated (both 
      strands explicted). Normally an untranslated psl will always be created
    inputBinding:
      position: 103
      prefix: -keepTranslated
  - id: map_file_with_in_qname
    type:
      - 'null'
      - boolean
    doc: The first column of the mapFile PSL records are a qName, the remainder 
      is a standard PSL. When an inPsl record is mapped, only mapping records 
      are used with the corresponding qName.
    inputBinding:
      position: 103
      prefix: -mapFileWithInQName
  - id: map_type
    type:
      - 'null'
      - string
    doc: map alignment type (prot-port, prot-na, na-na). This is the type after 
      swapping if -swapMap is supplied.
    inputBinding:
      position: 103
      prefix: -mapType
  - id: simplify_mapping_ids
    type:
      - 'null'
      - boolean
    doc: simplifying mapping ids (inPsl target name and mapFile query name) 
      before matching them. This first drops everything after the last `-', and 
      then drops everything after the last remaining `.'.
    inputBinding:
      position: 103
      prefix: -simplifyMappingIds
  - id: suffix
    type:
      - 'null'
      - string
    doc: append str to the query ids in the output alignment. Useful with 
      protein alignments, where the result is not actually and alignment of the 
      protein.
    inputBinding:
      position: 103
      prefix: -suffix
  - id: swap_in
    type:
      - 'null'
      - boolean
    doc: swap query and target sides of inPsl file.
    inputBinding:
      position: 103
      prefix: -swapIn
  - id: swap_map
    type:
      - 'null'
      - boolean
    doc: swap query and target sides of map file.
    inputBinding:
      position: 103
      prefix: -swapMap
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: write output of mapInfo as a TSV rather than autoSql format file.
    inputBinding:
      position: 103
      prefix: -tsv
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbose output
    inputBinding:
      position: 103
      prefix: -verbose
outputs:
  - id: out_psl
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
  - id: map_info_file
    type:
      - 'null'
      - File
    doc: output a file with information about each mapping.
    outputBinding:
      glob: $(inputs.map_info_file)
  - id: mapping_psls
    type:
      - 'null'
      - File
    doc: write mapping alignments that were used in PSL format to this file. 
      Transformations that were done, such as -swapMap, will be reflected in 
      this file. There will be a one-to-one correspondence of rows of this file 
      to rows of the outPsl file.
    outputBinding:
      glob: $(inputs.mapping_psls)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslmap:482--h0b57e2e_0
