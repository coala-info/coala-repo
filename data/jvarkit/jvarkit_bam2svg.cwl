cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam2svg
label: jvarkit_bam2svg
doc: "Create SVG images from BAM files.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input BAM files
    inputBinding:
      position: 1
  - id: bases
    type:
      - 'null'
      - boolean
    doc: print bases in read
    default: false
    inputBinding:
      position: 102
      prefix: --bases
  - id: clip
    type:
      - 'null'
      - boolean
    doc: Show clipping
    default: false
    inputBinding:
      position: 102
      prefix: --clip
  - id: custom_parameters
    type:
      - 'null'
      - string
    doc: custom parameters. '-Dkey=value'. Undocumented.
    default: '{}'
    inputBinding:
      position: 102
      prefix: -D
  - id: gff
    type:
      - 'null'
      - File
    doc: Optional Tabix indexed GFF3 file.
    inputBinding:
      position: 102
      prefix: --gff
  - id: gff3
    type:
      - 'null'
      - File
    doc: Optional Tabix indexed GFF3 file.
    inputBinding:
      position: 102
      prefix: --gff3
  - id: groupby
    type:
      - 'null'
      - string
    doc: Group Reads by. Data partitioning using the SAM Read Group (see 
      https://gatkforums.broadinstitute.org/gatk/discussion/6472/ ) . It can be 
      any combination of sample, library....
    default: sample
    inputBinding:
      position: 102
      prefix: --groupby
  - id: interval
    type:
      - 'null'
      - string
    doc: 'An interval as the following syntax : "chrom:start-end" or "chrom:middle+extend"  or
      "chrom:start-end+extend" or "chrom:start-end+extend-percent%".A program might
      use a Reference sequence to fix the chromosome name (e.g: 1->chr1)'
    inputBinding:
      position: 102
      prefix: --interval
  - id: mapq
    type:
      - 'null'
      - int
    doc: min mapping quality
    default: 1
    inputBinding:
      position: 102
      prefix: --mapq
  - id: prefix
    type:
      - 'null'
      - string
    doc: file prefix
    default: ''
    inputBinding:
      position: 102
      prefix: --prefix
  - id: reference
    type:
      - 'null'
      - File
    doc: Indexed fasta Reference file. This file must be indexed with samtools 
      faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    inputBinding:
      position: 102
      prefix: --reference
  - id: region
    type:
      - 'null'
      - string
    doc: 'An interval as the following syntax : "chrom:start-end" or "chrom:middle+extend"  or
      "chrom:start-end+extend" or "chrom:start-end+extend-percent%".A program might
      use a Reference sequence to fix the chromosome name (e.g: 1->chr1)'
    inputBinding:
      position: 102
      prefix: --region
  - id: showclipping
    type:
      - 'null'
      - boolean
    doc: Show clipping
    default: false
    inputBinding:
      position: 102
      prefix: --showclipping
  - id: vcf
    type:
      - 'null'
      - File
    doc: Indexed VCF. the Samples's name must be the same than in the BAM
    inputBinding:
      position: 102
      prefix: --vcf
  - id: width
    type:
      - 'null'
      - int
    doc: Page width
    default: 1000
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: An existing directory or a filename ending with the '.zip' or '.tar' or
      '.tar.gz' suffix.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
