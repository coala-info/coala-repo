cwlVersion: v1.2
class: CommandLineTool
baseCommand: qualimap comp-counts
label: qualimap_comp-counts
doc: "QualiMap v.2.3\n\nTool homepage: http://qualimap.bioinfo.cipf.es/"
inputs:
  - id: bam_file
    type: File
    doc: Mapping file in BAM format
    inputBinding:
      position: 101
      prefix: --bam
  - id: counting_algorithm
    type:
      - 'null'
      - string
    doc: 'Counting algorithm: uniquely-mapped-reads(default) or proportional'
    default: uniquely-mapped-reads
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: feature_id_attribute
    type:
      - 'null'
      - string
    doc: 'GTF-specific. Attribute of the GTF to be used as feature ID. Regions with
      the same ID will be aggregated as part of the same feature. Default: gene_id.'
    default: gene_id
    inputBinding:
      position: 101
      prefix: --id
  - id: gtf_type
    type:
      - 'null'
      - string
    doc: 'GTF-specific. Value of the third column of the GTF considered for counting.
      Other types will be ignored. Default: exon'
    default: exon
    inputBinding:
      position: 101
      prefix: --type
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: Setting this flag for paired-end experiments will result in counting 
      fragments instead of reads
    inputBinding:
      position: 101
      prefix: --paired
  - id: region_file
    type: File
    doc: Region file in GTF, GFF or BED format. If GTF format is provided, 
      counting is based on attributes, otherwise based on feature name
    inputBinding:
      position: 101
      prefix: --gtf
  - id: sequencing_protocol
    type:
      - 'null'
      - string
    doc: 'Sequencing library protocol: strand-specific-forward, strand-specific-reverse
      or non-strand-specific (default)'
    default: non-strand-specific
    inputBinding:
      position: 101
      prefix: --sequencing-protocol
  - id: sorted_input
    type:
      - 'null'
      - boolean
    doc: This flag indicates that the input file is already sorted by name. If 
      not set, additional sorting by name will be performed. Only required for 
      paired-end analysis.
    inputBinding:
      position: 101
      prefix: --sorted
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file of coverage report.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qualimap:2.3--hdfd78af_0
