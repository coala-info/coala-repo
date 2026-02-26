cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - get_tx_seq
label: pygtftk_gtftk get_tx_seq
doc: "Get transcripts sequences in a flexible fasta format from a GTF file.\n\nTool
  homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: Add 'chr' to chromosome names before printing output.
    default: false
    inputBinding:
      position: 101
      prefix: --add-chr
  - id: assembly
    type:
      - 'null'
      - string
    doc: In case of --sleuth-format, an assembly version.
    default: GRCm38
    inputBinding:
      position: 101
      prefix: --assembly
  - id: del_chr
    type:
      - 'null'
      - boolean
    doc: When using --sleuth-format delete 'chr' in sequence id.
    default: false
    inputBinding:
      position: 101
      prefix: --del-chr
  - id: delete_version
    type:
      - 'null'
      - boolean
    doc: In case of --sleuth-format, delete gene_id or transcript_id version 
      number (e.g '.2' in ENSG56765.2).
    default: false
    inputBinding:
      position: 101
      prefix: --delete-version
  - id: explicit
    type:
      - 'null'
      - boolean
    doc: Write explicitly the name of the keys in the header.
    default: false
    inputBinding:
      position: 101
      prefix: --explicit
  - id: genome
    type:
      - 'null'
      - File
    doc: The genome in fasta format. Accept path with wildcards (e.g. *.fa).
    inputBinding:
      position: 101
      prefix: --genome
  - id: inputfile
    type:
      - 'null'
      - File
    doc: Path to the GTF file. Default to STDIN
    default: <stdin>
    inputBinding:
      position: 101
      prefix: --inputfile
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: Try to keep all temporary files even if process does not terminate 
      normally.
    default: false
    inputBinding:
      position: 101
      prefix: --keep-all
  - id: label
    type:
      - 'null'
      - string
    doc: A set of key for the header.
    default: feature,transcript_id,gene_id,seqid,start,end
    inputBinding:
      position: 101
      prefix: --label
  - id: logger_file
    type:
      - 'null'
      - File
    doc: Stores the arguments passed to the command into a file.
    default: None
    inputBinding:
      position: 101
      prefix: --logger-file
  - id: no_date
    type:
      - 'null'
      - boolean
    doc: Do not add date to output file names.
    default: false
    inputBinding:
      position: 101
      prefix: --no-date
  - id: no_rev_comp
    type:
      - 'null'
      - boolean
    doc: Don't reverse complement sequence corresponding to gene on minus 
      strand.
    default: false
    inputBinding:
      position: 101
      prefix: --no-rev-comp
  - id: separator
    type:
      - 'null'
      - string
    doc: To separate info in header.
    default: '|'
    inputBinding:
      position: 101
      prefix: --separator
  - id: sleuth_format
    type:
      - 'null'
      - boolean
    doc: Produce output in sleuth format (still experimental).
    default: false
    inputBinding:
      position: 101
      prefix: --sleuth-format
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Keep all temporary files into this folder.
    default: None
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set output verbosity ([0-3]).
    default: 0
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: with_introns
    type:
      - 'null'
      - boolean
    doc: Set to true to include intronic regions.
    default: false
    inputBinding:
      position: 101
      prefix: --with-introns
  - id: write_message_to_file
    type:
      - 'null'
      - File
    doc: Store all message into a file.
    default: None
    inputBinding:
      position: 101
      prefix: --write-message-to-file
outputs:
  - id: outputfile
    type:
      - 'null'
      - File
    doc: Output FASTA file.
    outputBinding:
      glob: $(inputs.outputfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
