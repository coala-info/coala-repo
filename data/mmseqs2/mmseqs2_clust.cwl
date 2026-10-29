cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - clust
label: mmseqs2_clust
doc: 'Cluster a result database (prefilter or alignment) with Set-Cover, Connected-Component
  or Greedy-Incremental clustering.


  By Martin Steinegger <martin.steinegger@snu.ac.kr> & Lars von den Driesch & Maria Hauser


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: sequence_db
    type: Directory
    doc: Sequence database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.sequence_db_name)
  - id: sequence_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: result_db
    type: Directory
    doc: Result database to cluster
    inputBinding:
      position: 2
      valueFrom: $(self.path)/$(inputs.result_db_name)
  - id: result_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index, db.dbtype,
      db_h
  - id: output_cluster_db_name
    type: string
    doc: Name (prefix) of the output cluster database, written inside the output directory
    inputBinding:
      position: 3
      valueFrom: out_db/$(self)
  - id: cluster_mode
    type:
      - 'null'
      - int
    doc: '0: Set-Cover (greedy) 1: Connected component (BLASTclust) 2,3: Greedy clustering
      by sequence length (CDHIT)'
    inputBinding:
      position: 104
      prefix: --cluster-mode
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum depth of breadth first search in connected component clustering
    inputBinding:
      position: 104
      prefix: --max-iterations
  - id: similarity_type
    type:
      - 'null'
      - int
    doc: 'Type of score used for clustering. 1: alignment score 2: sequence identity'
    inputBinding:
      position: 104
      prefix: --similarity-type
  - id: weights
    type:
      - 'null'
      - File
    doc: Weights used for cluster priorization
    inputBinding:
      position: 104
      prefix: --weights
  - id: cluster_weight_threshold
    type:
      - 'null'
      - float
    doc: Weight threshold used for cluster priorization
    inputBinding:
      position: 104
      prefix: --cluster-weight-threshold
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the new database files
    outputBinding:
      glob: out_db
arguments:
  - position: 200
    shellQuote: false
    valueFrom: '&& for f in out_db/*; do if [ -L "$f" ]; then t=`readlink -f "$f"`; rm "$f";
      cp "$t" "$f"; fi; done'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
  - class: ShellCommandRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
