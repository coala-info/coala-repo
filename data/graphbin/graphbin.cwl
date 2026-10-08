cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphbin
label: graphbin
doc: "Refined Binning of Metagenomic Contigs using Assembly Graphs\n\nTool homepage:
  https://github.com/Vini2/GraphBin"
inputs:
  - id: assembler
    type: string
    doc: name of the assembler used (SPAdes, SGA or MEGAHIT). GraphBin supports 
      Flye, Canu and Miniasm long-read assemblies as well.
    inputBinding:
      position: 101
      prefix: --assembler
  - id: binned
    type: File
    doc: path to the .csv file with the initial binning output from an existing 
      tool
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
    doc: delimiter for input/output results. Supports a comma (,), a semicolon 
      (;), a tab ($'\t'), a space (" ") and a pipe (|)
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: diff_threshold
    type:
      - 'null'
      - float
    doc: difference threshold for label propagation algorithm
    inputBinding:
      position: 101
      prefix: --diff_threshold
  - id: graph
    type: File
    doc: path to the assembly graph file
    inputBinding:
      position: 101
      prefix: --graph
  - id: max_iteration
    type:
      - 'null'
      - int
    doc: maximum number of iterations for label propagation algorithm
    inputBinding:
      position: 101
      prefix: --max_iteration
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
  - id: output_path
    type: string
    default: graphbin_out
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
    dockerPull: quay.io/biocontainers/graphbin:1.7.4--pyhdfd78af_0
stdout: graphbin.out
