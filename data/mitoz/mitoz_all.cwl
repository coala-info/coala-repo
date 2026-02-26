cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitoz all
label: mitoz_all
doc: "Run all steps for mitochondrial genome anlysis from input fastq files.\n\nTool
  homepage: https://github.com/linzhi2013/MitoZ"
inputs:
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
  - id: data_size_for_mt_assembly
    type:
      - 'null'
      - string
    doc: Data size (Gbp) used for mitochondrial genome assembly, usually between
      2~8 Gbp is enough. The float1 means the size (Gbp) of raw data to be 
      subsampled, while the float2 means the size of clean data must be >= 
      float2 Gbp, otherwise MitoZ will STOP running! When only float1 is set, 
      float2 is assumed to be 0. (1) Set float1 to be 0 if you want to use ALL 
      raw data; (2) Set 0,0 if you want to use ALL raw data and do NOT interrupt
      MitoZ even if you got very little clean data. If you got missing 
      mitochondrial genes, try (1) differnt kmers; (2)different assembler; (3) 
      increase <float1>,<float2>
    default: 2,0
    inputBinding:
      position: 101
      prefix: --data_size_for_mt_assembly
  - id: fastq_read_length
    type:
      - 'null'
      - int
    doc: read length of fastq reads, used by the filter subcommand and 
      mitoAssemble.
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
  - id: filter_other_para
    type:
      - 'null'
      - string
    doc: other parameter for filtering.
    default: ''
    inputBinding:
      position: 101
      prefix: --filter_other_para
  - id: fq1
    type: File
    doc: Fastq1 file
    inputBinding:
      position: 101
      prefix: --fq1
  - id: fq2
    type:
      - 'null'
      - File
    doc: Fastq2 file
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
    doc: kmer size(s) to be used. Multiple kmers can be used, separated by space
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
      - 43
      - 71
      - 99
    inputBinding:
      position: 101
      prefix: --kmers_megahit
  - id: kmers_spades
    type:
      - 'null'
      - type: array
        items: int
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
    default: 10
    inputBinding:
      position: 101
      prefix: --min_abundance
  - id: outprefix
    type:
      - 'null'
      - string
    doc: output prefix
    default: out
    inputBinding:
      position: 101
      prefix: --outprefix
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: Are the fastq phred64 encoded?
    default: false
    inputBinding:
      position: 101
      prefix: --phred64
  - id: profiles_dir
    type:
      - 'null'
      - string
    doc: Directory cotaining 'CDS_HMM/', 'MT_database/' and 'rRNA_CM/'.
    default: /usr/local/lib/python3.8/site-packages/mitoz/profiles
    inputBinding:
      position: 101
      prefix: --profiles_dir
  - id: requiring_relax
    type:
      - 'null'
      - int
    doc: The relaxing threshold for filtering non-target-requiring_taxa. The 
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
  - id: skip_filter
    type:
      - 'null'
      - boolean
    doc: Skip the rawdata filtering step, assuming input fastq are clean data. 
      To subsample such clean data, set <float2> of the 
      --data_size_for_mt_assembly option to be larger than 0 (using all input 
      clean data by default).
    default: false
    inputBinding:
      position: 101
      prefix: --skip_filter
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
  - id: species_name
    type:
      - 'null'
      - string
    doc: species name to use in output genbank file
    default: Test sp.
    inputBinding:
      position: 101
      prefix: --species_name
  - id: template_sbt
    type:
      - 'null'
      - File
    doc: The sqn template to generate the resulting genbank file. Go to 
      https://www.ncbi.nlm.nih.gov/genbank/tbl2asn2/#Template to generate your 
      own template file if you like.
    inputBinding:
      position: 101
      prefix: --template_sbt
  - id: thread_number
    type:
      - 'null'
      - int
    doc: thread number
    default: 8
    inputBinding:
      position: 101
      prefix: --thread_number
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Set temp directory for megahit if necessary (See 
      https://github.com/linzhi2013/MitoZ/issues/176)
    inputBinding:
      position: 101
      prefix: --tmp_dir
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: working directory
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
stdout: mitoz_all.out
