cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ExpansionHunterDenovo
  - profile
label: expansionhunterdenovo_profile
doc: "Compute genome-wide STR profile\n\nTool homepage: https://github.com/Illumina/ExpansionHunterDenovo"
inputs:
  - id: reads
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
    doc: BAM or CRAM file with aligned reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: FASTA file with reference assembly
    inputBinding:
      position: 101
      prefix: --reference
  - id: min_unit_len
    type:
      - 'null'
      - int
    doc: Shortest repeat unit to consider
    inputBinding:
      position: 101
      prefix: --min-unit-len
  - id: max_unit_len
    type:
      - 'null'
      - int
    doc: Longest repeat unit to consider
    inputBinding:
      position: 101
      prefix: --max-unit-len
  - id: min_anchor_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ of an anchor read
    inputBinding:
      position: 101
      prefix: --min-anchor-mapq
  - id: max_irr_mapq
    type:
      - 'null'
      - int
    doc: Maximum MAPQ of an in-repeat read
    inputBinding:
      position: 101
      prefix: --max-irr-mapq
  - id: log_reads
    type:
      - 'null'
      - boolean
    doc: Log informative reads (reported in the tool log; no extra output file)
    inputBinding:
      position: 101
      prefix: --log-reads
  - id: output_prefix
    type: string
    doc: Prefix for the output files
    inputBinding:
      position: 102
      prefix: --output-prefix
outputs:
  - id: str_profile
    type:
      - 'null'
      - File
    doc: STR profile in JSON format
    outputBinding:
      glob: $(inputs.output_prefix).str_profile.json
  - id: locus_tsv
    type:
      - 'null'
      - File
    doc: Anchored in-repeat read counts per locus
    outputBinding:
      glob: $(inputs.output_prefix).locus.tsv
  - id: motif_tsv
    type:
      - 'null'
      - File
    doc: In-repeat read pair counts per motif
    outputBinding:
      glob: $(inputs.output_prefix).motif.tsv
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
