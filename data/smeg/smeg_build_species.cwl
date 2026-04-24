cwlVersion: v1.2
class: CommandLineTool
baseCommand: smeg_build_species
label: smeg_build_species
doc: "Builds a species database for SMEG.\n\nTool homepage: https://github.com/ohlab/SMEG"
inputs:
  - id: auto_mode
    type:
      - 'null'
      - boolean
    doc: Activate auto-mode
    inputBinding:
      position: 101
      prefix: -a
  - id: cluster_snps_threshold
    type:
      - 'null'
      - int
    doc: Cluster SNPs threshold for iterative clustering
    inputBinding:
      position: 101
      prefix: -t
  - id: genome_list_file
    type:
      - 'null'
      - File
    doc: File listing a subset of genomes for database building
    inputBinding:
      position: 101
      prefix: -l
  - id: genomes_directory
    type: Directory
    doc: Genomes directory
    inputBinding:
      position: 101
      prefix: -g
  - id: ignore_iterative_clustering
    type:
      - 'null'
      - boolean
    doc: Ignore iterative clustering
    inputBinding:
      position: 101
      prefix: -i
  - id: keep_roary_output
    type:
      - 'null'
      - boolean
    doc: Keep Roary output
    inputBinding:
      position: 101
      prefix: -k
  - id: output_directory
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: -o
  - id: reference_based_only
    type:
      - 'null'
      - boolean
    doc: Create database ONLY applicable with Reference-based SMEG method
    inputBinding:
      position: 101
      prefix: -e
  - id: representative_genome
    type:
      - 'null'
      - boolean
    doc: Representative genome
    inputBinding:
      position: 101
      prefix: -r
  - id: snp_threshold
    type:
      - 'null'
      - float
    doc: SNP assignment threshold (range 0.1 - 1)
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smeg:1.1.5--0
stdout: smeg_build_species.out
