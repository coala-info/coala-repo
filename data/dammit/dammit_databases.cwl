cwlVersion: v1.2
class: CommandLineTool
baseCommand: dammit databases
label: dammit_databases
doc: "Check for databases and optionally download and prepare them for use. By default,
  only check their status.\n\nTool homepage: http://dib-lab.github.io/dammit/"
inputs:
  - id: busco_config_file
    type:
      - 'null'
      - File
    doc: Path to an alternative BUSCO config file; otherwise, BUSCO will attempt
      to use its default installation which will likely only work on bioconda. 
      Advanced use only!
    inputBinding:
      position: 101
      prefix: --busco-config-file
  - id: busco_group
    type:
      - 'null'
      - type: array
        items: string
    doc: Which BUSCO group to use. Should be chosen based on the organism being 
      annotated. Full list of options is below.
    inputBinding:
      position: 101
      prefix: --busco-group
  - id: config_file
    type:
      - 'null'
      - File
    doc: A JSON file providing values to override built-in config. Advanced use 
      only!
    inputBinding:
      position: 101
      prefix: --config-file
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Directory to store databases. Existing databases will not be 
      overwritten. By default, the database directory is 
      $HOME/.dammit/databases.
    inputBinding:
      position: 101
      prefix: --database-dir
  - id: force
    type:
      - 'null'
      - boolean
    doc: Ignore missing database tasks.
    inputBinding:
      position: 101
      prefix: --force
  - id: full
    type:
      - 'null'
      - boolean
    doc: Run a "complete" annotation; includes uniref90, which is left out of 
      the default pipeline because it is huge and homology searches take a long 
      time.
    inputBinding:
      position: 101
      prefix: --full
  - id: install
    type:
      - 'null'
      - boolean
    doc: Install missing databases. Downloads and preps where necessary
    inputBinding:
      position: 101
      prefix: --install
  - id: n_threads
    type:
      - 'null'
      - int
    doc: For annotate, number of threads to pass to programs supporting 
      multithreading. For databases, number of simultaneous tasks to execute.
    inputBinding:
      position: 101
      prefix: --n_threads
  - id: no_rename
    type:
      - 'null'
      - boolean
    doc: 'Keep original transcript names. Note: make sure your transcript names do
      not contain unusual characters.'
    inputBinding:
      position: 101
      prefix: --no-rename
  - id: nr
    type:
      - 'null'
      - boolean
    doc: Also include annotation to NR database, which is left out of the 
      default and "full" pipelines because it is huge and homology searches take
      a long time.
    inputBinding:
      position: 101
      prefix: --nr
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Profile task execution.
    inputBinding:
      position: 101
      prefix: --profile
  - id: quick
    type:
      - 'null'
      - boolean
    doc: Run a "quick" annotation; excludes the Infernal Rfam tasks, the HMMER 
      Pfam tasks, and the LAST OrthoDB and uniref90 tasks. Best for users just 
      looking to get basic stats and conditional reciprocal best LAST from a 
      protein database.
    inputBinding:
      position: 101
      prefix: --quick
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level for doit tasks.
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dammit:1.2--pyh5ca1d4c_0
stdout: dammit_databases.out
