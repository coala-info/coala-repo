cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - foldmason
  - msa2lddt
label: foldmason_msa2lddt
doc: 'Calculate the LDDT score of a multiple sequence alignment (printed to standard
  output).


  By Cameron Gilchrist <gamcil@snu.ac.kr> & Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/steineggerlab/foldmason'
inputs:
  - id: query_db
    type: Directory
    doc: Input structure database
    inputBinding:
      position: 1
      valueFrom: $(self.path)/$(inputs.query_db_name)
  - id: query_db_name
    type: string
    doc: Name (prefix) of the database inside the directory, e.g. db for db, db.index,
      db.dbtype, db_h, db_ss, db_ca
  - id: msa_file
    type: File
    doc: Input multiple sequence alignment (amino acid FASTA, for example PREFIX_aa.fa
      from structuremsa)
    inputBinding:
      position: 2
  - id: guide_tree
    type:
      - 'null'
      - string
    doc: Guide tree in Newick format
    inputBinding:
      position: 104
      prefix: --guide-tree
  - id: only_scoring_cols
    type:
      - 'null'
      - boolean
    doc: Normalise LDDT by no. scoring columns
    inputBinding:
      position: 104
      prefix: --only-scoring-cols
  - id: pair_threshold
    type:
      - 'null'
      - float
    doc: '% of pair subalignments with LDDT information [0.0,1.0]'
    inputBinding:
      position: 104
      prefix: --pair-threshold
  - id: report_command
    type:
      - 'null'
      - string
    doc: Report command
    inputBinding:
      position: 104
      prefix: --report-command
  - id: report_paths
    type:
      - 'null'
      - int
    doc: Report paths (0 or 1)
    inputBinding:
      position: 104
      prefix: --report-paths
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
outputs:
  - id: lddt_log
    type: stdout
    doc: Standard output with the average MSA LDDT score
stdout: $(inputs.msa_file.nameroot).lddt.txt
requirements: []
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/foldmason:4.dd3c235--h5021889_0
