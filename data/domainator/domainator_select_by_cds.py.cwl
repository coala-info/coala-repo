cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainator_select_by_cds.py
label: domainator_select_by_cds.py
doc: "Extract contigs regions around selected CDSs\n\nTakes a domain-annotated genbank
  file and extracts regions of contigs based on contig or CDS name or presence of
  specified domains within individual CDSs.\n\nSpecify a range to extract around selected
  CDSs, if no range is specified, then only the selected CDSs will be returned and
  not any of their neighbors.\n\nif target_cdss, target_domains or domain_expr is
  specified then selection logic is:\n\n    contigs & (target_cdss or target_domains
  or domain_expr or unannotated)\n\notherwise:\n    return every cds in contigs\n\n\
  Tool homepage: https://github.com/nebiolabs/domainator"
inputs:
  - id: cds
    type:
      - 'null'
      - type: array
        items: string
    doc: Include CDSs with these names (additive with --domains)
    inputBinding:
      position: 101
      prefix: --cds
  - id: cds_down
    type:
      - 'null'
      - int
    doc: How many CDSs downstream of the selected CDS to extract. Example, 1 
      would mean to return contigs including the selected CDSs and the immediate
      downstream CDS.
    inputBinding:
      position: 101
      prefix: --cds_down
  - id: cds_file
    type:
      - 'null'
      - File
    doc: text file containing names of CDSs to include.
    inputBinding:
      position: 101
      prefix: --cds_file
  - id: cds_range
    type:
      - 'null'
      - int
    doc: How many CDSs upstream and downstream of the selected CDS to extract. 
      Example, 1 would mean to return contigs including the selected CDSs and 
      the immediate upstream and downstream CDSs.
    inputBinding:
      position: 101
      prefix: --cds_range
  - id: cds_up
    type:
      - 'null'
      - int
    doc: How many CDSs upstream of the selected CDS to extract. Example, 1 would
      mean to return contigs including the selected CDSs and the immediate 
      upstream CDS.
    inputBinding:
      position: 101
      prefix: --cds_up
  - id: config
    type:
      - 'null'
      - File
    doc: Path to a configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: contigs
    type:
      - 'null'
      - type: array
        items: string
    doc: Only extract regions from contigs with these names.
    inputBinding:
      position: 101
      prefix: --contigs
  - id: contigs_file
    type:
      - 'null'
      - File
    doc: text file containing names of contigs to extract from.
    inputBinding:
      position: 101
      prefix: --contigs_file
  - id: databases
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Consider only domains from these databases when filtering by domain. default:
      all databases.'
    inputBinding:
      position: 101
      prefix: --databases
  - id: domain_expr
    type:
      - 'null'
      - string
    doc: a boolean expression using operators & (AND), | (OR), and ~(NOT), to 
      specify a desired combination of domains
    inputBinding:
      position: 101
      prefix: --domain_expr
  - id: domains
    type:
      - 'null'
      - type: array
        items: string
    doc: Include domains with these names
    inputBinding:
      position: 101
      prefix: --domains
  - id: domains_file
    type:
      - 'null'
      - File
    doc: text file containing names of domains to include.
    inputBinding:
      position: 101
      prefix: --domains_file
  - id: evalue
    type:
      - 'null'
      - float
    doc: the evalue cutoff for domain annotations to be put onto the new genbank
      file
    inputBinding:
      position: 101
      prefix: --evalue
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: names of input genbank files. If not supplied, reads from stdin.
    inputBinding:
      position: 101
      prefix: --input
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Invert the CDS selection criteria. i.e. return CDSs that don't match 
      the CDS selection criteria. (only applies to CDS selection, not 
      neighborhoods or contigs).
    inputBinding:
      position: 101
      prefix: --invert
  - id: kb_down
    type:
      - 'null'
      - float
    doc: How many kb downstream of the selected CDS to extract. Starting from 
      the end of the CDS.
    inputBinding:
      position: 101
      prefix: --kb_down
  - id: kb_range
    type:
      - 'null'
      - float
    doc: How many kb upstream and downstream of the selected CDS to extract. 
      Starting from the ends of the CDS.
    inputBinding:
      position: 101
      prefix: --kb_range
  - id: kb_up
    type:
      - 'null'
      - float
    doc: How many kb upstream of the selected CDS to extract. Starting from the 
      end of the CDS.
    inputBinding:
      position: 101
      prefix: --kb_up
  - id: keep_direction
    type:
      - 'null'
      - boolean
    doc: by default extracted regions will be flipped so that the focus cds is 
      on the forward strand. Setting this option will keep the focus cds on 
      whatever strand it started on.
    inputBinding:
      position: 101
      prefix: --keep_direction
  - id: max_region_overlap
    type:
      - 'null'
      - float
    doc: the maximum fractional of overlap between any two output regions. If >=
      1, then no overlap filtering will be done. Regions are output in a greedy 
      fashion based on CDS start site. New regions are output if less than this 
      fraction of them overlaps with any previously output region.
    inputBinding:
      position: 101
      prefix: --max_region_overlap
  - id: pad
    type:
      - 'null'
      - boolean
    doc: If set, then ends of sequences will be padded so that the focus CDS 
      aligns.
    inputBinding:
      position: 101
      prefix: --pad
  - id: print_config
    type:
      - 'null'
      - string
    doc: 'Print the configuration after applying all other arguments and exit. The
      optional flags customizes the output and are one or more keywords separated
      by comma. The supported flags are: comments, skip_default, skip_null.'
    inputBinding:
      position: 101
      prefix: --print_config
  - id: search_hits
    type:
      - 'null'
      - boolean
    doc: Select CDSs that are marked as search hits (from domain_search.py).
    inputBinding:
      position: 101
      prefix: --search_hits
  - id: skip_deduplicate
    type:
      - 'null'
      - boolean
    doc: by default if the same region is extracted for multiple hits, then only
      one will be kept. Set this option to retain redundancies (which might be 
      useful if you are counting hits), but will result in duplicated contig 
      names, which could be a problem for downstream domainator applications.
    inputBinding:
      position: 101
      prefix: --skip_deduplicate
  - id: strand
    type:
      - 'null'
      - string
    doc: Only extract regions around CDSs on the specified strand.
    inputBinding:
      position: 101
      prefix: --strand
  - id: unannotated
    type:
      - 'null'
      - boolean
    doc: Select contigs with no domain annotations.
    inputBinding:
      position: 101
      prefix: --unannotated
  - id: whole_contig
    type:
      - 'null'
      - boolean
    doc: If set, then return the entire matching contigs.
    inputBinding:
      position: 101
      prefix: --whole_contig
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: genbank output file name. If not supplied, writes to stdout.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domainator:0.8.1--pyhdfd78af_0
