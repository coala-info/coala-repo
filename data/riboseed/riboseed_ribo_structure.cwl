cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribo
  - structure
label: riboseed_ribo_structure
doc: "View the rRNA operon structure across several genomes.\n\nTool homepage: https://github.com/nickp60/riboSeed"
inputs:
  - id: dir
    type: Directory
    doc: "directory with the genomes (fasta or genbank files)"
    inputBinding:
      position: 1
  - id: gffdir
    type:
      - 'null'
      - Directory
    doc: "directory with gff annotation files"
    inputBinding:
      position: 101
      prefix: '-g'
  - id: kingdom
    type:
      - 'null'
      - string
    doc: "kingdom for barrnap (bac, euk, arc or mito)"
    inputBinding:
      position: 101
      prefix: '-k'
  - id: id_thresh
    type:
      - 'null'
      - float
    doc: "partial rRNA hits below this threshold will be ignored"
    inputBinding:
      position: 101
      prefix: '-t'
  - id: barrnap_exe
    type:
      - 'null'
      - string
    doc: "path to barrnap executable"
    inputBinding:
      position: 101
      prefix: '-b'
  - id: cores
    type:
      - 'null'
      - int
    doc: "number of cores (1, 2, 4, 8 or 16)"
    inputBinding:
      position: 101
      prefix: '-c'
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Logger writes debug to file in output dir; this sets verbosity level sent to stderr. 1 = debug(), 2 = info(), 3 = warning(), 4 = error() and 5 = critical(); default: 2"
    inputBinding:
      position: 101
      prefix: '-v'
  - id: output
    type: string
    doc: "output directory"
    inputBinding:
      position: 102
      prefix: '--output'
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
stdout: riboseed_ribo_structure.out
