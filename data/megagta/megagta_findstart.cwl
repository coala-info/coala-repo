cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - megagta
  - findstart
label: megagta_findstart
doc: "Find the starting k-mers of a gene: matches the k-mers of the aligned
  reference protein sequences of the gene against the reads of the library. The
  starting k-mers go to standard output.\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
inputs:
  - id: ref_seq
    type: File
    doc: Aligned reference protein sequences of the gene (ref_aligned.faa)
    inputBinding:
      position: 1
  - id: read_lib
    type: File
    doc: Read library file <prefix>.bin written by megagta buildlib
    inputBinding:
      position: 2
  - id: k_size
    type: int
    doc: k-mer size (the SdBG k plus one, as used by megagta.py)
    inputBinding:
      position: 3
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (default: 0, auto detect)'
    inputBinding:
      position: 4
  - id: prev_contigs
    type:
      - 'null'
      - File
    doc: Contigs of the previous k, used as extra seeds
    inputBinding:
      position: 5
outputs:
  - id: starting_kmers
    type: stdout
    doc: Starting k-mers (tab separated)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdout: megagta_findstart.txt
