cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslMap
label: comparative-annotation-toolkit_pslMap
doc: "map PSLs alignments to new targets using alignments of the old target to the
  new target. Given inPsl and mapPsl, where the target of inPsl is the query of mapPsl,
  create a new PSL with the query of inPsl aligned to all the targets of mapPsl. If
  inPsl is a protein to nucleotide alignment and mapPsl is a nucleotide to nucleotide
  alignment, the resulting alignment is nucleotide to nucleotide alignment of a hypothetical
  mRNA that would code for the protein. This is useful as it gives base alignments
  of spliced codons. A chain file may be used instead mapPsl.\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/Comparative-Annotation-Toolkit"
inputs:
  - id: in_psl
    type: File
    doc: Input PSL file
    inputBinding:
      position: 1
  - id: map_file
    type: File
    doc: Map file (PSL or chain)
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
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbose output. 2 - show each overlap and the mapping
    inputBinding:
      position: 103
      prefix: -verbose=n
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
    doc: 'output a file with information about each mapping. The file has the following
      columns: o srcQName, srcQStart, srcQEnd, srcQSize - qName, etc of psl being
      mapped (source alignment) o srcTName, srcTStart, srcTEnd - tName, etc of psl
      being mapped o srcStrand - strand of psl being mapped o srcAligned - number
      of aligned based in psl being mapped o mappingQName, mappingQStart, mappingQEnd
      - qName, etc of mapping psl used to map alignment o mappingTName, mappingTStart,
      mappingTEnd - tName, etc of mapping psl o mappingStrand - strand of mapping
      psl o mappingId - chain id, or psl file row o mappedQName mappedQStart, mappedQEnd
      - qName, etc of mapped psl o mappedTName, mappedTStart, mappedTEnd - tName,
      etc of mapped psl o mappedStrand - strand of mapped psl o mappedAligned - number
      of aligned bases that were mapped o qStartTrunc - aligned bases at qStart not
      mapped due to mapping psl/chain not covering the entire soruce psl. This is
      from the start of the query in the positive direction. o qEndTrunc - similary
      for qEnd If the psl count not be mapped, the mapping* and mapped* columns are
      empty.'
    outputBinding:
      glob: $(inputs.map_info_file)
  - id: mapping_psls_file
    type:
      - 'null'
      - File
    doc: write mapping alignments that were used in PSL format to this file. 
      Transformations that were done, such as -swapMap, will be reflected in 
      this file. There will be a one-to-one correspondence of rows of this file 
      to rows of the outPsl file.
    outputBinding:
      glob: $(inputs.mapping_psls_file)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/comparative-annotation-toolkit:0.1--pyh2407274_1
