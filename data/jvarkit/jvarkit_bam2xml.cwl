cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - bam2xml
label: jvarkit_bam2xml
doc: "Convert a BAM file to XML.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Input BAM/CRAM files
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 100
  - id: bam_compression
    type:
      - 'null'
      - int
    doc: "Compression Level. 0: no compression. 9: max compression (default: 5)"
    inputBinding:
      position: 1
      prefix: --bamcompression
  - id: out
    type:
      - 'null'
      - string
    doc: "Output file. Optional. Default: stdout"
    inputBinding:
      position: 2
      prefix: --out
  - id: reference
    type:
      - 'null'
      - File
    doc: Indexed fasta Reference file. This file must be indexed with samtools faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    secondaryFiles:
      - .fai
      - "^.dict"
    inputBinding:
      position: 3
      prefix: --reference
  - id: regions
    type:
      - 'null'
      - string
    doc: "Limit analysis to this interval. A source of intervals. The following suffixes are recognized: vcf, vcf.gz bed, bed.gz, gtf, gff, gff.gz, gtf.gz. Otherwise it could be an empty string (no interval) or a list of plain interval separated by '[ \\t\\n;,]'"
    inputBinding:
      position: 4
      prefix: --regions
  - id: sam_output_format
    type:
      - 'null'
      - string
    doc: "Sam output format. One of BAM, SAM, CRAM (default: SAM)"
    inputBinding:
      position: 5
      prefix: --samoutputformat
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: "SAM Reader Validation Stringency. One of STRICT, LENIENT, SILENT (default: LENIENT)"
    inputBinding:
      position: 6
      prefix: --validation-stringency
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, when the output option is given
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output (the result, when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_bam2xml.out
