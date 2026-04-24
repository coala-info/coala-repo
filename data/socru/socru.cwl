cwlVersion: v1.2
class: CommandLineTool
baseCommand: socru
label: socru
doc: "Typing of genome level order and orientation in bacteria\n\nTool homepage: https://github.com/quadram-institute-bioscience/socru"
inputs:
  - id: species
    type: string
    doc: Species name, use socru_species to see all available
    inputBinding:
      position: 1
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA files (optionally gzipped)
    inputBinding:
      position: 2
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Base directory for species databases, defaults to bundled
    inputBinding:
      position: 103
      prefix: --db_dir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Turn on debugging
    inputBinding:
      position: 103
      prefix: --debug
  - id: max_bases_from_ends
    type:
      - 'null'
      - int
    doc: Only look at this number of bases from start and end of fragment
    inputBinding:
      position: 103
      prefix: --max_bases_from_ends
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Minimum alignment length
    inputBinding:
      position: 103
      prefix: --min_alignment_length
  - id: min_bit_score
    type:
      - 'null'
      - int
    doc: Minimum bit score
    inputBinding:
      position: 103
      prefix: --min_bit_score
  - id: new_fragments
    type:
      - 'null'
      - File
    doc: Filename for novel fragments
    inputBinding:
      position: 103
      prefix: --new_fragments
  - id: not_circular
    type:
      - 'null'
      - boolean
    doc: Assume chromosome is not circularised
    inputBinding:
      position: 103
      prefix: -c
  - id: novel_profiles
    type:
      - 'null'
      - File
    doc: Filename for novel profiles
    inputBinding:
      position: 103
      prefix: --novel_profiles
  - id: threads
    type:
      - 'null'
      - int
    doc: No. of threads to use
    inputBinding:
      position: 103
      prefix: --threads
  - id: top_blast_hits
    type:
      - 'null'
      - File
    doc: Filename for top blast hits
    inputBinding:
      position: 103
      prefix: --top_blast_hits
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output filename, defaults to STDOUT
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_plot_file
    type:
      - 'null'
      - File
    doc: Filename of plot of genome structure
    outputBinding:
      glob: $(inputs.output_plot_file)
  - id: output_operon_directions_file
    type:
      - 'null'
      - File
    doc: Filename of directions of operons
    outputBinding:
      glob: $(inputs.output_operon_directions_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
