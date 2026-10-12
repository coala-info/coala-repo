cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gfa1_parser
label: pangwes_gfa1_parser
doc: "Parser for GFA1 files: converts a Cuttlefish GFA1 compacted de Bruijn graph
  into the unitig, edge, FASTA pseudo-alignment and path files used by unitig_distance
  and SpydrPick.\n\nTool homepage: https://github.com/jurikuronen/PANGWES"
inputs:
  - id: input_gfa1
    type: File
    doc: Input GFA1 file
    inputBinding:
      position: 1
  - id: output_stem
    type: string
    doc: Output stem; files are written as STEM.edges, STEM.unitigs, STEM.fasta, STEM.paths and STEM.counts, and the single genome graphs to STEM_paths/
    inputBinding:
      position: 2
outputs:
  - id: unitigs
    type: File
    doc: Unitigs file (STEM.unitigs)
    outputBinding:
      glob: $(inputs.output_stem).unitigs
  - id: edges
    type: File
    doc: Graph edges file (STEM.edges)
    outputBinding:
      glob: $(inputs.output_stem).edges
  - id: alignment
    type: File
    doc: FASTA pseudo-alignment of unitig occurrence patterns (STEM.fasta)
    outputBinding:
      glob: $(inputs.output_stem).fasta
  - id: paths
    type: File
    doc: List of single genome graph edge files (STEM.paths)
    outputBinding:
      glob: $(inputs.output_stem).paths
  - id: counts
    type:
      - 'null'
      - File
    doc: Counts file (STEM.counts)
    outputBinding:
      glob: $(inputs.output_stem).counts
  - id: paths_dir
    type: Directory
    doc: Directory of single genome graph edge files (STEM_paths)
    outputBinding:
      glob: $(inputs.output_stem)_paths
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1
