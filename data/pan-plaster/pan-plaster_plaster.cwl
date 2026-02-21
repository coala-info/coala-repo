cwlVersion: v1.2
class: CommandLineTool
baseCommand: plaster
label: pan-plaster_plaster
doc: "A tool for constructing pangenomes and aligning genomes.\n\nTool homepage: https://gitlab.com/treangenlab/plaster"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: a list of input fasta file names. If there is one file, it is assumed that
      this file contains a list of input files separated by a newline
    inputBinding:
      position: 1
  - id: align_only
    type:
      - 'null'
      - boolean
    doc: Used with --template. Does not append to pangenome, just produces tsv alignment.
    inputBinding:
      position: 102
      prefix: --align-only
  - id: id_cutoff
    type:
      - 'null'
      - float
    doc: Minimum identity to record alignment in metadata
    inputBinding:
      position: 102
      prefix: --id-cutoff
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files
    inputBinding:
      position: 102
      prefix: --keep-tmp
  - id: length
    type:
      - 'null'
      - int
    doc: Minimum length of sequence attached to the pan-genome
    inputBinding:
      position: 102
      prefix: --length
  - id: max_frag_len
    type:
      - 'null'
      - int
    doc: Maximum fragment length
    inputBinding:
      position: 102
      prefix: --max-frag-len
  - id: realign
    type:
      - 'null'
      - boolean
    doc: Realign all input genomes to the resulting pangenome to get a more accurate
      fragment mapping
    inputBinding:
      position: 102
      prefix: --realign
  - id: template
    type:
      - 'null'
      - File
    doc: seed genome to use
    inputBinding:
      position: 102
      prefix: --template
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save nucmer outputs.
    inputBinding:
      position: 102
      prefix: --work-dir
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output pan-genome fasta and metadata file stem (does not include file extension)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pan-plaster:1.2.1--hdfd78af_0
