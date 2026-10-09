cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - bam2svg
label: jvarkit_bam2svg
doc: "Draw the reads of a BAM region as SVG images.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Input BAM/CRAM files
    secondaryFiles:
      - .bai
    inputBinding:
      position: 100
  - id: bases
    type:
      - 'null'
      - boolean
    doc: print bases in read
    inputBinding:
      position: 1
      prefix: --bases
  - id: gff
    type:
      - 'null'
      - File
    doc: Optional Tabix indexed GFF3 file. The option is also named --gff3.
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 2
      prefix: --gff
  - id: groupby
    type:
      - 'null'
      - string
    doc: "Group Reads by. Data partitioning using the SAM Read Group. It can be any combination of sample, library.... One of readgroup, sample, library, platform, center, sample_by_platform, sample_by_center, sample_by_platform_by_center, any (default: sample)"
    inputBinding:
      position: 3
      prefix: --groupby
  - id: interval
    type: string
    doc: "An interval as the following syntax : \"chrom:start-end\" or \"chrom:middle+extend\" or \"chrom:start-end+extend\" or \"chrom:start-end+extend-percent%\". A program might use a Reference sequence to fix the chromosome name (e.g: 1->chr1) The option is also named --region."
    inputBinding:
      position: 4
      prefix: --interval
  - id: mapq
    type:
      - 'null'
      - int
    doc: "min mapping quality (default: 1)"
    inputBinding:
      position: 5
      prefix: --mapq
  - id: output
    type: string
    doc: "An existing directory or a filename ending with the '.zip' or '.tar' or '.tar.gz' suffix."
    inputBinding:
      position: 6
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: file prefix
    inputBinding:
      position: 7
      prefix: --prefix
  - id: reference
    type: File
    doc: Indexed fasta Reference file. This file must be indexed with samtools faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    secondaryFiles:
      - .fai
      - "^.dict"
    inputBinding:
      position: 8
      prefix: --reference
  - id: showclipping
    type:
      - 'null'
      - boolean
    doc: Show clipping. The option is also named --clip.
    inputBinding:
      position: 9
      prefix: --showclipping
  - id: vcf
    type:
      - 'null'
      - File
    doc: "Indexed VCF. the Samples's name must be the same than in the BAM"
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 10
      prefix: --vcf
  - id: width
    type:
      - 'null'
      - int
    doc: "Page width (default: 1000)"
    inputBinding:
      position: 11
      prefix: --width
  - id: custom_parameters
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -D
          separate: false
    doc: "custom parameters. '-Dkey=value'. Undocumented."
    inputBinding:
      position: 12
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, when the output option is given
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output (the result, when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit_bam2svg.out
