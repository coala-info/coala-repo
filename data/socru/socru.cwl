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
  - id: threads
    type:
      - 'null'
      - int
    doc: No. of threads to use
    inputBinding:
      position: 103
      prefix: --threads
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output filename, defaults to STDOUT
    inputBinding:
      position: 104
      prefix: --output_file
  - id: output_plot_file_path
    type:
      - 'null'
      - string
    doc: Filename of plot of genome structure (default genome_structure.pdf)
    default: genome_structure.pdf
    inputBinding:
      position: 105
      prefix: --output_plot_file
  - id: novel_profiles_path
    type:
      - 'null'
      - string
    doc: Filename for novel profiles (default profile.txt.novel)
    default: profile.txt.novel
    inputBinding:
      position: 105
      prefix: --novel_profiles
  - id: new_fragments_path
    type:
      - 'null'
      - string
    doc: Filename for novel fragments (default novel_fragments.fa)
    default: novel_fragments.fa
    inputBinding:
      position: 105
      prefix: --new_fragments
  - id: top_blast_hits_path
    type:
      - 'null'
      - string
    doc: Filename for top blast hits
    inputBinding:
      position: 105
      prefix: --top_blast_hits
  - id: output_operon_directions_file_path
    type:
      - 'null'
      - string
    doc: Filename of directions of operons (default operon_directions.txt)
    default: operon_directions.txt
    inputBinding:
      position: 105
      prefix: --output_operon_directions_file
  - id: max_bases_from_ends
    type:
      - 'null'
      - int
    doc: Only look at this number of bases from start and end of fragment
    inputBinding:
      position: 103
      prefix: --max_bases_from_ends
  - id: not_circular
    type:
      - 'null'
      - boolean
    doc: Assume chromosome is not circularised
    inputBinding:
      position: 103
      prefix: -c
  - id: min_bit_score
    type:
      - 'null'
      - int
    doc: Minimum bit score (default 100)
    inputBinding:
      position: 103
      prefix: --min_bit_score
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Minimum alignment length (default 100)
    inputBinding:
      position: 103
      prefix: --min_alignment_length
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Turn on debugging
    inputBinding:
      position: 103
      prefix: --debug
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Typing result (STDOUT when no output file is given)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output filename, defaults to STDOUT
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: output_plot_file
    type:
      - 'null'
      - File
    doc: Filename of plot of genome structure
    outputBinding:
      glob: $(inputs.output_plot_file_path)
  - id: novel_profiles
    type:
      - 'null'
      - File
    doc: Filename for novel profiles
    outputBinding:
      glob: $(inputs.novel_profiles_path)
  - id: new_fragments
    type:
      - 'null'
      - File
    doc: Filename for novel fragments
    outputBinding:
      glob: $(inputs.new_fragments_path)
  - id: top_blast_hits
    type:
      - 'null'
      - File
    doc: Filename for top blast hits
    outputBinding:
      glob: $(inputs.top_blast_hits_path)
  - id: output_operon_directions_file
    type:
      - 'null'
      - File
    doc: Filename of directions of operons
    outputBinding:
      glob: $(inputs.output_operon_directions_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
stdout: socru.out
