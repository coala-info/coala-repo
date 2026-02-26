cwlVersion: v1.2
class: CommandLineTool
baseCommand: isescan
label: isescan_isescan.py
doc: "ISEScan is a python pipeline to identify Insertion Sequence elements (both complete
  and incomplete IS elements) in genom. A typical invocation would be:\npython3 isescan.py
  seqfile proteome hmm\n\n- If you want isescan to report only complete IS elements,
  you need to set command line option --removeShortIS.\n\nTool homepage: https://github.com/xiezhq/ISEScan"
inputs:
  - id: no_frag_gene_scan
    type:
      - 'null'
      - boolean
    doc: "Use the annotated protein sequences in NCBI GenBank file\n             \
      \        (.gbk which must be in the same folder with genome\n              \
      \       sequence file), instead of the protein sequences\n                 \
      \    predicted/translated by FragGeneScan. (Experimental\n                 \
      \    feature!)"
    inputBinding:
      position: 101
      prefix: --no-FragGeneScan
  - id: nthread
    type:
      - 'null'
      - int
    doc: "Number of CPU cores used for FragGeneScan and hmmer, 1 by\n            \
      \         default."
    default: 1
    inputBinding:
      position: 101
      prefix: --nthread
  - id: output
    type: Directory
    doc: Output directory, 'results' by default
    default: results
    inputBinding:
      position: 101
      prefix: --output
  - id: remove_short_is
    type:
      - 'null'
      - boolean
    doc: "Remove incomplete (partial) IS elements which include IS\n             \
      \        element with length < 400 or single copy IS element\n             \
      \        without perfect TIR."
    inputBinding:
      position: 101
      prefix: --removeShortIS
  - id: seqfile
    type: File
    doc: Sequence file in fasta format, '' by default
    inputBinding:
      position: 101
      prefix: --seqfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isescan:1.7.3--h7b50bb2_0
stdout: isescan_isescan.py.out
