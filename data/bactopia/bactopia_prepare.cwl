cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bactopia-prepare
label: bactopia_prepare
doc: "Create a 'file of filenames' (FOFN) of samples to be processed by Bactopia\n\
  \nTool homepage: https://github.com/bactopia/bactopia"
inputs:
  - id: fastq_dir
    type: Directory
    doc: Directory where FASTQ files are stored
    inputBinding:
      position: 1
      prefix: --path
  - id: assembly_ext
    type:
      - 'null'
      - string
    doc: 'Extension of the FASTA assemblies [default: .fna.gz]'
    inputBinding:
      position: 1
      prefix: --assembly-ext
  - id: fastq_ext
    type:
      - 'null'
      - string
    doc: 'Extension of the FASTQs [default: .fastq.gz]'
    inputBinding:
      position: 1
      prefix: --fastq-ext
  - id: fastq_separator
    type:
      - 'null'
      - string
    doc: 'Split FASTQ name on the last occurrence of the separator [default: _]'
    inputBinding:
      position: 1
      prefix: --fastq-separator
  - id: pe1_pattern
    type:
      - 'null'
      - string
    doc: 'Designates difference first set of paired-end reads [default: [Aa]|[Rr]1|1]'
    inputBinding:
      position: 1
      prefix: --pe1-pattern
  - id: pe2_pattern
    type:
      - 'null'
      - string
    doc: 'Designates difference second set of paired-end reads [default: [Bb]|[Rr]2|2]'
    inputBinding:
      position: 1
      prefix: --pe2-pattern
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Flag samples with multiple read sets to be merged by Bactopia
    inputBinding:
      position: 1
      prefix: --merge
  - id: ont
    type:
      - 'null'
      - boolean
    doc: Single-end reads should be treated as Oxford Nanopore reads
    inputBinding:
      position: 1
      prefix: --ont
  - id: hybrid
    type:
      - 'null'
      - boolean
    doc: Samples with paired and single-end reads will be set to Illumina-first hybrid
      assembly (requires --ont)
    inputBinding:
      position: 1
      prefix: --hybrid
  - id: short_polish
    type:
      - 'null'
      - boolean
    doc: Samples with paired and single-end reads will be set to Nanopore-first hybrid
      assembly (requires --ont)
    inputBinding:
      position: 1
      prefix: --short-polish
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Directories will be traversed recursively
    inputBinding:
      position: 1
      prefix: --recursive
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to add to the path
    inputBinding:
      position: 1
      prefix: --prefix
  - id: metadata
    type:
      - 'null'
      - File
    doc: Metadata per sample with genome size and species information
    inputBinding:
      position: 1
      prefix: --metadata
  - id: genome_size
    type:
      - 'null'
      - int
    doc: Genome size to use for all samples
    inputBinding:
      position: 1
      prefix: --genome-size
  - id: species
    type:
      - 'null'
      - string
    doc: Species to use for all samples (If available, can be used to determine genome
      size)
    inputBinding:
      position: 1
      prefix: --species
  - id: taxid
    type:
      - 'null'
      - string
    doc: Use the genome size of the Taxon ID for all samples
    inputBinding:
      position: 1
      prefix: --taxid
  - id: examples
    type:
      - 'null'
      - boolean
    doc: Print example usage
    inputBinding:
      position: 1
      prefix: --examples
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity of output
    inputBinding:
      position: 1
      prefix: --verbose
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed
    inputBinding:
      position: 1
      prefix: --silent
outputs:
  - id: fofn
    type: stdout
    doc: Tab-separated file of filenames (FOFN) for Bactopia
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
stdout: bactopia_prepare.tsv
