cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pandora
  - index
label: pandora_index
doc: "Index population reference graph (PRG) sequences.\n\nTool homepage: https://github.com/rmcolq/pandora"
inputs:
  - id: prg
    type: File
    doc: PRG to index (in fasta format)
    inputBinding:
      position: 1
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size for (w,k)-minimizers
    inputBinding:
      position: 102
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - boolean
    doc: Verbosity of logging
    inputBinding:
      position: 102
      prefix: -v
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size for (w,k)-minimizers (must be <=k)
    inputBinding:
      position: 102
      prefix: -w
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: 'Filename for the index [default: <PRG>.kXX.wXX.idx]'
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: outfile
    type: File
    doc: The PRG index (outfile_path if given, otherwise <PRG>.kXX.wXX.idx beside the PRG)
    outputBinding:
      glob: "$(inputs.outfile_path ? inputs.outfile_path : inputs.prg.basename + '.k' + (inputs.kmer_size ? inputs.kmer_size : 15) + '.w' + (inputs.window_size ? inputs.window_size : 14) + '.idx')"
  - id: kmer_prgs
    type:
      - 'null'
      - Directory
    doc: Directory with the kmer graph of each locus (kmer_prgs), written beside the PRG and used by pandora map, compare and discover
    outputBinding:
      glob: kmer_prgs
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.prg)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
