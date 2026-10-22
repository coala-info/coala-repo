cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spaln
label: spaln_makdb
doc: "Write block information (spaln database) for a genome (-KD or -KP) or an amino acid database (-KA) with spaln -W; the database files are written next to the input FASTA file.\n\nTool homepage: https://github.com/ogotoh/spaln"
inputs:
  - id: fasta
    type: File
    doc: "Genome.mfa (multi-FASTA genome) or AAdb.faa (amino acid database)"
    inputBinding:
      position: 200
      valueFrom: $(self.basename)
  - id: block_file
    type:
      - 'null'
      - string
    doc: "Name of the block information file to write, e.g. Genome.bkn, Genome.bkp or AAdb.bka (default: named after the FASTA file)"
  - id: db_type
    type:
      - 'null'
      - string
    doc: "Database type: D (genomic DNA, writes .bkn), P (genomic DNA translated in all frames, writes .bkp) or A (amino acid database, writes .bka)"
    inputBinding:
      position: 10
      prefix: -K
      separate: false
  - id: num_bit_patterns
    type:
      - 'null'
      - int
    doc: "Number of bit patterns < 6 (1)"
    inputBinding:
      position: 10
      prefix: -XC
      separate: false
  - id: max_expected_gene_size
    type:
      - 'null'
      - string
    doc: "Maximum expected gene size (inferred from genome|db size); suffix k or M is effective"
    inputBinding:
      position: 10
      prefix: -XG
      separate: false
  - id: word_size
    type:
      - 'null'
      - int
    doc: "Word size (inferred from genome|db size)"
    inputBinding:
      position: 10
      prefix: -Xk
      separate: false
  - id: block_size
    type:
      - 'null'
      - int
    doc: "Block size (inferred from genome|db size)"
    inputBinding:
      position: 10
      prefix: -Xb
      separate: false
  - id: abundance_factor
    type:
      - 'null'
      - int
    doc: "Abundance factor (10)"
    inputBinding:
      position: 10
      prefix: -Xa
      separate: false
  - id: min_orf_length
    type:
      - 'null'
      - int
    doc: "Minimum ORF length with -KP (30)"
    inputBinding:
      position: 10
      prefix: -Xr
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: "Multi-thread operation with # threads"
    inputBinding:
      position: 10
      prefix: -t
      separate: false
  - id: gzipped_output
    type:
      - 'null'
      - boolean
    doc: "gzipped output"
    inputBinding:
      position: 10
      prefix: -g
outputs:
  - id: db_files
    type:
      type: array
      items: File
    doc: Database files written by spaln -W (block, entry, group, index and sequence files)
    outputBinding:
      glob: |-
        ${ var b = inputs.block_file ? inputs.block_file.replace(/\.[^.\/]*$/, '') : inputs.fasta.nameroot; return [b + '.bk*', b + '.ent', b + '.grp', b + '.idx', b + '.seq']; }
arguments:
  - position: 5
    valueFrom: ${ return '-W' + (inputs.block_file || ''); }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
