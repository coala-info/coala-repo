cwlVersion: v1.2
class: CommandLineTool
baseCommand: annotate
label: mimodd_annotate
doc: "Annotates a VCF file using a specified SnpEff genome annotation.\n\nTool homepage:
  http://sourceforge.net/projects/mimodd"
inputs:
  - id: input_file
    type: File
    doc: a vcf input file
    inputBinding:
      position: 1
  - id: annotation_source
    type: string
    doc: the name of an installed SnpEff genome annotation file (the 
      snpeff-genomes tool can be used to get a list of all such names)
    inputBinding:
      position: 2
  - id: codon_tables
    type:
      - 'null'
      - type: array
        items: string
    doc: 'specify custom codon tables to be used in assessing variant effects at the
      protein level; if a codon table should be used for only a specific chromosome,
      use the format CHROM:TABLE_NAME. Use TABLE_NAME alone to specify a codon table
      to be used for all chromosomes, for which no chromosome-specific table is provided.
      Valid TABLE_NAMEs are those defined in the Codon tables section of the SnpEff
      config file. NOTE: It is also possible to associate chromosomes with a codon
      table permanently by editing the SnpEff config file.'
    inputBinding:
      position: 103
      prefix: --codon-tables
  - id: config_path
    type:
      - 'null'
      - Directory
    doc: location of the SnpEff installation directory. Will override MiModD 
      SNPEFF_PATH config setting if provided.
    inputBinding:
      position: 103
      prefix: --config
  - id: memory
    type:
      - 'null'
      - int
    doc: maximal memory to use in GB (overrides config setting)
    inputBinding:
      position: 103
      prefix: --memory
  - id: no_downstream
    type:
      - 'null'
      - boolean
    doc: do not include downstream effects in the output
    inputBinding:
      position: 103
      prefix: --no-downstream
  - id: no_intergenic
    type:
      - 'null'
      - boolean
    doc: do not include intergenic effects in the output
    inputBinding:
      position: 103
      prefix: --no-intergenic
  - id: no_intron
    type:
      - 'null'
      - boolean
    doc: do not include intron effects in the output
    inputBinding:
      position: 103
      prefix: --no-intron
  - id: no_upstream
    type:
      - 'null'
      - boolean
    doc: do not include upstream effects in the output
    inputBinding:
      position: 103
      prefix: --no-upstream
  - id: no_utr
    type:
      - 'null'
      - boolean
    doc: do not include UTR effects in the output
    inputBinding:
      position: 103
      prefix: --no-utr
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress original messages from SnpEff
    inputBinding:
      position: 103
      prefix: --quiet
  - id: upstream_downstream_distance
    type:
      - 'null'
      - int
    doc: specify the upstream/downstream interval length, i.e., variants more 
      than DISTANCE nts from the next annotated gene are considered to be 
      intergenic
    inputBinding:
      position: 103
      prefix: --ud
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output (independent of SnpEff)
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect the output to the specified file
    outputBinding:
      glob: $(inputs.output_file)
  - id: summary_file
    type:
      - 'null'
      - File
    doc: generate a results summary file of the specified name
    outputBinding:
      glob: $(inputs.summary_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
