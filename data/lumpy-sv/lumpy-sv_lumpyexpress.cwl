cwlVersion: v1.2
class: CommandLineTool
baseCommand: lumpyexpress
label: lumpy-sv_lumpyexpress
doc: "An automated script for running the LUMPY structural variant caller: it extracts split and discordant reads, estimates the insert size distribution and calls structural variants.\n\nTool homepage: https://github.com/arq5x/lumpy-sv"
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: lumpyexpress_depth
        type: record
        fields:
          - name: sample
            type: string
          - name: bedpe
            type: File
inputs:
  - id: full_bam
    type:
      type: array
      items: File
    doc: Full BAM or CRAM file(s), comma separated; BAM files need a .bai index
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
    inputBinding:
      position: 1
      prefix: -B
      itemSeparator: ','
  - id: split_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Split reads BAM file(s), comma separated
    inputBinding:
      position: 1
      prefix: -S
      itemSeparator: ','
  - id: discordant_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Discordant reads BAM file(s), comma separated
    inputBinding:
      position: 1
      prefix: -D
      itemSeparator: ','
  - id: reference
    type:
      - 'null'
      - File
    doc: Indexed reference genome FASTA file (recommended for CRAMs)
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 1
      prefix: -R
  - id: depth_bedpe
    type:
      - 'null'
      - type: array
        items: lumpyexpress_depth
    doc: BEDPE files of depths, one per sample (passed as sample:file,sample:file)
    inputBinding:
      position: 1
      prefix: -d
      valueFrom: |
        ${
          return self.map(function(r) { return r.sample + ":" + r.bedpe.path; }).join(",");
        }
  - id: output_vcf
    type:
      - 'null'
      - string
    doc: Output file name (default is the first BAM name with .vcf)
    inputBinding:
      position: 1
      prefix: -o
  - id: exclude_bed
    type:
      - 'null'
      - File
    doc: BED file of regions to exclude
    inputBinding:
      position: 1
      prefix: -x
  - id: probability_curves
    type:
      - 'null'
      - boolean
    doc: Output probability curves for each variant
    inputBinding:
      position: 1
      prefix: -P
  - id: min_sample_weight
    type:
      - 'null'
      - int
    doc: Minimum sample weight for a call (default 4)
    inputBinding:
      position: 1
      prefix: -m
  - id: trim_threshold
    type:
      - 'null'
      - float
    doc: Trim threshold (default 0)
    inputBinding:
      position: 1
      prefix: -r
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: Temporary directory (default ./output_prefix.XXXXXXXXXXXX)
    inputBinding:
      position: 1
      prefix: -T
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files
    inputBinding:
      position: 1
      prefix: -k
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to lumpyexpress.config file (default is the one next to lumpyexpress)
    inputBinding:
      position: 1
      prefix: -K
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 1
      prefix: -v
outputs:
  - id: vcf
    type: File
    doc: Structural variant calls (VCF)
    outputBinding:
      glob: "$(inputs.output_vcf ? inputs.output_vcf : '*.vcf')"
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv:0.3.1--3
stdout: lumpyexpress.out
