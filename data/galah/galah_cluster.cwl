cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - galah
  - cluster
label: galah_cluster
doc: "Cluster (dereplicate) genomes\n\nTool homepage: https://github.com/wwood/galah"
inputs:
  - id: ani
    type:
      - 'null'
      - float
    doc: Average Nucleotide Identity (ANI) threshold for clustering
    inputBinding:
      position: 101
      prefix: --ani
  - id: cluster_contigs
    type:
      - 'null'
      - boolean
    doc: Cluster contigs within FASTA files
    inputBinding:
      position: 101
      prefix: --cluster-contigs
  - id: genome_fasta_directory
    type:
      - 'null'
      - Directory
    doc: Directory containing .fna FASTA files to cluster
    inputBinding:
      position: 101
      prefix: --genome-fasta-directory
  - id: genome_fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more FASTA files containing contigs to cluster
    inputBinding:
      position: 101
      prefix: --genome-fasta-files
  - id: genome_fasta_list
    type:
      - 'null'
      - File
    doc: File containing paths to FASTA files to cluster
    inputBinding:
      position: 101
      prefix: --genome-fasta-list
  - id: precluster_ani
    type:
      - 'null'
      - float
    doc: ANI threshold for pre-clustering
    inputBinding:
      position: 101
      prefix: --precluster-ani
  - id: precluster_method
    type:
      - 'null'
      - string
    doc: Method to use for pre-clustering (e.g., finch)
    inputBinding:
      position: 101
      prefix: --precluster-method
  - id: reference_genomes_list
    type:
      - 'null'
      - File
    doc: File containing paths to reference FASTA files
    inputBinding:
      position: 101
      prefix: --reference-genomes-list
  - id: small_contigs
    type:
      - 'null'
      - boolean
    doc: Use small-genomes settings (recommended for contigs < 20kb)
    inputBinding:
      position: 101
      prefix: --small-contigs
outputs:
  - id: output_representative_fasta_directory
    type:
      - 'null'
      - Directory
    doc: Directory to store symlinked FASTA files of representatives
    outputBinding:
      glob: $(inputs.output_representative_fasta_directory)
  - id: output_cluster_definition
    type:
      - 'null'
      - File
    doc: File to output cluster definitions
    outputBinding:
      glob: $(inputs.output_cluster_definition)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galah:0.4.2--hc1c3326_2
