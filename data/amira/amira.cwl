cwlVersion: v1.2
class: CommandLineTool
baseCommand: amira
label: amira
doc: "Identify acquired AMR genes from bacterial long read sequences.\n\nTool homepage:
  https://github.com/Danderson123/Amira"
inputs:
  - id: assemble_paths
    type:
      - 'null'
      - boolean
    doc: Use Flye to assemble the full reads assigned to each AMR gene copy (default=False).
    inputBinding:
      position: 101
      prefix: --assemble-paths
  - id: assembly
    type:
      - 'null'
      - File
    doc: path to FASTA of assembly.
    inputBinding:
      position: 101
      prefix: --assembly
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of CPUs (default=1).
    default: 1
    inputBinding:
      position: 101
      prefix: --cores
  - id: coverage
    type:
      - 'null'
      - float
    doc: Minimum alignment coverage of a reference allele to keep an AMR gene (default=0.9).
    default: 0.9
    inputBinding:
      position: 101
      prefix: --coverage
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output Amira debugging files (default=False).
    inputBinding:
      position: 101
      prefix: --debug
  - id: gene_min_coverage
    type:
      - 'null'
      - float
    doc: Minimum relative threshold to remove all instances of a gene (default=0.2).
    default: 0.2
    inputBinding:
      position: 101
      prefix: -g
  - id: identity
    type:
      - 'null'
      - float
    doc: Minimum identity to a reference allele needed to report an AMR gene (default=0.9).
    default: 0.9
    inputBinding:
      position: 101
      prefix: --identity
  - id: maximum_length_proportion
    type:
      - 'null'
      - float
    doc: Maximum length threshold to filter a gene from a read (default=1.5).
    default: 1.5
    inputBinding:
      position: 101
      prefix: --maximum-length-proportion
  - id: meta
    type:
      - 'null'
      - boolean
    doc: Do not apply any filtering of genes based on coverage (default=False).
    inputBinding:
      position: 101
      prefix: --meta
  - id: min_relative_depth
    type:
      - 'null'
      - float
    doc: Minimum relative read depth to keep an AMR gene (default=0.2).
    default: 0.2
    inputBinding:
      position: 101
      prefix: --min-relative-depth
  - id: minimap2_path
    type:
      - 'null'
      - File
    doc: Path to minimap2 binary (default=minimap2).
    default: minimap2
    inputBinding:
      position: 101
      prefix: --minimap2-path
  - id: minimum_length_proportion
    type:
      - 'null'
      - float
    doc: Minimum length threshold to filter a gene from a read (default=0.5).
    default: 0.5
    inputBinding:
      position: 101
      prefix: --minimum-length-proportion
  - id: no_sampling
    type:
      - 'null'
      - boolean
    doc: Do not randomly sample to a maximum of 500,000 input reads (default=False).
    inputBinding:
      position: 101
      prefix: --no-sampling
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: Prevent trimming of the graph (default=False).
    inputBinding:
      position: 101
      prefix: --no-trim
  - id: node_min_coverage
    type:
      - 'null'
      - int
    doc: Minimum threshold for gene-mer coverage in the graph (default=3).
    default: 3
    inputBinding:
      position: 101
      prefix: -n
  - id: output_component_fastqs
    type:
      - 'null'
      - boolean
    doc: Output FASTQs of the reads for each connected component (default=False).
    inputBinding:
      position: 101
      prefix: --output-component-fastqs
  - id: pandora_path
    type:
      - 'null'
      - File
    doc: Path to pandora binary (default=pandora).
    default: pandora
    inputBinding:
      position: 101
      prefix: --pandora-path
  - id: panrg_path
    type: File
    doc: Path to pandora panRG ending .panidx.zip.
    inputBinding:
      position: 101
      prefix: --panRG-path
  - id: promoter_mutations
    type:
      - 'null'
      - boolean
    doc: Genotype the promoter sequences of certain AMR genes (only for Escherichia_coli).
    inputBinding:
      position: 101
      prefix: --promoter-mutations
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress updates (default=False).
    inputBinding:
      position: 101
      prefix: --quiet
  - id: racon_path
    type:
      - 'null'
      - File
    doc: Path to racon binary (default=racon).
    default: racon
    inputBinding:
      position: 101
      prefix: --racon-path
  - id: reads
    type:
      - 'null'
      - File
    doc: path to FASTQ file of long reads.
    inputBinding:
      position: 101
      prefix: --reads
  - id: sample_size
    type:
      - 'null'
      - int
    doc: Number of reads to subsample to (default=500,000).
    default: 500000
    inputBinding:
      position: 101
      prefix: --sample-size
  - id: samtools_path
    type:
      - 'null'
      - File
    doc: Path to samtools binary (default=samtools).
    default: samtools
    inputBinding:
      position: 101
      prefix: --samtools-path
  - id: seed
    type:
      - 'null'
      - int
    doc: Set the seed (default=2025).
    default: 2025
    inputBinding:
      position: 101
      prefix: --seed
  - id: species
    type: string
    doc: 'The species you want to run Amira on. Options: Escherichia_coli, Klebsiella_pneumoniae,
      Enterococcus_faecium, Streptococcus_pneumoniae, Staphylococcus_aureus, ESKAPEES.'
    inputBinding:
      position: 101
      prefix: --species
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Directory for Amira outputs (default=amira_output).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amira:0.11.0--pyhdfd78af_0
