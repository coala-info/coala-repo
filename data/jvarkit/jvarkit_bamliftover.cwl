cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamliftover
label: jvarkit_bamliftover
doc: "LiftOver BAM/SAM/CRAM files to a new reference genome.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input BAM/SAM/CRAM files
    inputBinding:
      position: 1
  - id: bam_compression
    type:
      - 'null'
      - int
    doc: 'Compression Level. 0: no compression. 9: max compression'
    default: 5
    inputBinding:
      position: 102
      prefix: --bamcompression
  - id: chain
    type: File
    doc: LiftOver file
    inputBinding:
      position: 102
      prefix: --chain
  - id: destination_dict
    type: File
    doc: "A SAM Sequence dictionary source: it can be a *.dict file, a fasta file
      indexed with 'picard CreateSequenceDictionary' or 'samtools dict', or any hts
      file containing a dictionary (VCF, BAM, CRAM, intervals...)"
    inputBinding:
      position: 102
      prefix: --destination-dict
  - id: drop_seq
    type:
      - 'null'
      - boolean
    doc: drop SEQ and QUAL
    default: false
    inputBinding:
      position: 102
      prefix: --drop-seq
  - id: min_match
    type:
      - 'null'
      - float
    doc: lift over min-match
    default: 0.95
    inputBinding:
      position: 102
      prefix: --minmatch
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
      by '[ \t\n;,]'"
    inputBinding:
      position: 102
      prefix: --regions
  - id: sam_output_format
    type:
      - 'null'
      - string
    doc: Sam output format
    default: SAM
    inputBinding:
      position: 102
      prefix: --samoutputformat
  - id: save_position
    type:
      - 'null'
      - boolean
    doc: Save original position in SMA attribute
    default: false
    inputBinding:
      position: 102
      prefix: --save-position
  - id: unmapped
    type:
      - 'null'
      - boolean
    doc: discard unmapped reads/unlifted reads
    default: false
    inputBinding:
      position: 102
      prefix: --unmapped
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: SAM Reader Validation Stringency
    default: LENIENT
    inputBinding:
      position: 102
      prefix: --validation-stringency
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
