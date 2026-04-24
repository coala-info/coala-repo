cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanomotif detect_contamination
label: nanomotif_detect_contamination
doc: "Detects contamination in nanopore motif data.\n\nTool homepage: https://pypi.org/project/nanomotif/"
inputs:
  - id: assembly
    type: File
    doc: Path to assembly file [fasta format required]
    inputBinding:
      position: 101
      prefix: --assembly
  - id: bin_motifs
    type: File
    doc: Path to bin-motifs.tsv file
    inputBinding:
      position: 101
      prefix: --bin_motifs
  - id: contamination_file
    type:
      - 'null'
      - File
    doc: Path to an existing contamination file if bins should be outputtet as a
      post-processing step
    inputBinding:
      position: 101
      prefix: --contamination_file
  - id: contig_bins
    type: File
    doc: Path to bins.tsv file for contig bins
    inputBinding:
      position: 101
      prefix: --contig_bins
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force override of motifs-scored-read-methylation.tsv. If not set 
      existing file will be used.
    inputBinding:
      position: 101
      prefix: --force
  - id: methylation_output_type
    type:
      - 'null'
      - string
    doc: Specify whether to use the median of mean methylated motif positions or
      the weighted mean.
    inputBinding:
      position: 101
      prefix: --methylation_output_type
  - id: methylation_threshold
    type:
      - 'null'
      - float
    doc: Filtering criteria for trusting contig methylation. It is the product 
      of mean_read_coverage and N_motif_observation. Higher value means stricter
      criteria.
    inputBinding:
      position: 101
      prefix: --methylation_threshold
  - id: min_valid_read_coverage
    type:
      - 'null'
      - int
    doc: Minimum read coverage for calculating methylation [used with 
      methylation_util executable]
    inputBinding:
      position: 101
      prefix: --min_valid_read_coverage
  - id: num_consensus
    type:
      - 'null'
      - int
    doc: Number of models that has to agree for classifying as contaminant
    inputBinding:
      position: 101
      prefix: --num_consensus
  - id: pileup
    type: File
    doc: Path to pileup.bed
    inputBinding:
      position: 101
      prefix: --pileup
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for multiprocessing
    inputBinding:
      position: 101
      prefix: --threads
  - id: write_bins
    type:
      - 'null'
      - boolean
    doc: If specified, new bins will be written to a bins folder. Requires 
      --assembly_file to be specified.
    inputBinding:
      position: 101
      prefix: --write_bins
outputs:
  - id: out
    type: Directory
    doc: Path to output directory
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanomotif:1.1.2--pyhdfd78af_0
