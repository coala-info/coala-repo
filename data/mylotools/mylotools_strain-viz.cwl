cwlVersion: v1.2
class: CommandLineTool
baseCommand: mylotools_strain-viz
label: mylotools_strain-viz
doc: "Generate a visualization of contig relationships based on read overlaps.\n\n\
  Tool homepage: https://github.com/bluenote-1577/mylotools"
inputs:
  - id: contigs
    type:
      type: array
      items: string
    doc: List of contig IDs to include
    inputBinding:
      position: 1
  - id: gfa
    type:
      - 'null'
      - File
    doc: Path to the GFA file containing contig information
    default: final_contig_graph.gfa
    inputBinding:
      position: 102
      prefix: --gfa
  - id: max_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads to display per contig
    default: 20
    inputBinding:
      position: 102
      prefix: --max-reads
  - id: overlaps
    type:
      - 'null'
      - File
    doc: Path to the overlaps file
    default: 0-cleaning_and_unitigs/overlaps.txt.gz
    inputBinding:
      position: 102
      prefix: --overlaps
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file for the visualization PNG, PDF, SVG, etc.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mylotools:2.0.0--pyh7e72e81_0
