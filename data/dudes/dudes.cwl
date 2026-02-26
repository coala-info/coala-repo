cwlVersion: v1.2
class: CommandLineTool
baseCommand: dudes
label: dudes
doc: "DUDes is a tool for taxonomic profiling of sequencing reads.\n\nTool homepage:
  https://github.com/pirovc/dudes"
inputs:
  - id: bin_size
    type:
      - 'null'
      - string
    doc: 'Bin size (0-1: percentile from the lengths of all references in the database
      / >=1: bp). Default: 0.25'
    default: 0.25
    inputBinding:
      position: 101
      prefix: -b
  - id: custom_blast_file
    type: File
    doc: "Alignment/mapping file in custom BLAST format. The required columns and
      their order are: 'qseqid', 'sseqid', 'slen', 'sstart', 'evalue'. Additional
      columns are ignored. Example command for creating appropriate file with diamond:
      'diamond blastp -q {query_fasta} -d {diamond_database} --outfmt 6 qseqid sseqid
      slen sstart evalue'"
    inputBinding:
      position: 101
      prefix: -c
  - id: database_file
    type: File
    doc: Database file (output from DUDesDB [.npz])
    inputBinding:
      position: 101
      prefix: -d
  - id: debug
    type:
      - 'null'
      - boolean
    doc: print debug info to STDERR
    inputBinding:
      position: 101
      prefix: --debug
  - id: debug_plots_dir
    type:
      - 'null'
      - Directory
    doc: path to directory for writing debug plots to.
    inputBinding:
      position: 101
      prefix: --debug_plots_dir
  - id: last_rank
    type:
      - 'null'
      - string
    doc: "Last considered rank [superkingdom,phylum,class,order, family,genus,species,strain].
      Default: 'species'"
    default: species
    inputBinding:
      position: 101
      prefix: -l
  - id: max_read_matches
    type:
      - 'null'
      - string
    doc: 'Keep reads up to this number/percentile of matches (0: off / 0-1: percentile
      / >=1: match count). Default: 0'
    default: 0
    inputBinding:
      position: 101
      prefix: -m
  - id: min_reference_matches
    type:
      - 'null'
      - string
    doc: 'Minimum number/percentage of supporting matches to consider the reference
      (0: off / 0-1: percentage / >=1: read number). Default: 0.001'
    default: 0.001
    inputBinding:
      position: 101
      prefix: -a
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: 'Output prefix. Default: STDOUT'
    default: STDOUT
    inputBinding:
      position: 101
      prefix: -o
  - id: sam_file
    type: File
    doc: Alignment/mapping file in SAM format. DUDes does not depend on any 
      specific read mapper, but it requires header information (@SQ 
      SN:gi|556555098|ref|NC_022650.1| LN:55956) and mismatch information (check
      -i)
    inputBinding:
      position: 101
      prefix: -s
  - id: sam_format
    type:
      - 'null'
      - string
    doc: "SAM file format, ignored for cumstom blast files ['nm': sam file with standard
      cigar string plus NM flag (NM:i:[0-9]*) for mismatches count | 'ex': just the
      extended cigar string]. Default: 'nm'"
    default: nm
    inputBinding:
      position: 101
      prefix: -i
  - id: taxid_start
    type:
      - 'null'
      - int
    doc: 'Taxonomic Id used to start the analysis (1 = root). Default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: -x
  - id: threads
    type:
      - 'null'
      - int
    doc: '# of threads. Default: 1'
    default: 1
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dudes:0.10.0--pyhdfd78af_0
stdout: dudes.out
