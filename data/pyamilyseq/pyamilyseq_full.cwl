cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyamilyseq
  - Full
label: pyamilyseq_full
doc: "Full mode: PyamilySeq to cluster with CD-HIT and process output.\n\nTool homepage: https://github.com/NickJD/PyamilySeq"
inputs:
  - id: output_dir
    type: string
    doc: "Directory for all output files."
    inputBinding:
      prefix: -output_dir
  - id: input_type
    type: string
    doc: "Type of input files: 'separate' for matching FASTA and GFF files, 'combined' for GFF+FASTA, or 'fasta' for a prepared FASTA file."
    inputBinding:
      prefix: -input_type
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: "Directory containing GFF/FASTA files - Use with -input_type separate/combined."
    inputBinding:
      prefix: -input_dir
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: "Input FASTA file - Use with -input_type fasta."
    inputBinding:
      prefix: -input_fasta
  - id: name_split_gff
    type:
      - 'null'
      - string
    doc: "Substring to split filenames and extract genome names for gff files (e.g., '_combined.gff3') - Use with -input_type separate/combined."
    inputBinding:
      prefix: -name_split_gff
  - id: name_split_fasta
    type:
      - 'null'
      - string
    doc: "Substring to split filenames and extract genome names for fasta files if named differently to paired gff files (e.g., '_dna.fasta') - Use with -input_type separate/combined."
    inputBinding:
      prefix: -name_split_fasta
  - id: sequence_type
    type:
      - 'null'
      - string
    doc: "Clustering mode: 'DNA' or 'AA'."
    inputBinding:
      prefix: -sequence_type
  - id: gene_ident
    type:
      - 'null'
      - string
    doc: "Gene identifiers to extract sequences (e.g., 'CDS, tRNA')."
    inputBinding:
      prefix: -gene_ident
  - id: pident
    type:
      - 'null'
      - float
    doc: "Sequence identity threshold for clustering (default: 0.90) - CD-HIT parameter '-c'."
    inputBinding:
      prefix: -c
  - id: len_diff
    type:
      - 'null'
      - float
    doc: "Length difference threshold for clustering (default: 0.80) - CD-HIT parameter '-s'."
    inputBinding:
      prefix: -s
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: "Enable fast mode for CD-HIT (not recommended) - CD-HIT parameter '-g'."
    inputBinding:
      prefix: -fast_mode
  - id: group_mode
    type:
      - 'null'
      - string
    doc: "Grouping mode: 'Species' or 'Genus'."
    inputBinding:
      prefix: -group_mode
  - id: species_groups
    type:
      - 'null'
      - string
    doc: "Gene groupings for 'Species' mode (default: '99,95,15')."
    inputBinding:
      prefix: -species_groups
  - id: genus_groups
    type:
      - 'null'
      - string
    doc: "Gene groupings for 'Genus' mode (default: '1-10')."
    inputBinding:
      prefix: -genus_groups
  - id: write_groups
    type:
      - 'null'
      - string
    doc: "Output gene groups as a single FASTA file (e.g., '99,95'). Triggers writing individual groups."
    inputBinding:
      prefix: -write_groups
  - id: write_individual_groups
    type:
      - 'null'
      - boolean
    doc: "Output individual FASTA files for each group."
    inputBinding:
      prefix: -write_individual_groups
  - id: align
    type:
      - 'null'
      - boolean
    doc: "Align and concatenate sequences for 'core' groups (those in 99-100% of genomes)."
    inputBinding:
      prefix: -align
  - id: align_aa
    type:
      - 'null'
      - boolean
    doc: "Align sequences as amino acids."
    inputBinding:
      prefix: -align_aa
  - id: no_gpa
    type:
      - 'null'
      - boolean
    doc: "Skip creation of gene_presence_absence.csv."
    inputBinding:
      prefix: -no_gpa
  - id: mem
    type:
      - 'null'
      - int
    doc: "Memory allocation for clustering (MB) - CD-HIT parameter '-M'."
    inputBinding:
      prefix: -M
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads for clustering/alignment - CD-HIT parameter '-T' | MAFFT parameter '--thread'."
    inputBinding:
      prefix: -T
outputs:
  - id: output_directory
    type: Directory
    doc: Directory with all output files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyamilyseq:1.3.3--pyhdfd78af_0
