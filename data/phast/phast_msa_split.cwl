cwlVersion: v1.2
class: CommandLineTool
baseCommand: phast_msa_split
label: phast_msa_split
doc: "Splits a multiple sequence alignment into smaller files.\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: input_msa
    type: File
    doc: The multiple sequence alignment file to split.
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Prefix for the output files. Each split file will be named 
      <output_prefix>.<N>, where N is the file number.
    inputBinding:
      position: 2
  - id: format
    type:
      - 'null'
      - string
    doc: The format of the input MSA. Supported formats are 'fasta', 'phylip', 
      'nexus', and 'maf'. Defaults to 'fasta'.
    default: fasta
    inputBinding:
      position: 103
      prefix: --format
  - id: lines_per_file
    type:
      - 'null'
      - int
    doc: The maximum number of sequences per output file. If not specified, the 
      MSA will be split into `num_files` files.
    inputBinding:
      position: 103
      prefix: --lines-per-file
  - id: num_files
    type:
      - 'null'
      - int
    doc: The desired number of output files. The MSA will be split as evenly as 
      possible among these files. If not specified, the MSA will be split into 
      10 files by default.
    inputBinding:
      position: 103
      prefix: --num-files
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
stdout: phast_msa_split.out
