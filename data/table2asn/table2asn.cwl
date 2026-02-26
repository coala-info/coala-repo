cwlVersion: v1.2
class: CommandLineTool
baseCommand: table2asn
label: table2asn
doc: "Converts files of various formats to ASN.1\n\nTool homepage: https://www.ncbi.nlm.nih.gov/genbank/table2asn/"
inputs:
  - id: accession
    type:
      - 'null'
      - string
    doc: Accession
    inputBinding:
      position: 101
      prefix: -A
  - id: accum_mods
    type:
      - 'null'
      - boolean
    doc: Accumulate non-conflicting modifier values from different sources.
    inputBinding:
      position: 101
      prefix: -accum-mods
  - id: allow_acc
    type:
      - 'null'
      - boolean
    doc: Allow accession recognition in sequence IDs. Default is local
    inputBinding:
      position: 101
      prefix: -allow-acc
  - id: aln_alphabet
    type:
      - 'null'
      - string
    doc: Alignment alphabet
    default: prot
    inputBinding:
      position: 101
      prefix: -aln-alphabet
  - id: aln_file
    type:
      - 'null'
      - File
    doc: Alignment input file
    inputBinding:
      position: 101
      prefix: -aln-file
  - id: aln_gapchar
    type:
      - 'null'
      - string
    doc: Alignment missing indicator
    default: '-'
    inputBinding:
      position: 101
      prefix: -aln-gapchar
  - id: aln_missing
    type:
      - 'null'
      - string
    doc: Alignment missing indicator
    default: ''
    inputBinding:
      position: 101
      prefix: -aln-missing
  - id: annotations_file
    type:
      - 'null'
      - File
    doc: Single 5 column table file or other annotations
    inputBinding:
      position: 101
      prefix: -f
  - id: binary
    type:
      - 'null'
      - boolean
    doc: Output binary ASN.1
    inputBinding:
      position: 101
      prefix: -binary
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
  - id: conffile
    type:
      - 'null'
      - File
    doc: Program's configuration (registry) data file
    default: table2asn.conf
    inputBinding:
      position: 101
      prefix: -conffile
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
  - id: disable_huge
    type:
      - 'null'
      - boolean
    doc: Explicitly disable huge-files mode
    inputBinding:
      position: 101
      prefix: -disable-huge
  - id: discrepancy_report_lineage
    type:
      - 'null'
      - string
    doc: Lineage to use for Discrepancy Report tests
    inputBinding:
      position: 101
      prefix: -m
  - id: euk
    type:
      - 'null'
      - boolean
    doc: Assume eukaryote, and create missing mRNA features
    inputBinding:
      position: 101
      prefix: -euk
  - id: fetchall
    type:
      - 'null'
      - boolean
    doc: Search data in all available databases
    inputBinding:
      position: 101
      prefix: -fetchall
  - id: file_type
    type:
      - 'null'
      - string
    doc: File Type
    default: a
    inputBinding:
      position: 101
      prefix: -a
  - id: ft_url
    type:
      - 'null'
      - string
    doc: FileTrack URL for the XML file retrieval
    inputBinding:
      position: 101
      prefix: -ft-url
  - id: ft_url_mod
    type:
      - 'null'
      - string
    doc: FileTrack URL for the XML file base modifications
    inputBinding:
      position: 101
      prefix: -ft-url-mod
  - id: gap_type
    type:
      - 'null'
      - string
    doc: 'Set gap type for runs of Ns. Must be one of the following: scaffold, short-arm,
      heterochromatin, centromere, telomere, repeat, contamination, contig, unknown
      (obsolete), fragment, clone, other (for future use)'
    inputBinding:
      position: 101
      prefix: -gap-type
  - id: gaps_min
    type:
      - 'null'
      - int
    doc: minimum run of Ns recognised as a gap
    inputBinding:
      position: 101
      prefix: -gaps-min
  - id: gaps_unknown
    type:
      - 'null'
      - int
    doc: exact number of Ns recognised as a gap with unknown length
    inputBinding:
      position: 101
      prefix: -gaps-unknown
  - id: gb_cdd
    type:
      - 'null'
      - boolean
    doc: Genbank SNP processor
    inputBinding:
      position: 101
      prefix: -gb-cdd
  - id: gb_method
    type:
      - 'null'
      - string
    doc: Semicolon-separated list of Genbank loader method(s)
    inputBinding:
      position: 101
      prefix: -gb-method
  - id: gb_snp
    type:
      - 'null'
      - boolean
    doc: Genbank SNP processor
    inputBinding:
      position: 101
      prefix: -gb-snp
  - id: gb_wgs
    type:
      - 'null'
      - boolean
    doc: Genbank WGS processor
    inputBinding:
      position: 101
      prefix: -gb-wgs
  - id: genbank
    type:
      - 'null'
      - boolean
    doc: Enable remote data retrieval using the Genbank data loader
    inputBinding:
      position: 101
      prefix: -genbank
  - id: genome_center_tag
    type:
      - 'null'
      - string
    doc: Genome Center Tag
    inputBinding:
      position: 101
      prefix: -C
  - id: hold_until_publish
    type:
      - 'null'
      - string
    doc: Hold Until Publish
    inputBinding:
      position: 101
      prefix: -H
  - id: huge
    type:
      - 'null'
      - boolean
    doc: Execute in huge-file mode
    inputBinding:
      position: 101
      prefix: -huge
  - id: indir
    type:
      - 'null'
      - Directory
    doc: Path to input files
    inputBinding:
      position: 101
      prefix: -indir
  - id: input_file
    type:
      - 'null'
      - File
    doc: Single Input File
    inputBinding:
      position: 101
      prefix: -i
  - id: intronless
    type:
      - 'null'
      - boolean
    doc: Intronless alignments
    inputBinding:
      position: 101
      prefix: -intronless
  - id: linkage_evidence
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Add type of evidence used to assert linkage across assembly gaps. May be
      used multiple times. Must be one of the following: paired-ends, align-genus,
      align-xgenus, align-trnscpt, within-clone, clone-contig, map, strobe, unspecified,
      pcr, proximity-ligation'
    inputBinding:
      position: 101
      prefix: -l
  - id: linkage_evidence_file
    type:
      - 'null'
      - File
    doc: File listing linkage evidence for gaps of different lengths
    inputBinding:
      position: 101
      prefix: -linkage-evidence-file
  - id: locus_tag_prefix
    type:
      - 'null'
      - string
    doc: Add prefix to locus tags in annotation files
    inputBinding:
      position: 101
      prefix: -locus-tag-prefix
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
  - id: no_locus_tags_needed
    type:
      - 'null'
      - boolean
    doc: Submission data does not require locus tags
    inputBinding:
      position: 101
      prefix: -no-locus-tags-needed
  - id: novdb
    type:
      - 'null'
      - boolean
    doc: Do not use VDB data loader.
    inputBinding:
      position: 101
      prefix: -novdb
  - id: out_suffix
    type:
      - 'null'
      - string
    doc: ASN.1 files suffix
    default: .sqn
    inputBinding:
      position: 101
      prefix: -out-suffix
  - id: output_discrepancy_report
    type:
      - 'null'
      - boolean
    doc: Output discrepancy report
    inputBinding:
      position: 101
      prefix: -Z
  - id: postprocess_pubs
    type:
      - 'null'
      - boolean
    doc: 'Postprocess pubs: convert authors to standard'
    inputBinding:
      position: 101
      prefix: -postprocess-pubs
  - id: project_version_number
    type:
      - 'null'
      - string
    doc: Project Version Number
    inputBinding:
      position: 101
      prefix: -N
  - id: prt_alignment_filter_query
    type:
      - 'null'
      - string
    doc: Filter query string for .prt alignments
    inputBinding:
      position: 101
      prefix: -prt-alignment-filter-query
  - id: recurse
    type:
      - 'null'
      - boolean
    doc: Recurse
    inputBinding:
      position: 101
      prefix: -E
  - id: refine_prt_alignments
    type:
      - 'null'
      - boolean
    doc: Refine ProSplign aligments when processing .prt input
    inputBinding:
      position: 101
      prefix: -refine-prt-alignments
  - id: remote_data_retrieval
    type:
      - 'null'
      - boolean
    doc: Enable remote data retrieval
    inputBinding:
      position: 101
      prefix: -r
  - id: remote_publication_lookup
    type:
      - 'null'
      - boolean
    doc: Remote Publication Lookup
    inputBinding:
      position: 101
      prefix: -P
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
  - id: source_qualifiers
    type:
      - 'null'
      - string
    doc: Source Qualifiers.
    inputBinding:
      position: 101
      prefix: -j
  - id: split_dr
    type:
      - 'null'
      - boolean
    doc: Create unique discrepancy report for each output file
    inputBinding:
      position: 101
      prefix: -split-dr
  - id: split_logs
    type:
      - 'null'
      - boolean
    doc: Create unique log file for each output file
    inputBinding:
      position: 101
      prefix: -split-logs
  - id: sra
    type:
      - 'null'
      - boolean
    doc: Add the SRA data loader with no options.
    inputBinding:
      position: 101
      prefix: -sra
  - id: sra_acc
    type:
      - 'null'
      - string
    doc: Add the SRA data loader, specifying an accession.
    inputBinding:
      position: 101
      prefix: -sra-acc
  - id: sra_file
    type:
      - 'null'
      - string
    doc: Add the SRA data loader, specifying an sra file.
    inputBinding:
      position: 101
      prefix: -sra-file
  - id: src_file
    type:
      - 'null'
      - File
    doc: Single source qualifiers file.
    inputBinding:
      position: 101
      prefix: -src-file
  - id: structured_comment_file
    type:
      - 'null'
      - File
    doc: Single Structured Comment File
    inputBinding:
      position: 101
      prefix: -w
  - id: suffix
    type:
      - 'null'
      - string
    doc: Suffix
    default: .fsa
    inputBinding:
      position: 101
      prefix: -x
  - id: suspect_rules
    type:
      - 'null'
      - string
    doc: Path to a file containing suspect rules set. Overrides environment 
      variable PRODUCT_RULES_LIST
    inputBinding:
      position: 101
      prefix: -suspect-rules
  - id: template_file
    type:
      - 'null'
      - File
    doc: Template File
    inputBinding:
      position: 101
      prefix: -t
  - id: usemt
    type:
      - 'null'
      - string
    doc: 'Try to use as many threads as: one, two, many'
    inputBinding:
      position: 101
      prefix: -usemt
  - id: vdb
    type:
      - 'null'
      - boolean
    doc: Use VDB data loader.
    inputBinding:
      position: 101
      prefix: -vdb
  - id: vdb_path
    type:
      - 'null'
      - string
    doc: Root path for VDB look-up
    inputBinding:
      position: 101
      prefix: -vdb-path
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose on reporting
    inputBinding:
      position: 101
      prefix: -verbose
  - id: verification
    type:
      - 'null'
      - string
    doc: Verification (combine any of the following letters)
    inputBinding:
      position: 101
      prefix: -V
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Path to results
    outputBinding:
      glob: $(inputs.outdir)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Single Output File
    outputBinding:
      glob: $(inputs.output_file)
  - id: cleanup_log_file
    type:
      - 'null'
      - File
    doc: Cleanup Log File
    outputBinding:
      glob: $(inputs.cleanup_log_file)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Error Log File
    outputBinding:
      glob: $(inputs.logfile)
  - id: logxml
    type:
      - 'null'
      - File
    doc: XML Error Log File
    outputBinding:
      glob: $(inputs.logxml)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/table2asn:1.28.1179--he45da00_1
