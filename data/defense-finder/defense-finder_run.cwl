cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - defense-finder
  - run
label: defense-finder_run
doc: "Search for all known anti-phage defense systems in the target fasta file.\n\n\
  Tool homepage: https://github.com/mdmparis/defense-finder"
inputs:
  - id: file
    type: File
    doc: The target fasta file
    inputBinding:
      position: 1
  - id: antidefensefinder
    type:
      - 'null'
      - boolean
    doc: Also run AntiDefenseFinder models to find antidefense systems.
    inputBinding:
      position: 102
      prefix: --antidefensefinder
  - id: antidefensefinder_only
    type:
      - 'null'
      - boolean
    doc: Run only AntiDefenseFinder for antidefense system and not DefenseFinder
    inputBinding:
      position: 102
      prefix: --antidefensefinder-only
  - id: coverage
    type:
      - 'null'
      - float
    doc: Minimal percentage of coverage for each profiles.
    inputBinding:
      position: 102
      prefix: --coverage
  - id: db_type
    type:
      - 'null'
      - string
    doc: The macsyfinder --db-type option. Run macsyfinder --help for more 
      details. Possible values are ordered_replicon, gembase, unordered, 
      defaults to ordered_replicon.
    inputBinding:
      position: 102
      prefix: --db-type
  - id: index_dir
    type:
      - 'null'
      - Directory
    doc: Specify a directory to write the index files required by macsyfinder 
      when the input file is in a read-only folder
    inputBinding:
      position: 102
      prefix: --index-dir
  - id: log_level
    type:
      - 'null'
      - string
    doc: set the logging level among DEBUG, [INFO], WARNING, ERROR, CRITICAL
    inputBinding:
      position: 102
      prefix: --log-level
  - id: models_dir
    type:
      - 'null'
      - Directory
    doc: Specify a directory containing your models.
    inputBinding:
      position: 102
      prefix: --models-dir
  - id: no_cut_ga
    type:
      - 'null'
      - boolean
    doc: Advanced! Run macsyfinder in no-cut-ga mode. The validity of the genes 
      and systems found is not guaranteed!
    inputBinding:
      position: 102
      prefix: --no-cut-ga
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: The target directory where to store the results.
    inputBinding:
      position: 102
      prefix: --out-dir
  - id: preserve_raw
    type:
      - 'null'
      - boolean
    doc: Preserve raw MacsyFinder outputs alongside Defense Finder results 
      inside the output directory.
    inputBinding:
      position: 102
      prefix: --preserve-raw
  - id: skip_model_version_check
    type:
      - 'null'
      - boolean
    doc: Skip model version check
    inputBinding:
      position: 102
      prefix: --skip-model-version-check
  - id: workers
    type:
      - 'null'
      - int
    doc: The workers count.
    inputBinding:
      position: 102
      prefix: --workers
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/defense-finder:2.0.1--pyhdfd78af_0
stdout: defense-finder_run.out
