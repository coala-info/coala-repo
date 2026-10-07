cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comb-p
  - pipeline
label: combined-pvalues_pipeline
doc: "run acf, slk, fdr, peaks, region_p in succession\n\nTool homepage: https://github.com/brentp/combined-pvalues"
inputs:
  - id: column
    type:
      - 'null'
      - string
    doc: column that has the value to take the acf; column number (1-based) or header
      name
    inputBinding:
      position: 101
      prefix: -c
  - id: dist
    type: int
    doc: maximum distance to search for adjacent peaks
    inputBinding:
      position: 101
      prefix: --dist
  - id: acf_dist
    type:
      - 'null'
      - int
    doc: distance/window-size to use for smoothing (default 1/3 * dist)
    inputBinding:
      position: 101
      prefix: --acf-dist
  - id: step
    type:
      - 'null'
      - int
    doc: step size for bins in the ACF calculation
    inputBinding:
      position: 101
      prefix: --step
  - id: seed
    type:
      - 'null'
      - float
    doc: a value must be at least this large/small in order to seed a region
    inputBinding:
      position: 101
      prefix: --seed
  - id: threshold
    type:
      - 'null'
      - float
    doc: after seeding, a value of at least this number can extend a region
    inputBinding:
      position: 101
      prefix: --threshold
  - id: no_fdr
    type:
      - 'null'
      - boolean
    doc: don't use FDR-corrected p-values for finding peaks
    inputBinding:
      position: 101
      prefix: --no-fdr
  - id: prefix
    type: string
    doc: prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: genomic_control
    type:
      - 'null'
      - boolean
    doc: perform the genomic control correction on the input p-values
    inputBinding:
      position: 101
      prefix: --genomic-control
  - id: region_filter_p
    type:
      - 'null'
      - float
    doc: max adjusted region-level p-value to be reported in final output (input needs
      chrom, start, end, t columns)
    inputBinding:
      position: 101
      prefix: --region-filter-p
  - id: region_filter_n
    type:
      - 'null'
      - int
    doc: require at least this many probes for a region to be reported in final output
    inputBinding:
      position: 101
      prefix: --region-filter-n
  - id: annotate
    type:
      - 'null'
      - string
    doc: annotate with a gene table from this UCSC db (e.g. hg19); requires cruzdb
      and network
    inputBinding:
      position: 101
      prefix: --annotate
  - id: table
    type:
      - 'null'
      - string
    doc: annotate with this gene table from a db in UCSC (default refGene); requires
      cruzdb
    inputBinding:
      position: 101
      prefix: --table
  - id: bed_files
    type:
      type: array
      items: File
    doc: sorted bed files to process
    inputBinding:
      position: 1
outputs:
  - id: outputs
    type:
      type: array
      items: File
    doc: pipeline outputs (<prefix>.acf.txt, .slk.bed.gz, .fdr.bed.gz, .regions.bed.gz,
      .regions-p.bed.gz, ...)
    outputBinding:
      glob: $(inputs.prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
