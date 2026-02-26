cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_assemblo_spades
label: phyluce_phyluce_assembly_assemblo_spades
doc: "Assemble raw reads using SPAdes\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: A configuration file containing reads to assemble
    inputBinding:
      position: 101
      prefix: --config
  - id: cores
    type:
      - 'null'
      - int
    doc: The number of compute cores/threads to run with SPAdes
    inputBinding:
      position: 101
      prefix: --cores
  - id: dir
    type:
      - 'null'
      - Directory
    doc: A directory of reads to assemble
    inputBinding:
      position: 101
      prefix: --dir
  - id: do_not_clean
    type:
      - 'null'
      - boolean
    doc: Do not cleanup intermediate SPAdes files
    inputBinding:
      position: 101
      prefix: --do-not-clean
  - id: log_path
    type:
      - 'null'
      - Directory
    doc: The path to a directory to hold logs.
    inputBinding:
      position: 101
      prefix: --log-path
  - id: output
    type: Directory
    doc: The directory in which to store the assembly data
    inputBinding:
      position: 101
      prefix: --output
  - id: subfolder
    type:
      - 'null'
      - string
    doc: A subdirectory, below the level of the group, containing the reads
    inputBinding:
      position: 101
      prefix: --subfolder
  - id: verbosity
    type:
      - 'null'
      - string
    doc: The logging level to use
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_assembly_assemblo_spades.out
