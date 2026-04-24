cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapGL.py
label: mapgl_mapGL.py
doc: "Label input regions as orthologous, gained in the query species, or lost in
  the target species. Chain alignment files are used to map features from query to
  target and one or more outgroup species. Features that map directly from query to
  target are labeled as orthologs, and ortholgous coordinates in the target species
  are given in the output. Non-mapping features are assigned as gains or losses based
  on a maximum-parsimony algorithm predicting presence/absence in the most-recent
  common ancestor. Based on bnMapper.py, by Ogert Denas (James Taylor lab) (https://github.com/bxlab/bx-python/blob/master/scripts/bnMapper.py)\n\
  \nTool homepage: https://github.com/adadiehl/mapGL"
inputs:
  - id: input
    type: File
    doc: Input regions to process. Should be in standard bed format. Only the 
      first four bed fields will be used.
    inputBinding:
      position: 1
  - id: tree
    type: string
    doc: Tree, in standard Newick format, with or without branch lengths, 
      describing relationships of query and target species to outgroups. May be 
      given as a string or file.
    inputBinding:
      position: 2
  - id: qname
    type: string
    doc: Name of the query species. Regions from this species will be mapped to 
      target species coordinates.
    inputBinding:
      position: 3
  - id: tname
    type: string
    doc: Name of the target species. Regions from the query species will be 
      mapped to coordinates from this species.
    inputBinding:
      position: 4
  - id: alignments
    type:
      type: array
      items: File
    doc: 'Alignment files (.chain or .pkl): One for the target species and one per
      outgroup species. Files should be named according to the convention: qname.tname[...].chain.gz,
      where qname is the query species name and tname is the name of the target/outgroup
      species. Names used for qname and tname must match names used in the newick
      tree.'
    inputBinding:
      position: 5
  - id: drop_split
    type:
      - 'null'
      - boolean
    doc: If elements span multiple chains, report them as non-mapping. These 
      will then be reported as gains or losses, according to the 
      maximum-parsimony predictions. This is the default mapping behavior for 
      bnMapper. By default, mapGL.pys will follow the mapping convention used by
      liftOver, whereas the longest mapped alignment is reported for split 
      elements.
    inputBinding:
      position: 106
      prefix: --drop_split
  - id: full_labels
    type:
      - 'null'
      - boolean
    doc: Attempt to predict gain/loss events on all branches of the tree, not 
      just query/target branches. Output will include a comma-delimited list of 
      gain/loss events from any/all affected branches.
    inputBinding:
      position: 106
      prefix: --full_labels
  - id: gap
    type:
      - 'null'
      - int
    doc: Ignore elements with an insertion/deletion of this or bigger size. 
      Using the default value (-1) will allow gaps of any size.
    inputBinding:
      position: 106
      prefix: --gap
  - id: in_format
    type:
      - 'null'
      - string
    doc: Input file format.
    inputBinding:
      position: 106
      prefix: --in_format
  - id: no_prune
    type:
      - 'null'
      - boolean
    doc: Do not attempt to disambiguate the root state to resolve ambiguous 
      gain/loss predictions. Instead, label affected features as 'ambiguous'.
    inputBinding:
      position: 106
      prefix: --no_prune
  - id: priority
    type:
      - 'null'
      - string
    doc: When resolving ambiguous trees, prioritize sequence gain or sequence 
      loss. This can be thought of as assigning a lower cost to sequence 
      insertions relative to deletions, or vice-versa. When priority='gain', 
      ambiguity is resolved by assigning 0 state to the root node, such that 
      sequence presence on a descendant branch will be interpreted as a gain. 
      When priority='loss', ambiguity is resolved by asssigning state 1 to the 
      root node, such that sequence absence in a descendant node is interpreted 
      as a sequence loss. Default=gain
    inputBinding:
      position: 106
      prefix: --priority
  - id: threshold
    type:
      - 'null'
      - float
    doc: Mapping threshold i.e., |elem| * threshold <= |mapped_elem|. Default = 
      0.0 -- equivalent to accepting a single-base overlap. On the other end of 
      the spectrum, setting this value to 1 is equivalent to only accepting 
      full-length overlaps.
    inputBinding:
      position: 106
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - string
    doc: Verbosity level
    inputBinding:
      position: 106
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file. Default stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapgl:1.3.1--pyh5ca1d4c_0
