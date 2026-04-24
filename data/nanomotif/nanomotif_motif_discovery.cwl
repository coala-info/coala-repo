cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanomotif
  - motif_discovery
label: nanomotif_motif_discovery
doc: "Motif discovery from methylation data\n\nTool homepage: https://pypi.org/project/nanomotif/"
inputs:
  - id: assembly
    type: File
    doc: path to the assembly file.
    inputBinding:
      position: 1
  - id: pileup
    type: File
    doc: path to the modkit pileup file.
    inputBinding:
      position: 2
  - id: contig_bin
    type:
      - 'null'
      - File
    doc: TSV file specifying which bin contigs belong.
    inputBinding:
      position: 103
      prefix: --contig_bin
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Directory containing bin FASTA files with contig names as headers.
    inputBinding:
      position: 103
      prefix: --directory
  - id: extension
    type:
      - 'null'
      - string
    doc: File extension of the bin FASTA files if using -d (DIRECTORY) argument.
    inputBinding:
      position: 103
      prefix: --extension
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of bin FASTA files with contig names as headers.
    inputBinding:
      position: 103
      prefix: --files
  - id: methylation_threshold_high
    type:
      - 'null'
      - float
    doc: A position is considered methylated if fraction of methylated reads is 
      above this threshold.
    inputBinding:
      position: 103
      prefix: --methylation_threshold_high
  - id: methylation_threshold_low
    type:
      - 'null'
      - float
    doc: A position is considered non-methylated if fraction of methylation is 
      below this threshold.
    inputBinding:
      position: 103
      prefix: --methylation_threshold_low
  - id: min_motif_score
    type:
      - 'null'
      - float
    doc: Minimum score for a motif to be kept after identification.
    inputBinding:
      position: 103
      prefix: --min_motif_score
  - id: min_motifs_bin
    type:
      - 'null'
      - int
    doc: Minimum number of motif observations in a bin.
    inputBinding:
      position: 103
      prefix: --min_motifs_bin
  - id: minimum_kl_divergence
    type:
      - 'null'
      - float
    doc: Minimum KL-divergence for a position to considered for expansion in 
      motif search. Higher value means less exhaustive, but faster search.
    inputBinding:
      position: 103
      prefix: --minimum_kl_divergence
  - id: search_frame_size
    type:
      - 'null'
      - int
    doc: length of the sequnces sampled around confident methylation sites.
    inputBinding:
      position: 103
      prefix: --search_frame_size
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for random number generator.
    inputBinding:
      position: 103
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 103
      prefix: --threads
  - id: threshold_valid_coverage
    type:
      - 'null'
      - int
    doc: Minimum valid base coverage (Nvalid_cov) for a position to be 
      considered.
    inputBinding:
      position: 103
      prefix: --threshold_valid_coverage
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity. (set logger to debug level)
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: path to the output folder
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanomotif:1.1.2--pyhdfd78af_0
