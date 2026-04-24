cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbl2asn
label: tbl2asn-forever_tbl2asn
doc: "tbl2asn 25.7\n\nTool homepage: https://www.ncbi.nlm.nih.gov/genbank/tbl2asn2"
inputs:
  - id: accession
    type:
      - 'null'
      - string
    doc: Accession
    inputBinding:
      position: 101
      prefix: -A
  - id: add_evidence_linkage_type
    type:
      - 'null'
      - string
    doc: 'Add type of evidence used to assert linkage across assembly gaps (only for
      TSA records). Must be one of the following: paired-ends, align-genus, align-xgenus,
      align-trnscpt, within-clone, clone-contig, map, strobe'
    inputBinding:
      position: 101
      prefix: -l
  - id: alignment_gap_flags
    type:
      - 'null'
      - string
    doc: Alignment Gap Flags (comma separated fields, e.g., p,-,-,-,?,. )
    inputBinding:
      position: 101
      prefix: -G
  - id: cds_flags
    type:
      - 'null'
      - string
    doc: CDS Flags (combine any of the following letters)
    inputBinding:
      position: 101
      prefix: -k
  - id: cleanup
    type:
      - 'null'
      - string
    doc: Cleanup (combine any of the following letters)
    inputBinding:
      position: 101
      prefix: -c
  - id: comment
    type:
      - 'null'
      - string
    doc: Comment
    inputBinding:
      position: 101
      prefix: -y
  - id: comment_file
    type:
      - 'null'
      - File
    doc: Comment File
    inputBinding:
      position: 101
      prefix: -Y
  - id: delayed_genomic_product_set
    type:
      - 'null'
      - boolean
    doc: Delayed Genomic Product Set
    inputBinding:
      position: 101
      prefix: -J
  - id: descriptors_file
    type:
      - 'null'
      - File
    doc: Descriptors File
    inputBinding:
      position: 101
      prefix: -D
  - id: extra_flags
    type:
      - 'null'
      - string
    doc: Extra Flags (combine any of the following letters)
    inputBinding:
      position: 101
      prefix: -X
  - id: feature_id_links
    type:
      - 'null'
      - string
    doc: Feature ID Links
    inputBinding:
      position: 101
      prefix: -F
  - id: file_type
    type:
      - 'null'
      - string
    doc: File Type
    inputBinding:
      position: 101
      prefix: -a
  - id: force_local_protein_id_transcript_id
    type:
      - 'null'
      - boolean
    doc: Force Local protein_id/transcript_id
    inputBinding:
      position: 101
      prefix: -L
  - id: general_id_to_note
    type:
      - 'null'
      - boolean
    doc: General ID to Note
    inputBinding:
      position: 101
      prefix: -h
  - id: generate_genbank_file
    type:
      - 'null'
      - boolean
    doc: 'Generate GenBank File (obsolete: use -V b)'
    inputBinding:
      position: 101
      prefix: -b
  - id: genome_center_tag
    type:
      - 'null'
      - string
    doc: Genome Center Tag
    inputBinding:
      position: 101
      prefix: -C
  - id: genomic_product_set
    type:
      - 'null'
      - boolean
    doc: Genomic Product Set
    inputBinding:
      position: 101
      prefix: -g
  - id: genprodset_to_nucprotset
    type:
      - 'null'
      - boolean
    doc: GenProdSet to NucProtSet
    inputBinding:
      position: 101
      prefix: -u
  - id: hold_until_publish
    type:
      - 'null'
      - string
    doc: Hold Until Publish
    inputBinding:
      position: 101
      prefix: -H
  - id: lineage_for_discrepancy_report
    type:
      - 'null'
      - string
    doc: Lineage to use for Discrepancy Report tests
    inputBinding:
      position: 101
      prefix: -m
  - id: log_progress
    type:
      - 'null'
      - boolean
    doc: Log Progress
    inputBinding:
      position: 101
      prefix: -W
  - id: master_genome_flags
    type:
      - 'null'
      - string
    doc: Master Genome Flags
    inputBinding:
      position: 101
      prefix: -M
  - id: mrna_title_policy
    type:
      - 'null'
      - string
    doc: mRNA Title Policy
    inputBinding:
      position: 101
      prefix: -Q
  - id: organism_name
    type:
      - 'null'
      - string
    doc: Organism Name
    inputBinding:
      position: 101
      prefix: -n
  - id: path_for_results
    type:
      - 'null'
      - string
    doc: Path for Results
    inputBinding:
      position: 101
      prefix: -r
  - id: path_to_files
    type:
      - 'null'
      - string
    doc: Path to Files
    inputBinding:
      position: 101
      prefix: -p
  - id: project_version_number
    type:
      - 'null'
      - int
    doc: Project Version Number
    inputBinding:
      position: 101
      prefix: -N
  - id: read_fastas_as_set
    type:
      - 'null'
      - boolean
    doc: Read FASTAs as Set
    inputBinding:
      position: 101
      prefix: -s
  - id: recurse
    type:
      - 'null'
      - boolean
    doc: Recurse
    inputBinding:
      position: 101
      prefix: -E
  - id: remote_publication_lookup
    type:
      - 'null'
      - boolean
    doc: Remote Publication Lookup
    inputBinding:
      position: 101
      prefix: -P
  - id: remote_sequence_record_fetching
    type:
      - 'null'
      - boolean
    doc: Remote Sequence Record Fetching from ID
    inputBinding:
      position: 101
      prefix: -R
  - id: remote_taxonomy_lookup
    type:
      - 'null'
      - boolean
    doc: Remote Taxonomy Lookup
    inputBinding:
      position: 101
      prefix: -T
  - id: remove_unnecessary_gene_xref
    type:
      - 'null'
      - boolean
    doc: Remove Unnecessary Gene Xref
    inputBinding:
      position: 101
      prefix: -U
  - id: save_bioseq_set
    type:
      - 'null'
      - boolean
    doc: Save Bioseq-set
    inputBinding:
      position: 101
      prefix: -K
  - id: seq_id_from_file_name
    type:
      - 'null'
      - boolean
    doc: Seq ID from File Name
    inputBinding:
      position: 101
      prefix: -q
  - id: single_input_file
    type:
      - 'null'
      - File
    doc: Single Input File
    inputBinding:
      position: 101
      prefix: -i
  - id: single_structured_comment_file
    type:
      - 'null'
      - File
    doc: Single Structured Comment File (overrides the use of -X C)
    inputBinding:
      position: 101
      prefix: -w
  - id: single_table_file
    type:
      - 'null'
      - File
    doc: Single Table File
    inputBinding:
      position: 101
      prefix: -f
  - id: smart_feature_annotation
    type:
      - 'null'
      - boolean
    doc: Smart Feature Annotation
    inputBinding:
      position: 101
      prefix: -S
  - id: source_qualifiers
    type:
      - 'null'
      - string
    doc: Source Qualifiers
    inputBinding:
      position: 101
      prefix: -j
  - id: suffix
    type:
      - 'null'
      - string
    doc: Suffix
    inputBinding:
      position: 101
      prefix: -x
  - id: template_file
    type:
      - 'null'
      - File
    doc: Template File
    inputBinding:
      position: 101
      prefix: -t
  - id: validate
    type:
      - 'null'
      - boolean
    doc: 'Validate (obsolete: use -V v)'
    inputBinding:
      position: 101
      prefix: -v
  - id: verification
    type:
      - 'null'
      - string
    doc: Verification (combine any of the following letters)
    inputBinding:
      position: 101
      prefix: -V
outputs:
  - id: single_output_file
    type:
      - 'null'
      - File
    doc: Single Output File
    outputBinding:
      glob: $(inputs.single_output_file)
  - id: discrepancy_report_output_file
    type:
      - 'null'
      - File
    doc: Discrepancy Report Output File
    outputBinding:
      glob: $(inputs.discrepancy_report_output_file)
  - id: cleanup_log_file
    type:
      - 'null'
      - File
    doc: Cleanup Log File
    outputBinding:
      glob: $(inputs.cleanup_log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbl2asn-forever:25.7.1f--0
