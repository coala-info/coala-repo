cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - cluster
label: pangwas_cluster
doc: "Cluster nucleotide sequences with mmseqs.\n\nTakes as input a FASTA file of
  sequences for clustering. Calls MMSeqs2 \nto cluster sequences and identify a representative
  sequence. Outputs a\nTSV table of sequence clusters and a FASTA of representative
  sequences.\n\nAny additional arguments will be passed to `mmseqs cluster`. If no
  additional\narguments are used, the following default args will apply:\n  -k 13
  --min-seq-id 0.90 -c 0.90 --cluster-mode 2 --max-seqs 300\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: fasta
    type: File
    doc: FASTA file of input sequences to cluster.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: memory
    type:
      - 'null'
      - string
    doc: Memory limit for mmseqs split.
    inputBinding:
      position: 101
      prefix: --memory
  - id: no_clean
    type:
      - 'null'
      - boolean
    doc: Don't clean up intermediate files.
    inputBinding:
      position: 101
      prefix: --no-clean
  - id: outdir
    type:
      - 'null'
      - string
    doc: Output directory.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: CPU threads for mmseqs.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp
    type:
      - 'null'
      - string
    doc: Tmp directory
    inputBinding:
      position: 101
      prefix: --tmp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in prefix
    outputBinding:
      glob: $(inputs.prefix)*
  - id: outdir_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
stdout: pangwas_cluster.out
