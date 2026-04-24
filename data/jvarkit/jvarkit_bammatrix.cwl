cwlVersion: v1.2
class: CommandLineTool
baseCommand: bammatrix
label: jvarkit_bammatrix
doc: "Create a matrix of read counts per region.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files
    inputBinding:
      position: 1
  - id: color_scale
    type:
      - 'null'
      - string
    doc: Color scale
    inputBinding:
      position: 102
      prefix: --color-scale
  - id: distance
    type:
      - 'null'
      - int
    doc: "Don't evaluate a point if the distance between the regions is lower than
      'd'. Negative: don't consider distance."
    inputBinding:
      position: 102
      prefix: --distance
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: Optional gtf file to draw the exons. A GTF (General Transfer Format) 
      file. See https://www.ensembl.org/info/website/upload/gff.html . Please 
      note that CDS are only detected if a start and stop codons are defined.
    inputBinding:
      position: 102
      prefix: --gtf
  - id: highlight_regions
    type:
      - 'null'
      - File
    doc: Optional Bed file to hightlight regions of interest
    inputBinding:
      position: 102
      prefix: --higligth
  - id: matrix_size
    type:
      - 'null'
      - int
    doc: matrix size in pixel
    inputBinding:
      position: 102
      prefix: --size
  - id: min_common
    type:
      - 'null'
      - int
    doc: Don't print a point if there are less than 'c' common names at the 
      intersection
    inputBinding:
      position: 102
      prefix: --min-common
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimal mapping quality
    inputBinding:
      position: 102
      prefix: --mapq
  - id: no_coverage
    type:
      - 'null'
      - boolean
    doc: Don't print coverage
    inputBinding:
      position: 102
      prefix: --no-coverage
  - id: pixel_size
    type:
      - 'null'
      - float
    doc: pixel size. Each dot at intersection will have the following size
    inputBinding:
      position: 102
      prefix: --pixel
  - id: read_name_source
    type:
      - 'null'
      - string
    doc: user read name or use 'BX:Z:'/'MI:i:' attribute from 10x genomics as 
      the read name. "Chromium barcode sequence that is error-corrected and 
      confirmed against a list of known-good barcode sequences.". See 
      https://support.10xgenomics.com/genome-exome/software/pipelines/latest/output/bam
    inputBinding:
      position: 102
      prefix: --name
  - id: reference_file
    type:
      - 'null'
      - File
    doc: Indexed fasta Reference file. This file must be indexed with samtools 
      faidx and with picard/gatk CreateSequenceDictionary or samtools dict
    inputBinding:
      position: 102
      prefix: --reference
  - id: region1
    type:
      - 'null'
      - string
    doc: 'first region.An interval as the following syntax : "chrom:start-end" or
      "chrom:middle+extend" or "chrom:start-end+extend" or "chrom:start-end+extend-percent%".A
      program might use a Reference sequence to fix the chromosome name (e.g: 1->chr1)'
    inputBinding:
      position: 102
      prefix: --region
  - id: region2
    type:
      - 'null'
      - string
    doc: '2nd region. Default: use first region. An interval as the following syntax
      : "chrom:start-end" or "chrom:middle+extend" or "chrom:start-end+extend" or
      "chrom:start-end+extend-percent%".A program might use a Reference sequence to
      fix the chromosome name (e.g: 1->chr1)'
    inputBinding:
      position: 102
      prefix: --region2
  - id: use_sa_alignments
    type:
      - 'null'
      - boolean
    doc: Use other canonical alignements from the 'SA:Z:*' attribute
    inputBinding:
      position: 102
      prefix: --sa
  - id: use_supplementary_alignments
    type:
      - 'null'
      - boolean
    doc: Use other supplementary alignements
    inputBinding:
      position: 102
      prefix: --supplementary
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
