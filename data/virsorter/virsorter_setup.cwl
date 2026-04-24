cwlVersion: v1.2
class: CommandLineTool
baseCommand: virsorter setup
label: virsorter_setup
doc: "Setup databases and install dependencies.\n\nExecutes a snakemake workflow to
  download reference database files and\nvalidate based on their MD5 checksum, and
  install dependencies\n\nTool homepage: https://github.com/simroux/VirSorter"
inputs:
  - id: snakemake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: SNAKEMAKE_ARGS
    inputBinding:
      position: 1
  - id: db_dir
    type: Directory
    doc: diretory path for databases
    inputBinding:
      position: 102
      prefix: --db-dir
  - id: jobs
    type:
      - 'null'
      - int
    doc: number of simultaneous downloads
    inputBinding:
      position: 102
      prefix: --jobs
  - id: skip_deps_install
    type:
      - 'null'
      - boolean
    doc: "skip dependency installation (if you want to\n                         \
      \  install on your own as in development version)"
    inputBinding:
      position: 102
      prefix: --skip-deps-install
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virsorter:2.2.4--pyhdfd78af_2
stdout: virsorter_setup.out
