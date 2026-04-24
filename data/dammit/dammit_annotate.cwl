cwlVersion: v1.2
class: CommandLineTool
baseCommand: dammit annotate
label: dammit_annotate
doc: "The main annotation pipeline. Calculates assembly stats; runs BUSCO; runs LAST
  against OrthoDB (and optionally uniref90), HMMER against Pfam, Inferal against Rfam,
  and Conditional Reciprocal Best-hit Blast against user databases; and aggregates
  all results in a properly formatted GFF3 file.\n\nTool homepage: http://dib-lab.github.io/dammit/"
inputs:
  - id: transcriptome
    type: File
    doc: FASTA file with the transcripts to be annotated.
    inputBinding:
      position: 1
  - id: busco_config_file
    type:
      - 'null'
      - File
    doc: Path to an alternative BUSCO config file; otherwise, BUSCO will attempt
      to use its default installation which will likely only work on bioconda. 
      Advanced use only!
    inputBinding:
      position: 102
      prefix: --busco-config-file
  - id: busco_group
    type:
      - 'null'
      - string
    doc: Which BUSCO group to use. Should be chosen based on the organism being 
      annotated. Full list of options is below.
    inputBinding:
      position: 102
      prefix: --busco-group
  - id: config_file
    type:
      - 'null'
      - File
    doc: A JSON file providing values to override built-in config. Advanced use 
      only!
    inputBinding:
      position: 102
      prefix: --config-file
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Directory to store databases. Existing databases will not be 
      overwritten. By default, the database directory is 
      $HOME/.dammit/databases.
    inputBinding:
      position: 102
      prefix: --database-dir
  - id: evalue
    type:
      - 'null'
      - float
    doc: e-value cutoff for similarity searches.
    inputBinding:
      position: 102
      prefix: --evalue
  - id: force
    type:
      - 'null'
      - boolean
    doc: Ignore missing database tasks.
    inputBinding:
      position: 102
      prefix: --force
  - id: full
    type:
      - 'null'
      - boolean
    doc: Run a "complete" annotation; includes uniref90, which is left out of 
      the default pipeline because it is huge and homology searches take a long 
      time.
    inputBinding:
      position: 102
      prefix: --full
  - id: n_threads
    type:
      - 'null'
      - int
    doc: For annotate, number of threads to pass to programs supporting 
      multithreading. For databases, number of simultaneous tasks to execute.
    inputBinding:
      position: 102
      prefix: --n_threads
  - id: name
    type:
      - 'null'
      - string
    doc: Base name to use for renaming the input transcripts. The new names will
      be of the form <name>_<X>. It should not have spaces, pipes, ampersands, 
      or other characters with special meaning to BASH.
    inputBinding:
      position: 102
      prefix: --name
  - id: no_rename
    type:
      - 'null'
      - boolean
    doc: 'Keep original transcript names. Note: make sure your transcript names do
      not contain unusual characters.'
    inputBinding:
      position: 102
      prefix: --no-rename
  - id: nr
    type:
      - 'null'
      - boolean
    doc: Also include annotation to NR database, which is left out of the 
      default and "full" pipelines because it is huge and homology searches take
      a long time.
    inputBinding:
      position: 102
      prefix: --nr
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory. By default this will be the name of the transcriptome
      file with `.dammit` appended
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Profile task execution.
    inputBinding:
      position: 102
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
      position: 102
      prefix: --quick
  - id: sshloginfile
    type:
      - 'null'
      - File
    doc: Distribute execution across the specified nodes.
    inputBinding:
      position: 102
      prefix: --sshloginfile
  - id: user_databases
    type:
      - 'null'
      - type: array
        items: File
    doc: Optional additional protein databases. These will be searched with 
      CRB-blast.
    inputBinding:
      position: 102
      prefix: --user-databases
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity level for doit tasks.
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dammit:1.2--pyh5ca1d4c_0
stdout: dammit_annotate.out
