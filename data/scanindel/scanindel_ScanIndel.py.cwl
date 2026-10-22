cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ScanIndel.py
label: scanindel_ScanIndel.py
doc: "ScanIndel is a tool for indel calling.\n\nTool homepage: https://github.com/cauyrd/ScanIndel"
inputs:
  - id: config_file
    type: File
    doc: Config file with the BWA, BLAT and FreeBayes reference paths (relative to the working directory)
    inputBinding:
      position: 1
      prefix: -p
  - id: sample_file
    type: File
    doc: Sample list file (name and FASTQ or BAM paths, relative to the working directory)
    inputBinding:
      position: 2
      prefix: -i
  - id: input_files
    type: File[]
    doc: Read files (FASTQ or BAM) named in the sample file, staged in the working directory
  - id: reference_dir
    type: Directory
    doc: Directory with the reference FASTA (with .fai), the BWA index and a BLAT folder with a .2bit file, as named in the config file
  - id: assembly_only
    type:
      - 'null'
      - boolean
    doc: only execute de novo assembly for indel calling without blat 
      realignment
    inputBinding:
      position: 103
      prefix: --assembly_only
  - id: blat_ident_pct_cutoff
    type:
      - 'null'
      - float
    doc: Blat sequence identity cutoff
    inputBinding:
      position: 103
      prefix: --blat_ident_pct_cutoff
  - id: gfServer_port
    type:
      - 'null'
      - int
    doc: gfServer service port number
    inputBinding:
      position: 103
      prefix: --gfServer_port
  - id: hetero_factor
    type:
      - 'null'
      - float
    doc: The factor about the indel's heterogenirity and heterozygosity
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
    inputBinding:
      position: 103
      prefix: --lowqual_cutoff
  - id: mapping_only
    type:
      - 'null'
      - boolean
    doc: only execute blat realignment withou de novo assembly for indel calling
    inputBinding:
      position: 103
      prefix: --mapping_only
  - id: mapq_cutoff
    type:
      - 'null'
      - int
    doc: low mapping quality cutoff
    inputBinding:
      position: 103
      prefix: --mapq_cutoff
  - id: min_alternate_count_freebayes
    type:
      - 'null'
      - int
    doc: setting min-alternate-count for FreeBayes
    inputBinding:
      position: 103
      prefix: -C
  - id: min_alternate_fraction_freebayes
    type:
      - 'null'
      - float
    doc: setting min-alternate-fraction for FreeBayes
    inputBinding:
      position: 103
      prefix: -F
  - id: min_coverage_freebayes
    type:
      - 'null'
      - int
    doc: setting min-coverage for Freebayes
    inputBinding:
      position: 103
      prefix: -d
  - id: min_percent_hq
    type:
      - 'null'
      - float
    doc: min percentage of high quality base in soft clipping reads
    inputBinding:
      position: 103
      prefix: --min_percent_hq
  - id: output_dir
    type:
      - 'null'
      - string
    doc: setting the output directory
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
  - id: indel_vcfs
    type:
      type: array
      items: File
    outputBinding:
      glob: '*.indel.vcf'
  - id: realigned_bams
    type:
      type: array
      items: File
    outputBinding:
      glob:
        - '*.reads.bam'
        - '*.contigs.bam'
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: setting the output directory
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files)
      - $(inputs.reference_dir)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanindel:1.3--py27_0
stdout: scanindel_ScanIndel.py.out
