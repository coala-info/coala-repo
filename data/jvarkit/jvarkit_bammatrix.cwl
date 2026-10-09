cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jvarkit
  - bammatrix
label: jvarkit_bammatrix
doc: "Draw a matrix of the reads shared between two regions of a BAM file.\n\nTool homepage: https://github.com/lindenb/jvarkit"
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
  - id: color_scale
    type:
      - 'null'
      - string
    doc: "Color scale. One of LINEAR, LOG (default: LOG)"
    inputBinding:
      position: 1
      prefix: --color-scale
  - id: distance
    type:
      - 'null'
      - int
    doc: "Don't evaluate a point if the distance between the regions is lower than 'd'. Negative: don't consider distance (default: -1)"
    inputBinding:
      position: 2
      prefix: --distance
  - id: gtf
    type:
      - 'null'
      - File
    doc: Optional gtf file to draw the exons. A GTF (General Transfer Format) file. Please note that CDS are only detected if a start and stop codons are defined.
    inputBinding:
      position: 3
      prefix: --gtf
  - id: higligth
    type:
      - 'null'
      - File
    doc: Optional Bed file to hightlight regions of interest
    inputBinding:
      position: 4
      prefix: --higligth
  - id: mapq
    type:
      - 'null'
      - int
    doc: "minimal mapping quality (default: 30)"
    inputBinding:
      position: 5
      prefix: --mapq
  - id: min_common
    type:
      - 'null'
      - int
    doc: "Don't print a point if there are less than 'c' common names at the intersection (default: 0)"
    inputBinding:
      position: 6
      prefix: --min-common
  - id: name
    type:
      - 'null'
      - string
    doc: "user read name or use 'BX:Z:'/'MI:i:' attribute from 10x genomics as the read name. One of READ_NAME, BX, MI (default: READ_NAME)"
    inputBinding:
      position: 7
      prefix: --name
  - id: no_coverage
    type:
      - 'null'
      - boolean
    doc: "Don't print coverage"
    inputBinding:
      position: 8
      prefix: --no-coverage
  - id: output
    type:
      - 'null'
      - string
    doc: "Output file. Optional. Default: stdout"
    inputBinding:
      position: 9
      prefix: --output
  - id: pixel
    type:
      - 'null'
      - int
    doc: "pixel size. Each dot at intersection will have the following size (default: 1)"
    inputBinding:
      position: 10
      prefix: --pixel
  - id: reference
    type:
      - 'null'
      - File
    doc: Indexed fasta Reference file. This file must be indexed with samtools faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    secondaryFiles:
      - .fai
      - "^.dict"
    inputBinding:
      position: 11
      prefix: --reference
  - id: region
    type: string
    doc: "first region. An interval as the following syntax : \"chrom:start-end\" or \"chrom:middle+extend\" or \"chrom:start-end+extend\" or \"chrom:start-end+extend-percent%\". A program might use a Reference sequence to fix the chromosome name (e.g: 1->chr1)"
    inputBinding:
      position: 12
      prefix: --region
  - id: region2
    type:
      - 'null'
      - string
    doc: "2nd region. Default: use first region. An interval as the following syntax : \"chrom:start-end\" or \"chrom:middle+extend\" or \"chrom:start-end+extend\" or \"chrom:start-end+extend-percent%\". A program might use a Reference sequence to fix the chromosome name (e.g: 1->chr1)"
    inputBinding:
      position: 13
      prefix: --region2
  - id: sa
    type:
      - 'null'
      - boolean
    doc: "Use other canonical alignements from the 'SA:Z:*' attribute"
    inputBinding:
      position: 14
      prefix: --sa
  - id: size
    type:
      - 'null'
      - int
    doc: "matrix size in pixel (default: 1000)"
    inputBinding:
      position: 15
      prefix: --size
  - id: supplementary
    type:
      - 'null'
      - boolean
    doc: Use other supplementary alignements
    inputBinding:
      position: 16
      prefix: --supplementary
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
stdout: jvarkit_bammatrix.out
