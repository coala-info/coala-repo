cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mapper.pl
label: mirdeep2_mapper.pl
doc: "Process deep sequencing reads (clip adapters, collapse, filter) and map them to a bowtie-indexed genome for miRDeep2\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: reads
    type: File
    doc: Input file with deep sequencing reads (format set with -a, -b, -c or -e), or a config file with -d
    inputBinding:
      position: 1
  - id: input_is_seq_txt
    type:
      - 'null'
      - boolean
    doc: Input file is seq.txt format
    inputBinding:
      position: 101
      prefix: -a
  - id: input_is_qseq_txt
    type:
      - 'null'
      - boolean
    doc: Input file is qseq.txt format
    inputBinding:
      position: 101
      prefix: -b
  - id: input_is_fasta
    type:
      - 'null'
      - boolean
    doc: Input file is fasta format
    inputBinding:
      position: 101
      prefix: -c
  - id: input_is_config
    type:
      - 'null'
      - boolean
    doc: Input file is a config file (options -a, -b, -c or -e must be given with -d)
    inputBinding:
      position: 101
      prefix: -d
  - id: input_is_fastq
    type:
      - 'null'
      - boolean
    doc: Input file is fastq format
    inputBinding:
      position: 101
      prefix: -e
  - id: read_prefix
    type:
      - 'null'
      - string
    doc: Three-letter prefix for reads (by default 'seq')
    inputBinding:
      position: 101
      prefix: -g
  - id: parse_to_fasta
    type:
      - 'null'
      - boolean
    doc: Parse to fasta format
    inputBinding:
      position: 101
      prefix: -h
  - id: convert_rna_to_dna
    type:
      - 'null'
      - boolean
    doc: Convert rna to dna alphabet (to map against genome)
    inputBinding:
      position: 101
      prefix: -i
  - id: remove_non_acgtun
    type:
      - 'null'
      - boolean
    doc: Remove all entries that have a sequence that contains letters other than a,c,g,t,u,n,A,C,G,T,U,N
    inputBinding:
      position: 101
      prefix: -j
  - id: clip_adapter
    type:
      - 'null'
      - string
    doc: Clip 3' adapter sequence
    inputBinding:
      position: 101
      prefix: -k
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Discard reads shorter than this many nts, default = 18
    inputBinding:
      position: 101
      prefix: -l
  - id: collapse_reads
    type:
      - 'null'
      - boolean
    doc: Collapse reads
    inputBinding:
      position: 101
      prefix: -m
  - id: genome_index_prefix
    type:
      - 'null'
      - string
    doc: Map to genome; the string must be the prefix of the bowtie index (for h_sapiens_37_asm.1.ebwt the prefix is h_sapiens_37_asm). The index files must be given in index_files
    inputBinding:
      position: 101
      prefix: -p
  - id: seed_mismatch
    type:
      - 'null'
      - boolean
    doc: Map with one mismatch in the seed (mapping takes longer)
    inputBinding:
      position: 101
      prefix: -q
  - id: max_mappings
    type:
      - 'null'
      - int
    doc: A read is allowed to map up to this number of positions in the genome, default is 5
    inputBinding:
      position: 101
      prefix: -r
  - id: output_processed_reads_path
    type:
      - 'null'
      - string
    doc: Print processed reads to this file
    inputBinding:
      position: 101
      prefix: -s
  - id: output_mappings_path
    type:
      - 'null'
      - string
    doc: Print read mappings to this file (arf format)
    inputBinding:
      position: 101
      prefix: -t
  - id: keep_tmp_dir
    type:
      - 'null'
      - boolean
    doc: Do not remove directory with temporary files
    inputBinding:
      position: 101
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Output progress report
    inputBinding:
      position: 101
      prefix: -v
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files
    inputBinding:
      position: 101
      prefix: -n
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for bowtie
    inputBinding:
      position: 101
      prefix: -o
  - id: index_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Bowtie index files (.ebwt) of the genome named by genome_index_prefix; they are staged in the working directory
outputs:
  - id: processed_reads
    type:
      - 'null'
      - File
    doc: Processed reads
    outputBinding:
      glob: $(inputs.output_processed_reads_path)
  - id: mappings
    type:
      - 'null'
      - File
    doc: Read mappings in arf format
    outputBinding:
      glob: $(inputs.output_mappings_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.index_files ? inputs.index_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
