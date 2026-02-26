cwlVersion: v1.2
class: CommandLineTool
baseCommand: long-orfs
label: tigr-glimmer_long-orfs
doc: Read DNA sequence in <sequence-file> and find and output the coordinates of
  long, non-overlapping orfs in it.
inputs:
  - id: sequence_file
    type: File
    doc: Input DNA sequence file
    inputBinding:
      position: 1
  - id: entropy_cutoff
    type:
      - 'null'
      - float
    doc: Only genes with entropy distance score less than <x> will be considered
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: entropy_file
    type:
      - 'null'
      - File
    doc: File containing entropy profiles
    inputBinding:
      position: 102
      prefix: --entropy
  - id: fixed_min_gene_length
    type:
      - 'null'
      - boolean
    doc: Do NOT automatically determine the minimum gene length to maximize 
      total length of output regions
    inputBinding:
      position: 102
      prefix: --fixed
  - id: ignore_regions_file
    type:
      - 'null'
      - File
    doc: File specifying regions of bases that are off limits
    inputBinding:
      position: 102
      prefix: --ignore
  - id: linear_genome
    type:
      - 'null'
      - boolean
    doc: Assume linear rather than circular genome (no wraparound)
    inputBinding:
      position: 102
      prefix: --linear
  - id: max_overlap_length
    type:
      - 'null'
      - int
    doc: Set maximum overlap length to <n>. Overlaps this short or shorter are 
      ignored.
    inputBinding:
      position: 102
      prefix: --max_olap
  - id: min_gene_length
    type:
      - 'null'
      - int
    doc: Minimum gene length to consider
    inputBinding:
      position: 102
      prefix: --min_len
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not include heading information in the output; only output the 
      orf-coordinate lines
    inputBinding:
      position: 102
      prefix: --no_header
  - id: optimize_length
    type:
      - 'null'
      - boolean
    doc: Find and use the minimum gene length that maximizes the total length of
      non-overlapping genes, instead of maximizing the number of such genes
    inputBinding:
      position: 102
      prefix: --length_opt
  - id: start_codons
    type:
      - 'null'
      - string
    doc: Comma-separated list of codons to use as start codons
    inputBinding:
      position: 102
      prefix: --start_codons
  - id: stop_codons
    type:
      - 'null'
      - string
    doc: Comma-separated list of codons to use as stop codons
    inputBinding:
      position: 102
      prefix: --stop_codons
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Use Genbank translation table number <n> for stop codons
    inputBinding:
      position: 102
      prefix: --trans_table
  - id: without_stops
    type:
      - 'null'
      - boolean
    doc: Do NOT include the stop codon in the output coordinates. By default, it
      is included.
    inputBinding:
      position: 102
      prefix: --without_stops
outputs:
  - id: output_file
    type: File
    doc: Output file for ORFs coordinates, or '-' for standard output
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
