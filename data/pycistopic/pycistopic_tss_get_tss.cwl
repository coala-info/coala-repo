cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pycistopic
  - tss
  - get_tss
label: pycistopic_tss_get_tss
doc: "Get TSS gene annotation from Ensembl BioMart.\n\nTool homepage: https://github.com/aertslab/pycisTopic"
inputs:
  - id: tss_annotation_bed_filename
    type: string
    doc: "BED output file with selected Ensembl BioMart TSS annotation and with optionally remapped chromosome names."
    inputBinding:
      position: 1
      prefix: -o
  - id: biomart_name
    type: string
    doc: "Ensembl BioMart gene annotation name of the dataset, e.g. hsapiens_gene_ensembl."
    inputBinding:
      position: 1
      prefix: -n
  - id: transcript_type
    type:
      - 'null'
      - string
    doc: "Only keep comma separated list of specified transcript types, or all. Default: protein_coding."
    inputBinding:
      position: 1
      prefix: -t
  - id: biomart_host
    type:
      - 'null'
      - string
    doc: "BioMart host URL to use. Default: http://www.ensembl.org."
    inputBinding:
      position: 1
      prefix: -s
  - id: no_cache
    type:
      - 'null'
      - boolean
    doc: Disable caching of requests to Ensembl BioMart server.
    inputBinding:
      position: 1
      prefix: --no-cache
  - id: to_chrom_source
    type:
      - 'null'
      - string
    doc: "Chromosome source name to which the Ensembl chromosome names should be mapped: ucsc, refseq or genbank."
    inputBinding:
      position: 1
      prefix: --to-chrom-source
  - id: chrom_sizes_alias
    type:
      - 'null'
      - string
    doc: "Read/write chromosome sizes and alias TSV file used to map Ensembl chromosome names. Written when --ncbi or --ucsc is given."
    inputBinding:
      position: 1
      prefix: --chrom-sizes-alias
  - id: ncbi
    type:
      - 'null'
      - string
    doc: "NCBI genome accession ID used to build the chromosome sizes and alias mapping, e.g. GCF_000001405.40."
    inputBinding:
      position: 1
      prefix: --ncbi
  - id: ucsc
    type:
      - 'null'
      - string
    doc: "UCSC genome assembly used to build the chromosome sizes and alias mapping, e.g. hg38."
    inputBinding:
      position: 1
      prefix: --ucsc
outputs:
  - id: tss_annotation_bed
    type: File
    doc: "TSS annotation BED file."
    outputBinding:
      glob: $(inputs.tss_annotation_bed_filename)
  - id: chrom_sizes_alias_tsv
    type:
      - 'null'
      - File
    doc: "Chromosome sizes and alias TSV file."
    outputBinding:
      glob: $(inputs.chrom_sizes_alias)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycistopic:2.0a--pyhdfd78af_0
