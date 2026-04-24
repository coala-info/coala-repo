cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitoz_findmitoscaf
label: mitoz_findmitoscaf
doc: "Search for mitochondrial sequences from input fasta file.\n\nTool homepage:
  https://github.com/linzhi2013/MitoZ"
inputs:
  - id: abundance_pattern
    type:
      - 'null'
      - string
    doc: the regular expression pattern to capture the abundance information in 
      the header of sequence
    inputBinding:
      position: 101
      prefix: --abundance_pattern
  - id: clade
    type:
      - 'null'
      - string
    doc: which clade does your species belong to?
    inputBinding:
      position: 101
      prefix: --clade
  - id: fastafile
    type: File
    doc: Input fasta file. Gzip supported.
    inputBinding:
      position: 101
      prefix: --fastafile
  - id: filter_by_taxa
    type:
      - 'null'
      - boolean
    doc: filter out non-requiring_taxa sequences by mito-PCGs annotation to do 
      taxa assignment.
    inputBinding:
      position: 101
      prefix: --filter_by_taxa
  - id: fq1
    type:
      - 'null'
      - File
    doc: Input fastq 1 file. use this option if the headers of your 
      '--fastafile' does NOT have abundance information BUT you WANT to filter 
      sequence by their sequencing abundances
    inputBinding:
      position: 101
      prefix: --fq1
  - id: fq2
    type:
      - 'null'
      - File
    doc: Input fastq 2 file. use this option if the headers of your 
      '--fastafile' does NOT have abundance information BUT you WANT to filter 
      sequence by their sequencing abundances
    inputBinding:
      position: 101
      prefix: --fq2
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: which genetic code table to use? 'auto' means determined by '--clade' 
      option.
    inputBinding:
      position: 101
      prefix: --genetic_code
  - id: min_abundance
    type:
      - 'null'
      - float
    doc: the minimum abundance of sequence required. Set this to any value <= 0 
      if you do NOT want to filter sequences by abundance
    inputBinding:
      position: 101
      prefix: --min_abundance
  - id: outprefix
    type: string
    doc: output prefix
    inputBinding:
      position: 101
      prefix: --outprefix
  - id: profiles_dir
    type:
      - 'null'
      - string
    doc: Directory cotaining 'CDS_HMM/', 'MT_database/' and 'rRNA_CM/'.
    inputBinding:
      position: 101
      prefix: --profiles_dir
  - id: requiring_relax
    type:
      - 'null'
      - int
    doc: The relaxing threshold for filtering non-target-requiring_taxa. The 
      larger digital means more relaxing.
    inputBinding:
      position: 101
      prefix: --requiring_relax
  - id: requiring_taxa
    type: string
    doc: filtering out non-requiring taxa sequences which may be contamination
    inputBinding:
      position: 101
      prefix: --requiring_taxa
  - id: skip_read_mapping
    type:
      - 'null'
      - boolean
    doc: Skip read-mapping step, assuming we can extract the abundance from 
      seqid line.
    inputBinding:
      position: 101
      prefix: --skip_read_mapping
  - id: slow_search
    type:
      - 'null'
      - boolean
    doc: By default, we firstly use tiara to perform quick sequence 
      classification (100 times faster than usual!), however, it is valid only 
      when your mitochondrial sequences are >= 3000 bp. If you have missing 
      genes, set '--slow_search' to use the tradicitiona search mode.
    inputBinding:
      position: 101
      prefix: --slow_search
  - id: thread_number
    type:
      - 'null'
      - int
    doc: thread number
    inputBinding:
      position: 101
      prefix: --thread_number
  - id: workdir
    type:
      - 'null'
      - string
    doc: workdir
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
stdout: mitoz_findmitoscaf.out
