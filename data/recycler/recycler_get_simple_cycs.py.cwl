cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_simple_cycs.py
label: recycler_get_simple_cycs.py
doc: "Gets simple (single contig) cycles from plasmid metagenomes, leaves rest of
  the graph as is; outputs these to two separate files (<name>.simple.cycs.fasta
  and <name>.simple.cycs_filtered.fastg).\n\nTool homepage: https://github.com/Shamir-Lab/Recycler"
inputs:
  - id: input
    type: File
    doc: Input (SPAdes 3.50+) FASTG to process
    inputBinding:
      position: 101
      prefix: --input
      valueFrom: $(self.basename)
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum cycle length to keep (shorter cycles put in new graph file; 
      default = 1000)
    inputBinding:
      position: 102
      prefix: --min_length
outputs:
  - id: simple_cycles_fasta
    type:
      - 'null'
      - File
    doc: FASTA file of simple (single contig) cycles
    outputBinding:
      glob: '*.simple.cycs.fasta'
  - id: filtered_graph
    type:
      - 'null'
      - File
    doc: FASTG file with the simple cycles removed from the graph
    outputBinding:
      glob: '*.simple.cycs_filtered.fastg'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
