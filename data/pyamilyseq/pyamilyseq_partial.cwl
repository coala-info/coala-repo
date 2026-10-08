cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyamilyseq
  - Partial
label: pyamilyseq_partial
doc: "Partial mode: PyamilySeq to process pre-clustered data.\n\nTool homepage: https://github.com/NickJD/PyamilySeq"
inputs:
  - id: clustering_format
    type: string
    doc: "Clustering format used: CD-HIT, MMseqs2, or BLAST."
    inputBinding:
      prefix: -clustering_format
  - id: cluster_file
    type: File
    doc: "Cluster file containing pre-clustered groups from CD-HIT, MMseqs, BLAST etc."
    inputBinding:
      prefix: -cluster_file
  - id: original_fasta
    type: File
    doc: "FASTA file used in pre-clustering (Provide sequences in DNA form)."
    inputBinding:
      prefix: -original_fasta
  - id: output_dir
    type: string
    doc: "Directory for all output files."
    inputBinding:
      prefix: -output_dir
  - id: reclustered
    type:
      - 'null'
      - File
    doc: "Clustering output file from a second round of clustering."
    inputBinding:
      prefix: -reclustered
  - id: seq_tag
    type:
      - 'null'
      - string
    doc: "Tag for distinguishing reclustered sequences."
    inputBinding:
      prefix: -seq_tag
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
