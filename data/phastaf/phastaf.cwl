cwlVersion: v1.2
class: CommandLineTool
baseCommand: phastaf
label: phastaf
doc: "Find phage regions in bacterial genomes\n\nTool homepage: https://github.com/tseemann/phastaf"
inputs:
  - id: contigs
    type:
      type: array
      items: File
    doc: Contigs file in fasta, genbank, or gff format
    inputBinding:
      position: 1
  - id: check_dependencies
    type:
      - 'null'
      - boolean
    doc: Check dependencies are installed
    inputBinding:
      position: 102
      prefix: --check
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use (0=ALL)
    inputBinding:
      position: 102
      prefix: --cpus
  - id: diamond_database
    type:
      - 'null'
      - File
    doc: Diamond database of phage proteins
    inputBinding:
      position: 102
      prefix: --db
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwite of existing output folder
    inputBinding:
      position: 102
      prefix: --force
  - id: intergenic_fuzz_factor
    type:
      - 'null'
      - int
    doc: Intergenic fuzz factor
    inputBinding:
      position: 102
      prefix: --igff
  - id: keep_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files
    inputBinding:
      position: 102
      prefix: --keepfiles
  - id: min_genes_in_cluster
    type:
      - 'null'
      - int
    doc: Minimum genes in cluster
    inputBinding:
      position: 102
      prefix: --mingenes
  - id: output_directory
    type: Directory
    doc: Output folder
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phastaf:0.1.0--0
stdout: phastaf.out
