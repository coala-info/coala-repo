cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pycistopic
  - tss
  - get_ucsc_chrom_sizes_and_alias_mapping
label: pycistopic_tss_get_ucsc_chrom_sizes_and_alias_mapping
doc: "Get chromosome sizes and alias mapping from UCSC.\n\nTool homepage: https://github.com/aertslab/pycisTopic"
inputs:
  - id: ucsc
    type:
      - 'null'
      - string
    doc: "UCSC genome assembly for which to retrieve chromosome sizes and alias mapping, e.g. hg38."
    inputBinding:
      position: 1
      prefix: --ucsc
  - id: chrom_sizes_alias
    type: string
    doc: "Write chromosome sizes and alias TSV file with chromosome sizes and alias mapping."
    inputBinding:
      position: 1
      prefix: --chrom-sizes-alias
outputs:
  - id: chrom_sizes_alias_tsv
    type: File
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
