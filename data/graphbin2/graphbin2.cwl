cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphbin2
label: graphbin2
doc: "Refined and Overlapped Binning of Metagenomic Contigs Using Assembly Graphs
  GraphBin2 is a tool which refines the binning results obtained from existing tools
  and, is able to assign contigs to multiple bins. GraphBin2 uses the connectivity
  and coverage information from assembly graphs to adjust existing binning results
  on contigs and to infer contigs shared by multiple species.\n\nTool homepage: https://github.com/metagentools/GraphBin2"
inputs:
  - id: abundance
    type: File
    doc: path to the abundance file
    inputBinding:
      position: 101
      prefix: --abundance
  - id: assembler
    type: string
    doc: name of the assembler used. (Supports SPAdes, SGA, MEGAHIT and Flye)
    inputBinding:
      position: 101
      prefix: --assembler
  - id: binned
    type: File
    doc: path to the .csv file with the initial binning output from an existing 
      toole
    inputBinding:
      position: 101
      prefix: --binned
  - id: contigs
    type: File
    doc: path to the contigs file
    inputBinding:
      position: 101
      prefix: --contigs
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiter for output results. Supports a comma (,), a semicolon (;), a 
      tab ($'\t'), a space (" ") and a pipe (|) .
    default: ','
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: depth
    type:
      - 'null'
      - int
    doc: maximum depth for the breadth-first-search.
    default: 5
    inputBinding:
      position: 101
      prefix: --depth
  - id: graph
    type: File
    doc: path to the assembly graph file
    inputBinding:
      position: 101
      prefix: --graph
  - id: nthreads
    type:
      - 'null'
      - int
    doc: number of threads to use.
    default: 8
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: paths
    type:
      - 'null'
      - File
    doc: path to the contigs.paths (metaSPAdes) or assembly.info (metaFlye) file
    inputBinding:
      position: 101
      prefix: --paths
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for the output file
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threshold
    type:
      - 'null'
      - float
    doc: threshold for determining inconsistent vertices.
    default: 1.5
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output
    type: Directory
    doc: path to the output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphbin2:1.3.3--pyh7e72e81_0
