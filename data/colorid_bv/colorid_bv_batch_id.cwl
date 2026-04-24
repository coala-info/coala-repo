cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - colorid_bv
  - batch_id
label: colorid_bv_batch_id
doc: "classifies batch of samples reads\n\nTool homepage: https://github.com/hcdenbakker/colorid_bv"
inputs:
  - id: batch
    type:
      - 'null'
      - int
    doc: Sets size of batch of reads to be processed in parallel
    inputBinding:
      position: 101
      prefix: --batch
  - id: bigsi
    type: File
    doc: index to be used for search
    inputBinding:
      position: 101
      prefix: --bigsi
  - id: bitvector_sample
    type:
      - 'null'
      - int
    doc: Collects matches for subset of kmers indicated, using this subset to more
      rapidly find hits for the remainder of the kmers
    inputBinding:
      position: 101
      prefix: --bitvector_sample
  - id: down_sample
    type:
      - 'null'
      - int
    doc: down-sample k-mers used for read classification; increases speed at cost
      of decreased sensitivity
    inputBinding:
      position: 101
      prefix: --down_sample
  - id: fp_correct
    type:
      - 'null'
      - int
    doc: Parameter to correct for false positives, maybe increased for larger searches.
      Adjust for larger datasets
    inputBinding:
      position: 101
      prefix: --fp_correct
  - id: quality
    type:
      - 'null'
      - int
    doc: kmers with nucleotides below this minimum phred score will be excluded from
      the analyses
    inputBinding:
      position: 101
      prefix: --quality
  - id: query
    type: File
    doc: tab-delimiteed file with samples to be classified [sample_name reads1 reads2
      (optional)]
    inputBinding:
      position: 101
      prefix: --query
  - id: supress_taxon
    type:
      - 'null'
      - string
    doc: Taxon to be supressed, for modelling/training purposes
    inputBinding:
      position: 101
      prefix: --supress_taxon
  - id: tag
    type: string
    doc: tag to be include in output file names
    inputBinding:
      position: 101
      prefix: --tag
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use, if not set the maximum available number threads
      will be used
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
stdout: colorid_bv_batch_id.out
