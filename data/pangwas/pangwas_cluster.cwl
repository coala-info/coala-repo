cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - cluster
label: pangwas_cluster
doc: "Cluster nucleotide sequences with mmseqs.\n\nTakes as input a FASTA file of sequences for clustering. Calls MMSeqs2 \nto cluster sequences and identify a representative sequence. Outputs a\nTSV table of sequence clusters and a FASTA of representative sequences.\n\nAny additional arguments will be passed to `mmseqs cluster`. If no additional\narguments are used, the following default args will apply:\n  -k 13 --min-seq-id 0.90 -c 0.90 --cluster-mode 2 --max-seqs 300\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: fasta
    type: File
    doc: "FASTA file of input sequences to cluster."
    inputBinding:
      position: 101
      prefix: --fasta
  - id: outdir
    type:
      - 'null'
      - string
    doc: "Output directory. (default: .)"
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for output files."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: tmp
    type:
      - 'null'
      - string
    doc: "Tmp directory (default: tmp)."
    inputBinding:
      position: 101
      prefix: --tmp
  - id: memory
    type:
      - 'null'
      - string
    doc: "Memory limit for mmseqs split. (default: 1G)"
    inputBinding:
      position: 101
      prefix: --memory
  - id: no_clean
    type:
      - 'null'
      - boolean
    doc: "Don't clean up intermediate files."
    inputBinding:
      position: 101
      prefix: --no-clean
  - id: threads
    type:
      - 'null'
      - int
    doc: "CPU threads for mmseqs. (default: 1)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: extra_args
    type:
      - 'null'
      - type: array
        items: string
    doc: "Additional arguments passed on to `mmseqs cluster`."
    inputBinding:
      position: 200
outputs:
  - id: clusters
    type: File
    doc: "TSV table of sequence clusters"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'clusters.tsv')"
  - id: representative
    type: File
    doc: "FASTA of cluster representative sequences"
    outputBinding:
      glob: "$((inputs.outdir ? inputs.outdir + '/' : '') + (inputs.prefix ? inputs.prefix + '.' : '') + 'representative.fasta')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
