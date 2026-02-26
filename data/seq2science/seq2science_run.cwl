cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seq2science
  - run
label: seq2science_run
doc: "Run a complete workflow. This requires that a config and samples file are either
  present in the current directory, or passed as an argument. Supported workflows:
  scrna-seq, download-fastq, rna-seq, alignment, atac-seq, scatac-seq, chip-seq\n\n\
  Tool homepage: https://vanheeringen-lab.github.io/seq2science"
inputs:
  - id: workflow
    type: string
    doc: The workflow to run (e.g., scrna-seq, download-fastq, rna-seq, 
      alignment, atac-seq, scatac-seq, chip-seq)
    inputBinding:
      position: 1
  - id: cleanup_metadata
    type:
      - 'null'
      - type: array
        items: File
    doc: Just cleanup metadata of given list of output files (default None).
    inputBinding:
      position: 102
      prefix: --cleanup-metadata
  - id: configfile
    type:
      - 'null'
      - File
    doc: The path to the config file.
    inputBinding:
      position: 102
      prefix: --configfile
  - id: cores
    type:
      - 'null'
      - int
    doc: Use at most N cores in parallel. Must be at least 2. When executing on 
      a cluster, this number controls the maximum number of parallel jobs.
    inputBinding:
      position: 102
      prefix: --cores
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'For developers "only": prints helpful error messages to debug issues.'
    inputBinding:
      position: 102
      prefix: --debug
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Do not execute anything, and display what would be done.
    inputBinding:
      position: 102
      prefix: --dryrun
  - id: keep_going
    type:
      - 'null'
      - boolean
    doc: Go on with independent jobs if a job fails.
    inputBinding:
      position: 102
      prefix: --keep-going
  - id: profile
    type:
      - 'null'
      - string
    doc: Use a seq2science profile.
    inputBinding:
      position: 102
      prefix: --profile
  - id: reason
    type:
      - 'null'
      - boolean
    doc: Print the reason for each executed rule.
    inputBinding:
      position: 102
      prefix: --reason
  - id: rerun_incomplete
    type:
      - 'null'
      - boolean
    doc: Re-run all jobs the output of which is recognized as incomplete.
    inputBinding:
      position: 102
      prefix: --rerun-incomplete
  - id: skip_rerun
    type:
      - 'null'
      - boolean
    doc: Skip the check if samples or configuration has been changed.
    inputBinding:
      position: 102
      prefix: --skip-rerun
  - id: snakemake_options
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra arguments to pass along to snakemake (KEY=VAL).
    inputBinding:
      position: 102
      prefix: --snakemakeOptions
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: Remove a lock on the working directory.
    inputBinding:
      position: 102
      prefix: --unlock
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2science:1.2.4--pyhdfd78af_0
stdout: seq2science_run.out
