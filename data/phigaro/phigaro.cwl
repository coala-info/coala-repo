cwlVersion: v1.2
class: CommandLineTool
baseCommand: phigaro
label: phigaro
doc: "Phigaro is a scalable command-line tool for predictions phages and prophages\n\
  from nucleid acid sequences\n\nTool homepage: https://phigaro.readthedocs.io/"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: "Path to the config file, not required. The deafult is\n                \
      \        /root/.phigaro/config.yml"
    default: /root/.phigaro/config.yml
    inputBinding:
      position: 101
      prefix: --config
  - id: delete_shorts
    type:
      - 'null'
      - boolean
    doc: Exclude sequences with length < 20000 automatically.
    inputBinding:
      position: 101
      prefix: --delete-shorts
  - id: extension
    type:
      - 'null'
      - type: array
        items: string
    doc: "Type of the output: html, tsv, gff, bed or stdout.\n                   \
      \     Default is html. You can specify several file formats\n              \
      \          with a space as a separator. Example: -e tsv html\n             \
      \           stdout."
    default: html
    inputBinding:
      position: 101
      prefix: --extension
  - id: fasta_file
    type: File
    doc: Assembly scaffolds/contigs or full genomes, required
    inputBinding:
      position: 101
      prefix: --fasta-file
  - id: mode
    type:
      - 'null'
      - string
    doc: "You can launch Phigaro at one of 3 modes: basic, abs,\n                \
      \        without_gc. Default is basic. Read more about modes at\n          \
      \              https://github.com/bobeobibo/phigaro/"
    default: basic
    inputBinding:
      position: 101
      prefix: --mode
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: "Do not delete any temporary files that was generated\n                 \
      \       by Phigaro (HMMER & Prodigal outputs and some others)."
    inputBinding:
      position: 101
      prefix: --no-cleanup
  - id: not_open
    type:
      - 'null'
      - boolean
    doc: "Do not open html file automatically, if html output\n                  \
      \      type is specified."
    inputBinding:
      position: 101
      prefix: --not-open
  - id: output
    type:
      - 'null'
      - File
    doc: "Output filename for html and txt outputs. Required by\n                \
      \        default, but not required for stdout only output."
    inputBinding:
      position: 101
      prefix: --output
  - id: print_vogs
    type:
      - 'null'
      - boolean
    doc: Print phage vogs for each region
    inputBinding:
      position: 101
      prefix: --print-vogs
  - id: save_fasta
    type:
      - 'null'
      - boolean
    doc: Save all phage fasta sequences in a fasta file.
    inputBinding:
      position: 101
      prefix: --save-fasta
  - id: substitute_output
    type:
      - 'null'
      - string
    doc: "If you have precomputed prodigal and/or hmmer data you\n               \
      \         can provide paths to the files in the following\n                \
      \        format: program:address/to/the/file. In place of\n                \
      \        program you should write hmmer or prodigal. If you\n              \
      \          need to provide both files you should pass them\n               \
      \         separetely as two parametres."
    inputBinding:
      position: 101
      prefix: --substitute-output
  - id: threads
    type:
      - 'null'
      - int
    doc: Num of threads (default is num of CPUs=20)
    default: num of CPUs=20
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phigaro:2.4.0--pyhdfd78af_0
stdout: phigaro.out
