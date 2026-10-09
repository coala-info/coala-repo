cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - inStrain
  - filter_reads
label: instrain_filter_reads
doc: "Commands related to filtering reads from .bam files\n\nTool homepage: https://github.com/MrOlm/inStrain"
inputs:
  - id: bam
    type: File
    doc: Sorted .bam file
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: Fasta file the bam is mapped to
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: Location of folder to store read report(s)
    inputBinding:
      position: 101
      prefix: --output
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to use (default: 6)'
    inputBinding:
      position: 101
      prefix: --processes
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Make extra debugging output (default: False)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: min_read_ani
    type:
      - 'null'
      - float
    doc: 'Minimum percent identity of read pairs to consensus to use the reads. Must be >, not >= (default: 0.95)'
    inputBinding:
      position: 101
      prefix: --min_read_ani
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'Minimum mapq score of EITHER read in a pair to use that pair. Must be >, not >= (default: -1)'
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: max_insert_relative
    type:
      - 'null'
      - float
    doc: 'Multiplier to determine maximum insert size between two reads - default is to use 3x median insert size. Must be >, not >= (default: 3)'
    inputBinding:
      position: 101
      prefix: --max_insert_relative
  - id: min_insert
    type:
      - 'null'
      - int
    doc: 'Minimum insert size between two reads - default is 50 bp. Must be >, not >= (default: 50)'
    inputBinding:
      position: 101
      prefix: --min_insert
  - id: pairing_filter
    type:
      - 'null'
      - type: enum
        symbols:
          - paired_only
          - non_discordant
          - all_reads
    doc: 'How should paired reads be handled? paired_only = only paired reads are retained; non_discordant = keep all paired reads and singleton reads that map to a single scaffold; all_reads = keep all reads regardless of pairing status (not recommended) (default: paired_only)'
    inputBinding:
      position: 101
      prefix: --pairing_filter
  - id: priority_reads
    type:
      - 'null'
      - File
    doc: A list of reads that should be retained regardless of pairing status (for example long reads or merged reads). A .fastq file or text file with list of read names (assumed compressed if it ends in .gz)
    inputBinding:
      position: 101
      prefix: --priority_reads
  - id: maximum_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads. Requires sambamba to do the subsetting
    inputBinding:
      position: 101
      prefix: --maximum_reads
  - id: detailed_mapping_info
    type:
      - 'null'
      - boolean
    doc: 'Make a detailed read report indicating details about each individual mapped read (default: False)'
    inputBinding:
      position: 101
      prefix: --detailed_mapping_info
outputs:
  - id: read_report_dir
    type: Directory
    doc: Folder with the read report(s)
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
