cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin cluster
label: ppanggolin_cluster
doc: "PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM
  team, and distributed under the CeCILL Free Software License Agreement.\n\nTool
  homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: clusters
    type:
      - 'null'
      - File
    doc: A tab-separated list containing the result of a clustering. One line 
      per gene. First column is cluster ID, and second is gene ID
    inputBinding:
      position: 101
      prefix: --clusters
  - id: config
    type:
      - 'null'
      - File
    doc: Specify command arguments through a YAML configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: coverage
    type:
      - 'null'
      - float
    doc: Minimal coverage of the alignment for two proteins to be in the same 
      cluster
    inputBinding:
      position: 101
      prefix: --coverage
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of available cpus
    inputBinding:
      position: 101
      prefix: --cpu
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: identity
    type:
      - 'null'
      - float
    doc: Minimal identity percent for two proteins to be in the same cluster
    inputBinding:
      position: 101
      prefix: --identity
  - id: infer_singletons
    type:
      - 'null'
      - boolean
    doc: When reading a clustering result with --clusters, if a gene is not in 
      the provided file it will be placed in a cluster where the gene is the 
      only member.
    inputBinding:
      position: 101
      prefix: --infer_singletons
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keeping temporary files (useful for debugging).
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: mode
    type:
      - 'null'
      - int
    doc: 'the cluster mode of MMseqs2. 0: Setcover, 1: single linkage (or connected
      component), 2: CD-HIT-like, 3: CD-HIT-like (lowmem)'
    inputBinding:
      position: 101
      prefix: --mode
  - id: no_defrag
    type:
      - 'null'
      - boolean
    doc: DO NOT Use the defragmentation strategy to link potential fragments 
      with their original gene family.
    inputBinding:
      position: 101
      prefix: --no_defrag
  - id: pangenome
    type: File
    doc: The pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for storing temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Translation table (genetic code) to use.
    inputBinding:
      position: 101
      prefix: --translation_table
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
stdout: ppanggolin_cluster.out
