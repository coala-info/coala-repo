cwlVersion: v1.2
class: CommandLineTool
baseCommand: jvarkit_bam2haplotypes
label: jvarkit_bam2haplotypes
doc: "Create haplotypes from BAM files based on variants in a VCF file.\n\nTool homepage:
  https://github.com/lindenb/jvarkit"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input BAM files
    inputBinding:
      position: 1
  - id: alt_handling
    type:
      - 'null'
      - string
    doc: "How shall we handle ALT allele that are not in the VCF. skip, warn (skip
      and warning), error (raise an error), N (replace with 'N')), all: use all alleles."
    default: all
    inputBinding:
      position: 102
      prefix: --alt
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: When we're looking for variants in a lare VCF file, load the variants 
      in an interval of 'N' bases instead of doing a random access for each 
      variant.
    default: 1000
    inputBinding:
      position: 102
      prefix: --buffer-size
  - id: help_format
    type:
      - 'null'
      - string
    doc: What kind of help. One of [usage,markdown,xml].
    inputBinding:
      position: 102
      prefix: --helpFormat
  - id: ignore_discordant_rg
    type:
      - 'null'
      - boolean
    doc: In paired mode, ignore discordant read-groups RG-ID.
    default: false
    inputBinding:
      position: 102
      prefix: --ignore-discordant-rg
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk. Increasing this number 
      reduces the number of file handles needed to sort a file, and increases 
      the amount of RAM needed
    default: 50000
    inputBinding:
      position: 102
      prefix: --maxRecordsInRam
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Activate Paired-end mode. Variant can be supported by the read or/and 
      is mate. Input must be sorted on query name using for example 'samtools 
      collate'.
    default: false
    inputBinding:
      position: 102
      prefix: --paired
  - id: reference
    type:
      - 'null'
      - File
    doc: Indexed fasta Reference file. This file must be indexed with samtools 
      faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    inputBinding:
      position: 102
      prefix: --reference
  - id: regions
    type:
      - 'null'
      - string
    doc: "Limit analysis to this interval. A source of intervals. The following suffixes
      are recognized: vcf, vcf.gz bed, bed.gz, gtf, gff, gff.gz, gtf.gz.Otherwise
      it could be an empty string (no interval) or a list of plain interval separated
      by '[ \\t\\n;,]'"
    inputBinding:
      position: 102
      prefix: --regions
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: tmp working directory.
    default: '[]'
    inputBinding:
      position: 102
      prefix: --tmpDir
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: SAM Reader Validation Stringency
    default: LENIENT
    inputBinding:
      position: 102
      prefix: --validation-stringency
  - id: vcf_file
    type: File
    doc: Indexed VCf file. Only diallelic SNP will be considered.
    inputBinding:
      position: 102
      prefix: --vcf
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Output file. Optional . Default: stdout'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
