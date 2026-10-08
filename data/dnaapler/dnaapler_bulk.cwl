cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnaapler
  - bulk
label: dnaapler_bulk
doc: "Reorient sequences in bulk\n\nTool homepage: https://github.com/gbouras13/dnaapler"
inputs:
  - id: custom_db_path
    type:
      - 'null'
      - File
    doc: FASTA file with amino acids that will be used as a custom MMseqs2 
      database to reorient your sequence however you want. Must be specified if 
      -m custom is specified.
    inputBinding:
      position: 101
      prefix: --custom_db
  - id: evalue
    type:
      - 'null'
      - string
    doc: E-value for MMseqs2
    inputBinding:
      position: 101
      prefix: --evalue
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrites the output directory
    inputBinding:
      position: 101
      prefix: --force
  - id: input_path
    type: File
    doc: Path to input file in FASTA or GFA format
    inputBinding:
      position: 101
      prefix: --input
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Choose an mode to reorient in bulk. Must be one of: chromosome, plasmid,
      phage or custom'
    inputBinding:
      position: 101
      prefix: --mode
  - id: output_path
    type:
      - 'null'
      - string
    doc: Output directory
    default: output.dnaapler
    inputBinding:
      position: 101
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    default: dnaapler
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use with MMseqs2
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in prefix
    outputBinding:
      glob: $(inputs.output_path)/$(inputs.prefix)*
  - id: output_path_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnaapler:1.4.0--pyhdfd78af_0
stdout: dnaapler_bulk.out
