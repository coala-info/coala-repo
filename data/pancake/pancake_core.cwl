cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pancake
  - core
label: pancake_core
doc: "Identify and extract core genome regions from a PanCake Data Object File.\n\n
  Tool homepage: https://github.com/pancakeswap/pancake-frontend"
inputs:
  - id: exclude_chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Names of CHROMOSOMES to exclude from core analysis (DEFAULT: No chromosomes
      excluded)'
    inputBinding:
      position: 101
      prefix: --exclude_chromosomes
  - id: exclude_genomes
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Names of GENOMES to exclude from core analysis (DEFAULT: No genomes excluded)'
    inputBinding:
      position: 101
      prefix: --exclude_genomes
  - id: max_non_core_frac
    type:
      - 'null'
      - float
    doc: Maximum fraction of non-core sequence regions within each included sequence
      (FLOAT, DEAFULT=0.05)
    inputBinding:
      position: 101
      prefix: --max_non_core_frac
  - id: max_space
    type:
      - 'null'
      - int
    doc: maximum non-core space allowed within a core region (DEFAULT=25)
    inputBinding:
      position: 101
      prefix: --max_space
  - id: min_len
    type:
      - 'null'
      - int
    doc: minimum length of regions to identify as part of core genome (INTEGER, DEFAULT=25)
    inputBinding:
      position: 101
      prefix: --min_len
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: if set, supress .fasta output of core regions
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
  - id: panfile
    type: File
    doc: Name of PanCake Data Object File (required)
    inputBinding:
      position: 101
      prefix: --panfile
  - id: ref_chrom
    type:
      - 'null'
      - string
    doc: Reference CHROMOSOME (define either ONE reference chromosome OR ONE reference
      genome)
    inputBinding:
      position: 101
      prefix: --ref_chrom
  - id: ref_genome
    type:
      - 'null'
      - string
    doc: Reference GENOME (define either ONE reference chromosome OR ONE reference
      genome)
    inputBinding:
      position: 101
      prefix: --ref_genome
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: 'directory to which .fasta files of core regions are written (DEFAULT: core_{REF_CHROM|REF_GENOME})'
    outputBinding:
      glob: $(inputs.output)
  - id: bed_file
    type:
      - 'null'
      - File
    doc: .bed file to which core regions are written (DEFAULT= core_{REF_CHROM|REF_GENOME}.bed)
    outputBinding:
      glob: $(inputs.bed_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pancake:1.1.2--py35_0
