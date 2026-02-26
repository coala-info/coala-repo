cwlVersion: v1.2
class: CommandLineTool
baseCommand: python ScanIndel.py
label: scanindel_ScanIndel.py
doc: "ScanIndel is a tool for indel calling.\n\nTool homepage: https://github.com/cauyrd/ScanIndel"
inputs:
  - id: config_file
    type: File
    doc: Configuration file
    inputBinding:
      position: 1
  - id: sample_file
    type: File
    doc: Sample file
    inputBinding:
      position: 2
  - id: assembly_only
    type:
      - 'null'
      - boolean
    doc: only execute de novo assembly for indel calling without blat 
      realignment
    default: false
    inputBinding:
      position: 103
      prefix: --assembly_only
  - id: blat_ident_pct_cutoff
    type:
      - 'null'
      - float
    doc: Blat sequence identity cutoff
    default: 0.8
    inputBinding:
      position: 103
      prefix: --blat_ident_pct_cutoff
  - id: gfServer_port
    type:
      - 'null'
      - int
    doc: gfServer service port number
    default: 50000
    inputBinding:
      position: 103
      prefix: --gfServer_port
  - id: hetero_factor
    type:
      - 'null'
      - float
    doc: The factor about the indel's heterogenirity and heterozygosity
    default: 0.1
    inputBinding:
      position: 103
      prefix: --hetero_factor
  - id: input_bam_format
    type:
      - 'null'
      - boolean
    doc: the input file is BAM format
    inputBinding:
      position: 103
      prefix: --bam
  - id: lowqual_cutoff
    type:
      - 'null'
      - int
    doc: low quality cutoff value
    default: 20
    inputBinding:
      position: 103
      prefix: --lowqual_cutoff
  - id: mapping_only
    type:
      - 'null'
      - boolean
    doc: only execute blat realignment withou de novo assembly for indel calling
    default: false
    inputBinding:
      position: 103
      prefix: --mapping_only
  - id: mapq_cutoff
    type:
      - 'null'
      - int
    doc: low mapping quality cutoff
    default: 1
    inputBinding:
      position: 103
      prefix: --mapq_cutoff
  - id: min_alternate_count_freebayes
    type:
      - 'null'
      - int
    doc: setting min-alternate-count for FreeBayes
    default: 2
    inputBinding:
      position: 103
      prefix: -C
  - id: min_alternate_fraction_freebayes
    type:
      - 'null'
      - float
    doc: setting min-alternate-fraction for FreeBayes
    default: 0.2
    inputBinding:
      position: 103
      prefix: -F
  - id: min_coverage_freebayes
    type:
      - 'null'
      - int
    doc: setting min-coverage for Freebayes
    default: 0
    inputBinding:
      position: 103
      prefix: -d
  - id: min_percent_hq
    type:
      - 'null'
      - float
    doc: min percentage of high quality base in soft clipping reads
    default: 0.8
    inputBinding:
      position: 103
      prefix: --min_percent_hq
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: setting the output directory
    default: current working directory
    inputBinding:
      position: 103
      prefix: -o
  - id: remove_duplicates
    type:
      - 'null'
      - boolean
    doc: exccute duplicate removal step before realignment
    inputBinding:
      position: 103
      prefix: --rmdup
  - id: softclipping_percentage
    type:
      - 'null'
      - float
    doc: softclipping percentage triggering BLAT re-alignment
    default: 0.2
    inputBinding:
      position: 103
      prefix: -s
  - id: target_bed_file
    type:
      - 'null'
      - File
    doc: setting --target for Freebayes to provide a BED file for analysis
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanindel:1.3--py27_0
stdout: scanindel_ScanIndel.py.out
