cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pangwas
  - defrag
label: pangwas_defrag
doc: "Defrag clusters by associating fragments with their parent cluster.\n\nTakes
  as input the TSV clusters and FASTA representatives from cluster.\nOutputs a new
  cluster table and representative sequences fasta.\n\nThe defrag algorithm is adapted
  from PPanGGOLiN (v2.2.0) which is  \ndistributed under the CeCILL FREE SOFTWARE
  LICENSE AGREEMENT LABGeM.\n- Please cite: Gautreau G et al. (2020) PPanGGOLiN: Depicting
  microbial diversity via a partitioned pangenome graph.\n                PLOS Computational
  Biology 16(3): e1007732. https://doi.org/10.1371/journal.pcbi.1007732\n- PPanGGOLiN
  license: https://github.com/labgem/PPanGGOLiN/blob/2.2.0/LICENSE.txt\n- Defrag algorithm
  source: https://github.com/labgem/PPanGGOLiN/blob/2.2.0/ppanggolin/cluster/cluster.py#L317\n\
  \nAny additional arguments will be passed to `mmseqs search`. If no additional\n\
  arguments are used, the following default args will apply:\n  -k 13 --min-seq-id
  0.90 -c 0.90 --cov-mode 1\n\nTool homepage: https://github.com/phac-nml/pangwas"
inputs:
  - id: clusters
    type: File
    doc: TSV file of clusters from mmseqs.
    inputBinding:
      position: 101
      prefix: --clusters
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
      - Directory
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
  - id: representative
    type: File
    doc: FASTA file of cluster representative sequences.
    inputBinding:
      position: 101
      prefix: --representative
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
      - Directory
    doc: Tmp directory
    inputBinding:
      position: 101
      prefix: --tmp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwas:0.1.0--pyh7e72e81_0
stdout: pangwas_defrag.out
