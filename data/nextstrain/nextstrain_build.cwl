cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextstrain build
label: nextstrain_build
doc: "Runs a pathogen build in the Nextstrain build environment.\n\nTool homepage:
  https://nextstrain.org"
inputs:
  - id: directory
    type: Directory
    doc: Path to pathogen build directory
    inputBinding:
      position: 1
  - id: additional_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments to pass to the executed program
    inputBinding:
      position: 2
  - id: attach
    type:
      - 'null'
      - string
    doc: "Re-attach to a --detach'ed build to view output and\n                  \
      \      download results. Currently only supported when also using\n        \
      \                --aws-batch."
    default: None
    inputBinding:
      position: 103
      prefix: --attach
  - id: aws_batch
    type:
      - 'null'
      - boolean
    doc: Launch jobs on AWS Batch instead of running locally
    inputBinding:
      position: 103
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Number of CPUs/cores/threads/jobs to utilize at once.\n                \
      \        Limits containerized (Docker, AWS Batch) builds to\n              \
      \          this amount. Informs Snakemake's resource scheduler\n           \
      \             when applicable. Informs the AWS Batch instance size\n       \
      \                 selection."
    default: None
    inputBinding:
      position: 103
      prefix: --cpus
  - id: detach
    type:
      - 'null'
      - boolean
    doc: "Run the build in the background, detached from your\n                  \
      \      terminal. Re-attach later using --attach. Currently\n               \
      \         only supported when also using --aws-batch."
    default: false
    inputBinding:
      position: 103
      prefix: --detach
  - id: download
    type:
      - 'null'
      - type: array
        items: string
    doc: "Only download new or modified files matching <pattern>\n               \
      \         from the remote build. Basic shell-style globbing is\n           \
      \             supported, but be sure to escape wildcards or quote\n        \
      \                the whole pattern so your shell doesn't expand them.\n    \
      \                    May be passed more than once. Currently only supported\n\
      \                        when also using --aws-batch. Default is to download\n\
      \                        every new or modified file."
    inputBinding:
      position: 103
      prefix: --download
  - id: memory
    type:
      - 'null'
      - string
    doc: "Amount of memory to make available to the build. Units\n               \
      \         of b, kb, mb, gb, kib, mib, gib are supported. Limits\n          \
      \              containerized (Docker, AWS Batch) builds to this\n          \
      \              amount. Informs Snakemake's resource scheduler when\n       \
      \                 applicable. Informs the AWS Batch instance size\n        \
      \                selection."
    default: None
    inputBinding:
      position: 103
      prefix: --memory
  - id: native
    type:
      - 'null'
      - boolean
    doc: Run the build in the native ambient environment
    inputBinding:
      position: 103
  - id: no_download
    type:
      - 'null'
      - boolean
    doc: "Do not download any files from the remote build when\n                 \
      \       it completes. Currently only supported when also using\n           \
      \             --aws-batch."
    inputBinding:
      position: 103
      prefix: --no-download
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextstrain:20200304--hdfd78af_1
stdout: nextstrain_build.out
