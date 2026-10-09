cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - bam2haplotypes
label: jvarkit_bam2haplotypes
doc: "Reconstruct haplotypes from reads, using the variants of an indexed VCF.\n\nTool homepage: https://github.com/lindenb/jvarkit"
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
  - id: alt
    type:
      - 'null'
      - string
    doc: "How shall we handle ALT allele that are not in the VCF. One of skip, warn (skip and warning), error (raise an error), N (replace with 'N'), all: use all alleles (default: all)"
    inputBinding:
      position: 1
      prefix: --alt
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: "When we're looking for variants in a large VCF file, load the variants in an interval of 'N' bases instead of doing a random access for each variant (default: 1000)"
    inputBinding:
      position: 2
      prefix: --buffer-size
  - id: ignore_discordant_rg
    type:
      - 'null'
      - boolean
    doc: "In paired mode, ignore discordant read-groups RG-ID."
    inputBinding:
      position: 3
      prefix: --ignore-discordant-rg
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: "When writing files that need to be sorted, this will specify the number of records stored in RAM before spilling to disk (default: 50000)"
    inputBinding:
      position: 4
      prefix: --maxRecordsInRam
  - id: out
    type:
      - 'null'
      - string
    doc: "Output file. Optional. Default: stdout"
    inputBinding:
      position: 5
      prefix: --out
  - id: paired
    type:
      - 'null'
      - boolean
    doc: "Activate Paired-end mode. Variant can be supported by the read or/and is mate. Input must be sorted on query name using for example 'samtools collate'."
    inputBinding:
      position: 6
      prefix: --paired
  - id: reference
    type:
      - 'null'
      - File
    doc: Indexed fasta Reference file. This file must be indexed with samtools faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    secondaryFiles:
      - .fai
      - "^.dict"
    inputBinding:
      position: 7
      prefix: --reference
  - id: regions
    type:
      - 'null'
      - string
    doc: "Limit analysis to this interval. A source of intervals. The following suffixes are recognized: vcf, vcf.gz bed, bed.gz, gtf, gff, gff.gz, gtf.gz. Otherwise it could be an empty string (no interval) or a list of plain interval separated by '[ \\t\\n;,]'"
    inputBinding:
      position: 8
      prefix: --regions
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "tmp working directory. Default: java.io.tmpDir"
    inputBinding:
      position: 9
      prefix: --tmpDir
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: "SAM Reader Validation Stringency. One of STRICT, LENIENT, SILENT (default: LENIENT)"
    inputBinding:
      position: 10
      prefix: --validation-stringency
  - id: vcf
    type: File
    doc: Indexed VCf file. Only diallelic SNP will be considered.
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 11
      prefix: --vcf
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
stdout: jvarkit_bam2haplotypes.out
