cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribo
  - scan
label: riboseed_ribo_scan
doc: "Given a directory of one or more chromosomes as fasta files, reannotate rDNA regions with Barrnap and output all sequences as a single, annotated genbank file.\n\nTool homepage: https://github.com/nickp60/riboSeed"
inputs:
  - id: contigs
    type: File
    doc: "either a (multi)fasta or a directory containing one or more chromosomal sequences in fasta format"
    inputBinding:
      position: 1
  - id: kingdom
    type:
      - 'null'
      - string
    doc: "whether to look for eukaryotic, archaeal, or bacterial rDNA (bac, euk, arc or mito); default: bac"
    inputBinding:
      position: 101
      prefix: '--kingdom'
  - id: id_thresh
    type:
      - 'null'
      - float
    doc: "partial rRNA hits below this threshold will be ignored. default: 0.5"
    inputBinding:
      position: 101
      prefix: '--id_thresh'
  - id: barrnap_exe
    type:
      - 'null'
      - string
    doc: "path to barrnap executable; default: barrnap"
    inputBinding:
      position: 101
      prefix: '--barrnap_exe'
  - id: name
    type:
      - 'null'
      - string
    doc: "name to give the contig files; default: infered from file"
    inputBinding:
      position: 101
      prefix: '--name'
  - id: cores
    type:
      - 'null'
      - int
    doc: "number of threads/cores to use; default: 2"
    inputBinding:
      position: 101
      prefix: '--cores'
  - id: min_length
    type:
      - 'null'
      - int
    doc: "skip the scaffold if its shorter than this default: 0"
    inputBinding:
      position: 101
      prefix: '--min_length'
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Logger writes debug to file in output dir; this sets verbosity level sent to stderr. 1 = debug(), 2 = info(), 3 = warning(), 4 = error() and 5 = critical(); default: 2"
    inputBinding:
      position: 101
      prefix: '--verbosity'
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
stdout: riboseed_ribo_scan.out
