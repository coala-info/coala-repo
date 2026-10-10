cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mmseqs
  - createdb
label: mmseqs2_createdb
doc: 'Convert FASTA or FASTQ files into an MMseqs2 sequence database (a set of files sharing
  one prefix).


  By Martin Steinegger <martin.steinegger@snu.ac.kr>


  Tool homepage: https://github.com/soedinglab/mmseqs2'
inputs:
  - id: input_fasta
    type:
      type: array
      items: File
    doc: Input FASTA or FASTQ files (optionally gzip or bzip2)
    inputBinding:
      position: 1
  - id: output_db_name
    type: string
    doc: Name (prefix) of the output database, written inside the output directory
    inputBinding:
      position: 2
      valueFrom: out_db/$(self)
  - id: mask
    type:
      - 'null'
      - int
    doc: 'Mask sequences in prefilter stage with tantan: 0: w/o low complexity masking, 1:
      with low complexity masking'
    inputBinding:
      position: 104
      prefix: --mask
  - id: mask_prob
    type:
      - 'null'
      - float
    doc: Mask sequences is probablity is above threshold
    inputBinding:
      position: 104
      prefix: --mask-prob
  - id: mask_lower_case
    type:
      - 'null'
      - int
    doc: 'Lowercase letters will be excluded from k-mer search 0: include region, 1: exclude
      region'
    inputBinding:
      position: 104
      prefix: --mask-lower-case
  - id: mask_n_repeat
    type:
      - 'null'
      - int
    doc: Repeat letters that occure > threshold in a rwo
    inputBinding:
      position: 104
      prefix: --mask-n-repeat
  - id: dbtype
    type:
      - 'null'
      - int
    doc: 'Database type 0: auto, 1: amino acid 2: nucleotides'
    inputBinding:
      position: 104
      prefix: --dbtype
  - id: shuffle
    type:
      - 'null'
      - int
    doc: Shuffle input database (0 or 1)
    inputBinding:
      position: 104
      prefix: --shuffle
  - id: createdb_mode
    type:
      - 'null'
      - int
    doc: 'Createdb mode 0: copy data, 1: soft link data and write new index (works only with
      single line fasta/q) 2: GPU compatible db'
    inputBinding:
      position: 104
      prefix: --createdb-mode
  - id: id_offset
    type:
      - 'null'
      - int
    doc: Numeric ids in index file are offset by this value
    inputBinding:
      position: 104
      prefix: --id-offset
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: compressed
    type:
      - 'null'
      - int
    doc: Write compressed output
    inputBinding:
      position: 104
      prefix: --compressed
  - id: gpu
    type:
      - 'null'
      - int
    doc: Use GPU (CUDA) if possible
    inputBinding:
      position: 104
      prefix: --gpu
  - id: v
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
  - id: write_lookup
    type:
      - 'null'
      - int
    doc: write .lookup file containing mapping from internal id, fasta id and file number
    inputBinding:
      position: 104
      prefix: --write-lookup
outputs:
  - id: output_db
    type: Directory
    doc: Directory holding the new database files
    outputBinding:
      glob: out_db
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: out_db
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0
