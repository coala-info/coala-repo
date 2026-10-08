cwlVersion: v1.2
class: CommandLineTool
baseCommand: FRC
label: frc_align_FRC
doc: "Feature Response Curve (FRC) computes assembly quality features and the FRC
  from paired-end and mate-pair read alignments against an assembly.\n\nTool homepage:
  https://github.com/vezzi/FRC_align"
inputs:
  - id: pe_sam
    type:
      - 'null'
      - File
    doc: Paired end alignment file (in sam or bam format). Orientation must be -> <-
    inputBinding:
      position: 101
      prefix: --pe-sam
  - id: pe_max_insert
    type:
      - 'null'
      - int
    doc: Maximum allowed insert size for PE (to filter out outliers)
    inputBinding:
      position: 101
      prefix: --pe-max-insert
  - id: mp_sam
    type:
      - 'null'
      - File
    doc: Mate pairs alignment file (in sam or bam format). Orientation must be <- ->
    inputBinding:
      position: 101
      prefix: --mp-sam
  - id: mp_max_insert
    type:
      - 'null'
      - int
    doc: Maximum allowed insert size for MP (to filter out outliers)
    inputBinding:
      position: 101
      prefix: --mp-max-insert
  - id: genome_size
    type:
      - 'null'
      - int
    doc: Estimated genome size (if not supplied genome size is believed to be assembly
      length)
    inputBinding:
      position: 101
      prefix: --genome-size
  - id: output
    type:
      - 'null'
      - string
    doc: Header output file names (default FRC.txt and Features.txt)
    inputBinding:
      position: 101
      prefix: --output
  - id: ce_stats_pe_min
    type:
      - 'null'
      - double
    doc: Minimum allowed CE_stats in PE library
    inputBinding:
      position: 101
      prefix: --CEstats-PE-min
  - id: ce_stats_pe_max
    type:
      - 'null'
      - double
    doc: Maximum allowed CE_stats in PE library
    inputBinding:
      position: 101
      prefix: --CEstats-PE-max
  - id: ce_stats_mp_min
    type:
      - 'null'
      - double
    doc: Minimum allowed CE_stats in MP library
    inputBinding:
      position: 101
      prefix: --CEstats-MP-min
  - id: ce_stats_mp_max
    type:
      - 'null'
      - double
    doc: Maximum allowed CE_stats in MP library
    inputBinding:
      position: 101
      prefix: --CEstats-MP-max
outputs:
  - id: frc_files
    type:
      type: array
      items: File
    doc: FRC curves, feature lists, feature GFF and CE statistics (<output>*)
    outputBinding:
      glob: "${ var o = inputs.output ? inputs.output : ''; if (o) { return [o + '*']; } return ['FRC.txt', 'Features.txt', '*_FRC.txt', '*Features.gff', '*_CEstats_*.txt']; }"
  - id: tables
    type:
      type: array
      items: File
    doc: Per-contig statistics table (*_contigsTable.csv)
    outputBinding:
      glob: '*_contigsTable.csv'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frc:5b3f53e--boost1.64_0
