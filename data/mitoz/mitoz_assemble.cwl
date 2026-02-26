cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitoz assemble
label: mitoz_assemble
doc: "Mitochondrial genome assembly from input fastq files.\n\nTool homepage: https://github.com/linzhi2013/MitoZ"
inputs:
  - id: abundance_pattern
    type:
      - 'null'
      - string
    doc: the regular expression pattern to capture the abundance information in 
      the header of sequence
    default: abun\=([0-9]+\.*[0-9]*)
    inputBinding:
      position: 101
      prefix: --abundance_pattern
  - id: assembler
    type:
      - 'null'
      - string
    doc: Assembler to be used.
    default: megahit
    inputBinding:
      position: 101
      prefix: --assembler
  - id: clade
    type:
      - 'null'
      - string
    doc: which clade does your species belong to?
    default: Arthropoda
    inputBinding:
      position: 101
      prefix: --clade
  - id: fastq_read_length
    type:
      - 'null'
      - int
    doc: read length of fastq reads, used by mitoAssemble.
    default: 150
    inputBinding:
      position: 101
      prefix: --fastq_read_length
  - id: filter_by_taxa
    type:
      - 'null'
      - boolean
    doc: filter out non-requiring_taxa sequences by mito-PCGs annotation to do 
      taxa assignment.
    default: true
    inputBinding:
      position: 101
      prefix: --filter_by_taxa
  - id: fq1
    type: File
    doc: fastq 1 file. Set only this option but not --fastq2 means SE data.
    inputBinding:
      position: 101
      prefix: --fq1
  - id: fq2
    type:
      - 'null'
      - File
    doc: fastq 2 file (optional for mitoassemble and megahit, required for 
      spades)
    inputBinding:
      position: 101
      prefix: --fq2
  - id: genetic_code
    type:
      - 'null'
      - string
    doc: which genetic code table to use? 'auto' means determined by '--clade' 
      option.
    default: auto
    inputBinding:
      position: 101
      prefix: --genetic_code
  - id: insert_size
    type:
      - 'null'
      - int
    doc: insert size of input fastq files
    default: 250
    inputBinding:
      position: 101
      prefix: --insert_size
  - id: kmers
    type:
      - 'null'
      - type: array
        items: int
    doc: kmer size(s) to be used. Multiple kmers can be used, separated by 
      space. Only for mitoassemble
    default:
      - 71
    inputBinding:
      position: 101
      prefix: --kmers
  - id: kmers_megahit
    type:
      - 'null'
      - type: array
        items: int
    doc: kmer size(s) to be used. Multiple kmers can be used, separated by 
      space. Only for megahit
    default:
      - 21
      - 29
      - 39
      - 59
      - 79
      - 99
      - 119
      - 141
    inputBinding:
      position: 101
      prefix: --kmers_megahit
  - id: kmers_spades
    type:
      - 'null'
      - type: array
        items: string
    doc: kmer size(s) to be used. Multiple kmers can be used, separated by 
      space. Only for spades
    default:
      - auto
    inputBinding:
      position: 101
      prefix: --kmers_spades
  - id: memory
    type:
      - 'null'
      - int
    doc: memory size limit for spades/megahit, no enough memory will make the 
      two programs halt or exit
    default: 50
    inputBinding:
      position: 101
      prefix: --memory
  - id: min_abundance
    type:
      - 'null'
      - float
    doc: the minimum abundance of sequence required. Set this to any value <= 0 
      if you do NOT want to filter sequences by abundance
    default: 10.0
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
      - Directory
    doc: Directory cotaining 'CDS_HMM/', 'MT_database/' and 'rRNA_CM/'.
    default: /usr/local/lib/python3.8/site-packages/mitoz/profiles
    inputBinding:
      position: 101
      prefix: --profiles_dir
  - id: requiring_relax
    type:
      - 'null'
      - int
    doc: The relaxing threshold for filtering non-target- requiring_taxa. The 
      larger digital means more relaxing.
    default: 0
    inputBinding:
      position: 101
      prefix: --requiring_relax
  - id: requiring_taxa
    type: string
    doc: filtering out non-requiring taxa sequences which may be contamination
    inputBinding:
      position: 101
      prefix: --requiring_taxa
  - id: resume_assembly
    type:
      - 'null'
      - boolean
    doc: to resume previous assembly running
    default: false
    inputBinding:
      position: 101
      prefix: --resume_assembly
  - id: slow_search
    type:
      - 'null'
      - boolean
    doc: By default, we firstly use tiara to perform quick sequence 
      classification (100 times faster than usual!), however, it is valid only 
      when your mitochondrial sequences are >= 3000 bp. If you have missing 
      genes, set '--slow_search' to use the tradicitiona search mode.
    default: false
    inputBinding:
      position: 101
      prefix: --slow_search
  - id: thread_number
    type:
      - 'null'
      - int
    doc: 'thread number. Caution: For spades, --thread_number 32 can take 150 GB RAM!
      Setting this to 8 to 16 is typically good.'
    default: 8
    inputBinding:
      position: 101
      prefix: --thread_number
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Set temp directory for megahit if necessary (See 
      https://github.com/linzhi2013/MitoZ/issues/176)
    inputBinding:
      position: 101
      prefix: --tmp_dir
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: workdir
    default: ./
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
stdout: mitoz_assemble.out
