cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pancake
  - singletons
label: pancake_singletons
doc: "Identify singleton regions in a PanCake Data Object File and output them as
  FASTA or BED files.\n\nTool homepage: https://github.com/pancakeswap/pancake-frontend"
inputs:
  - id: exclude_chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Names of CHROMOSOMES to exclude from singleton analysis (DEFAULT: No chromosomes
      excluded)'
    inputBinding:
      position: 101
      prefix: --exclude_chromosomes
  - id: exclude_genomes
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Names of GENOMES to exclude from singleton analysis (DEFAULT: No genomes
      excluded)'
    inputBinding:
      position: 101
      prefix: --exclude_genomes
  - id: min_len
    type:
      - 'null'
      - int
    doc: minimum length of regions to identify as a singleton region
    inputBinding:
      position: 101
      prefix: --min_len
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: if set, supress .fasta output of singleton regions
    inputBinding:
      position: 101
      prefix: --no_output
  - id: non_ref_chroms
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Names of non-reference CHROMOSOMES (DEFAULT: ALL non-reference chromosomes)'
    inputBinding:
      position: 101
      prefix: --non_ref_chroms
  - id: non_ref_genomes
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Names of non-reference GENOMES (DEFAULT: ALL non-reference genomes)'
    inputBinding:
      position: 101
      prefix: --non_ref_genomes
  - id: pan_file
    type: File
    doc: Name of PanCake Data Object File (required)
    inputBinding:
      position: 101
      prefix: --panfile
  - id: ref_chrom
    type:
      - 'null'
      - string
    doc: Reference CHROMOSOME (define either ONE reference chromosome or ONE reference
      genome)
    inputBinding:
      position: 101
      prefix: --ref_chrom
  - id: ref_genome
    type:
      - 'null'
      - string
    doc: Reference GENOME (define either ONE reference chromosome or ONE reference
      genome)
    inputBinding:
      position: 101
      prefix: --ref_genome
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: directory to which .fasta files of singleton regions are written
    outputBinding:
      glob: $(inputs.output_dir)
  - id: bed_file
    type:
      - 'null'
      - File
    doc: .bed file to which singleton regions are written
    outputBinding:
      glob: $(inputs.bed_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pancake:1.1.2--py35_0
