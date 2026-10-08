cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastK
label: fastk_FastK
doc: "FastK is a fast k-mer counter for high-quality DNA sequencing data. It reads CRAM, BAM, SAM, FASTA or FASTQ files and writes a histogram (.hist), optionally a sorted k-mer table (.ktab) and sequence count profiles (.prof).\n\nTool homepage: https://github.com/thegenemyers/FASTK"
inputs:
  - id: source
    type: File[]
    doc: 'Input sequence files (.cram, .bam, .sam, .db, .dam, .fasta, .fastq, optionally .gz).'
    inputBinding:
      position: 100
  - id: output_prefix
    type: string
    doc: 'Name of the output files without extension (FastK -N). The outputs are <name>.hist, <name>.ktab and <name>.prof.'
    inputBinding:
      position: 50
      prefix: '-N'
      separate: false
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'k-mer size. [default: 40]'
    inputBinding:
      position: 50
      prefix: '-k'
      separate: false
  - id: table
    type:
      - 'null'
      - boolean
    doc: 'Produce table of sorted k-mers and counts >= level 1.'
    inputBinding:
      position: 50
      prefix: '-t'
  - id: table_level
    type:
      - 'null'
      - int
    doc: 'Produce table of sorted k-mers and counts >= the level given.'
    inputBinding:
      position: 50
      prefix: '-t'
      separate: false
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Produce sequence count profiles (w.r.t. table if given).
    inputBinding:
      position: 50
      prefix: '-p'
  - id: profile_table
    type:
      - 'null'
      - string
    doc: Produce sequence count profiles with respect to the given table.
    inputBinding:
      position: 50
      prefix: '-p:'
      separate: false
  - id: barcode_length
    type:
      - 'null'
      - int
    doc: Ignore prefix of each read of given length (e.g. bar code).
    inputBinding:
      position: 50
      prefix: '-bc'
      separate: false
  - id: homopolymer_compress
    type:
      - 'null'
      - boolean
    doc: Homopolymer compress every sequence.
    inputBinding:
      position: 50
      prefix: '-c'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Verbose mode, output statistics as proceed.'
    inputBinding:
      position: 50
      prefix: '-v'
  - id: sort_dir
    type:
      - 'null'
      - string
    doc: 'Place block level sorts in directory -P. [default: $TMPDIR]'
    inputBinding:
      position: 50
      prefix: '-P'
      separate: false
  - id: memory_gb
    type:
      - 'null'
      - int
    doc: 'Use -M GB of memory in downstream sorting steps of KMcount. [default: 12]'
    inputBinding:
      position: 50
      prefix: '-M'
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Use -T threads. [default: 4]'
    inputBinding:
      position: 50
      prefix: '-T'
      separate: false
outputs:
  - id: hist
    type: File
    doc: Histogram of k-mer counts.
    outputBinding:
      glob: $(inputs.output_prefix).hist
  - id: stdout
    type: stdout
    doc: Standard output
  - id: ktab
    type:
      - 'null'
      - File
    doc: k-mer table stub file, written with the table options.
    outputBinding:
      glob: $(inputs.output_prefix).ktab
  - id: ktab_parts
    type:
      type: array
      items: File
    doc: Hidden table part files.
    outputBinding:
      glob: |
        ${
          return ['.' + inputs.output_prefix + '.ktab.*'];
        }
  - id: prof
    type:
      - 'null'
      - File
    doc: Profile stub file, written with the profile options.
    outputBinding:
      glob: $(inputs.output_prefix).prof
  - id: prof_parts
    type:
      type: array
      items: File
    doc: Hidden profile part files.
    outputBinding:
      glob: |
        ${
          return ['.' + inputs.output_prefix + '.prof.*', '.' + inputs.output_prefix + '.pidx.*'];
        }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_FastK.out
