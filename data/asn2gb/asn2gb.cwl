cwlVersion: v1.2
class: CommandLineTool
baseCommand: asn2gb
label: asn2gb
doc: "Convert ASN.1 to GenBank/EMBL/GenPept flatfile formats\n\nTool homepage: https://www.ncbi.nlm.nih.gov/IEB/ToolBox/C_DOC/lxr/source/doc/asn2gb.txt"
inputs:
  - id: accession_to_fetch
    type:
      - 'null'
      - string
    doc: Accession to Fetch (or Accession,retcode,flags where flags -1 fetches external
      features)
    inputBinding:
      position: 101
      prefix: -A
  - id: asn1_type
    type:
      - 'null'
      - string
    doc: 'ASN.1 Type (Single Record: a Any, e Seq-entry, b Bioseq, s Bioseq-set, m
      Seq-submit, q Catenated; Release File: t Batch Bioseq-set, u Batch Seq-submit)'
    default: a
    inputBinding:
      position: 101
      prefix: -a
  - id: asn2flat_executable
    type:
      - 'null'
      - File
    doc: Asn2Flat Executable
    default: asn2flat
    inputBinding:
      position: 101
      prefix: -n
  - id: batch
    type:
      - 'null'
      - int
    doc: Batch (1 Report, 2 Sequin/Release, 3 asn2gb SSEC/nocleanup, 4 asn2flat BSEC/nocleanup,
      5 asn2gb/asn2flat, 6 asn2gb NEW dbxref/OLD dbxref, 7 oldasn2gb/newasn2gb)
    default: 0
    inputBinding:
      position: 101
      prefix: -t
  - id: batch_file_is_compressed
    type:
      - 'null'
      - boolean
    doc: Batch File is Compressed
    default: false
    inputBinding:
      position: 101
      prefix: -c
  - id: bit_flags
    type:
      - 'null'
      - int
    doc: Bit Flags (1 HTML, 2 XML, 4 ContigFeats, 8 ContigSrcs, 16 FarTransl)
    default: 0
    inputBinding:
      position: 101
      prefix: -g
  - id: custom_flags
    type:
      - 'null'
      - int
    doc: Custom Flags (4 HideFeats, 1792 HideRefs, 8192 HideSources, 262144 HideTranslation)
    default: 0
    inputBinding:
      position: 101
      prefix: -u
  - id: feature_item_id
    type:
      - 'null'
      - int
    doc: Feature itemID
    default: 0
    inputBinding:
      position: 101
      prefix: -y
  - id: ffdiff_executable
    type:
      - 'null'
      - File
    doc: Ffdiff Executable
    default: /netopt/genbank/subtool/bin/ffdiff
    inputBinding:
      position: 101
      prefix: -q
  - id: format
    type:
      - 'null'
      - string
    doc: Format (b GenBank, e EMBL, p GenPept, t Feature Table, x INSDSet)
    default: b
    inputBinding:
      position: 101
      prefix: -f
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input File Name
    default: stdin
    inputBinding:
      position: 101
      prefix: -i
  - id: input_is_binary
    type:
      - 'null'
      - boolean
    doc: Input File is Binary
    default: false
    inputBinding:
      position: 101
      prefix: -b
  - id: lock_lookup_flags
    type:
      - 'null'
      - int
    doc: Lock/Lookup Flags (8 LockProd, 16 LookupComp, 64 LookupProd)
    default: 0
    inputBinding:
      position: 101
      prefix: -h
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode (r Release, e Entrez, s Sequin, d Dump)
    default: s
    inputBinding:
      position: 101
      prefix: -m
  - id: propagate_top_descriptors
    type:
      - 'null'
      - boolean
    doc: Propagate Top Descriptors
    default: false
    inputBinding:
      position: 101
      prefix: -p
  - id: remote_annotation_fetch_test
    type:
      - 'null'
      - boolean
    doc: Remote Annotation Fetch Test (use -A Accession,0,-1 instead)
    default: false
    inputBinding:
      position: 101
      prefix: -F
  - id: remote_fetching
    type:
      - 'null'
      - boolean
    doc: Remote Fetching
    default: false
    inputBinding:
      position: 101
      prefix: -r
  - id: seqloc_from
    type:
      - 'null'
      - int
    doc: SeqLoc From
    default: 0
    inputBinding:
      position: 101
      prefix: -j
  - id: seqloc_minus_strand
    type:
      - 'null'
      - boolean
    doc: SeqLoc Minus Strand
    default: false
    inputBinding:
      position: 101
      prefix: -d
  - id: seqloc_to
    type:
      - 'null'
      - int
    doc: SeqLoc To
    default: 0
    inputBinding:
      position: 101
      prefix: -k
  - id: style
    type:
      - 'null'
      - string
    doc: Style (n Normal, s Segment, m Master, c Contig)
    default: n
    inputBinding:
      position: 101
      prefix: -s
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output File Name
    outputBinding:
      glob: $(inputs.output_file)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/asn2gb:18.2--0
