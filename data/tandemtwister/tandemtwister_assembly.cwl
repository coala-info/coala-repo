cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tandemtwister
  - assembly
label: tandemtwister_assembly
doc: "Genotyping tandem repeats from aligned genome input.\n\nTool homepage: https://github.com/Lionward/tandemtwister"
inputs:
  - id: input_bam
    type: File
    doc: Path to the BAM file containing aligned reads
    inputBinding:
      position: 101
      prefix: --bam
  - id: min_match_ratio_l
    type:
      - 'null'
      - float
    doc: Minimum match ratio for long motifs
    default: 0.5
    inputBinding:
      position: 101
      prefix: --min_match_ratio_l
  - id: motif_file
    type: File
    doc: Motif definition file (BED / TSV / CSV)
    inputBinding:
      position: 101
      prefix: --motif_file
  - id: reads_type
    type:
      - 'null'
      - string
    doc: 'Sequencing platform / read type (default: CCS)'
    default: CCS
    inputBinding:
      position: 101
      prefix: --reads_type
  - id: reference_fasta
    type: File
    doc: Reference FASTA file (.fa / .fna)
    inputBinding:
      position: 101
      prefix: --ref
  - id: sample_identifier
    type:
      - 'null'
      - string
    doc: Optional sample identifier
    inputBinding:
      position: 101
      prefix: --sample
  - id: sample_sex
    type: string
    doc: Sample sex (0 | female, 1 | male)
    inputBinding:
      position: 101
      prefix: --sex
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Verbosity level (0: error, 1: critical, 2: info, 3: debug)'
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output file for region, motif, and haplotype copy numbers
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tandemtwister:0.2.0--h9948957_0
