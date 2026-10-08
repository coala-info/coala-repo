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
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: depth
    type:
      - 'null'
      - int
    doc: maximum depth for the breadth-first-search.
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
    inputBinding:
      position: 101
      prefix: --threshold
  - id: output_path
    type: string
    default: graphbin2_out
    doc: path to the output folder (created before the run; the tool appends file
      names to this path, so the wrapper adds a trailing slash)
    inputBinding:
      position: 102
      prefix: --output
      valueFrom: $(self)/
outputs:
  - id: output
    type: Directory
    doc: Output folder with the refined bins and the unbinned contigs file
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_path)
        entry: '$({"class": "Directory", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphbin2:1.3.3--pyh7e72e81_0
stdout: graphbin2.out
