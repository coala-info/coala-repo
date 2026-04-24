cwlVersion: v1.2
class: CommandLineTool
baseCommand: aligned_bam_to_cpg_scores
label: pb-cpg-tools_aligned_bam_to_cpg_scores
doc: "A utility to calculate CpG methylation scores from an alignment file with 5mC
  methylation tags. Outputs results in bed and bigwig format, including haplotype-specific
  results when available.\n\nTool homepage: https://github.com/PacificBiosciences/pb-CpG-tools"
inputs:
  - id: bam
    type: File
    doc: Alignment file for input sample in BAM or CRAM format. Alignment file must
      be mapped and indexed, with MM/ML tags specifying 5mC methylation. If a CRAM
      file is provided, then `--ref` must also be specified
    inputBinding:
      position: 101
      prefix: --bam
  - id: hap_tag
    type:
      - 'null'
      - string
    doc: The 2-letter SAM aux tag used for per-read haplotype ids in the input bam
    inputBinding:
      position: 101
      prefix: --hap-tag
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Minimum site coverage. The tensorflow prediction models have their own hard-coded
      minimum coverage of 4, so any value below this level should have no effect in
      'model' pileup mode
    inputBinding:
      position: 101
      prefix: --min-coverage
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum read mapping quality
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: modsites_mode
    type:
      - 'null'
      - string
    doc: 'Method to pick 5mC scoring sites. Possible values: denovo (Pick sites where
      "CG" is present in the majority of the reads), reference (Pick sites where "CG"
      is present in the reference sequence)'
    inputBinding:
      position: 101
      prefix: --modsites-mode
  - id: pileup_mode
    type:
      - 'null'
      - string
    doc: 'Method to estimate site methylation from the read pileup. Possible values:
      model (Deep learning model-based approach), count (Simple count-based approach)'
    inputBinding:
      position: 101
      prefix: --pileup-mode
  - id: ref
    type:
      - 'null'
      - File
    doc: Genome reference in FASTA format. This is required if either (1) 'reference'
      modsite mode is selected or (2) input alignments are in CRAM format
    inputBinding:
      position: 101
      prefix: --ref
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Defaults to all logical cpus detected
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix used for all file output. If the prefix includes a directory, the
      directory must already exist
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pb-cpg-tools:3.0.0--h9ee0642_0
