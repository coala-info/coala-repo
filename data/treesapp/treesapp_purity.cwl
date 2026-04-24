cwlVersion: v1.2
class: CommandLineTool
baseCommand: treesapp_purity
label: treesapp_purity
doc: "Validate the functional purity of a reference package.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: An input file containing DNA or protein sequences in either FASTA or 
      FASTQ format
    inputBinding:
      position: 1
  - id: refpkg_path
    type:
      type: array
      items: File
    doc: Path to the reference package pickle (.pkl) file.
    inputBinding:
      position: 2
  - id: delete_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Delete all intermediate files to save disk space.
    inputBinding:
      position: 103
      prefix: --delete
  - id: extra_info
    type:
      - 'null'
      - File
    doc: File mapping header prefixes to description information.
    inputBinding:
      position: 103
      prefix: --extra_info
  - id: min_seq_length
    type:
      - 'null'
      - int
    doc: minimal sequence length after alignment trimming
    inputBinding:
      position: 103
      prefix: --min_seq_length
  - id: molecule_type
    type:
      - 'null'
      - string
    doc: Type of input sequences (prot = protein; dna = nucleotide; rrna = 
      rRNA). TreeSAPP will guess by default but this may be required if 
      ambiguous.
    inputBinding:
      position: 103
      prefix: --molecule
  - id: num_threads
    type:
      - 'null'
      - int
    doc: The number of CPU threads or parallel processes to use in various 
      pipeline steps
    inputBinding:
      position: 103
      prefix: --num_procs
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to an output directory
    inputBinding:
      position: 103
      prefix: --output
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrites previously written output files and directories
    inputBinding:
      position: 103
      prefix: --overwrite
  - id: stage
    type:
      - 'null'
      - string
    doc: The stage(s) for TreeSAPP to execute
    inputBinding:
      position: 103
      prefix: --stage
  - id: trim_align
    type:
      - 'null'
      - boolean
    doc: Flag to turn on position masking of the multiple sequence alignment
    inputBinding:
      position: 103
      prefix: --trim_align
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints a more verbose runtime log
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
stdout: treesapp_purity.out
