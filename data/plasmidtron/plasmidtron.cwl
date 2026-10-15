cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidtron
label: plasmidtron
doc: "A tool to assemble parts of a genome responsible for a trait\n\nTool homepage:
  https://github.com/sanger-pathogens/plasmidtron"
inputs:
  - id: output_directory
    type: string
    doc: Output directory
    inputBinding:
      position: 1
  - id: file_of_traits
    type: File
    doc: File of filenames of trait (case) FASTQs
    inputBinding:
      position: 2
  - id: file_of_nontraits
    type: File
    doc: File of filenames of nontrait (control) FASTQs
    inputBinding:
      position: 3
  - id: trait_reads
    type:
      type: array
      items: File
    doc: The trait FASTQ files named in file_of_traits (staged in the working
      directory so the listed names resolve)
  - id: nontrait_reads
    type:
      type: array
      items: File
    doc: The nontrait FASTQ files named in file_of_nontraits (staged in the
      working directory so the listed names resolve)
  - id: action
    type:
      - 'null'
      - type: enum
        symbols:
          - intersection
          - union
    doc: Control how the traits kmers are filtered for assembly [union]
    inputBinding:
      position: 101
      prefix: --action
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files [False]
    inputBinding:
      position: 101
      prefix: --keep_files
  - id: kmer
    type:
      - 'null'
      - int
    doc: Kmer to use, depends on read length [51]
    inputBinding:
      position: 101
      prefix: --kmer
  - id: min_contig_len
    type:
      - 'null'
      - int
    doc: Minimum contig length in final assembly [300]
    inputBinding:
      position: 101
      prefix: --min_contig_len
  - id: min_spades_contig_coverage
    type:
      - 'null'
      - int
    doc: Filter out contigs with low coverage. Set to 0 to keep all. [5]
    inputBinding:
      position: 101
      prefix: --min_spades_contig_coverage
  - id: max_spades_contig_coverage
    type:
      - 'null'
      - int
    doc: Filter out contigs with high coverage. Set to 0 to keep all. [500]
    inputBinding:
      position: 101
      prefix: --max_spades_contig_coverage
  - id: min_kmers_threshold
    type:
      - 'null'
      - int
    doc: Exclude traits k-mers occurring less than this [10]
    inputBinding:
      position: 101
      prefix: --min_kmers_threshold
  - id: max_kmers_threshold
    type:
      - 'null'
      - int
    doc: Exclude traits k-mers occurring more than this [254]
    inputBinding:
      position: 101
      prefix: --max_kmers_threshold
  - id: min_controls_kmers_threshold
    type:
      - 'null'
      - int
    doc: Exclude nontraits k-mers occurring less than this [5]
    inputBinding:
      position: 101
      prefix: --min_controls_kmers_threshold
  - id: max_controls_kmers_threshold
    type:
      - 'null'
      - int
    doc: Exclude nontraits k-mers occurring more than this [254]
    inputBinding:
      position: 101
      prefix: --max_controls_kmers_threshold
  - id: min_kmers_per_read
    type:
      - 'null'
      - float
    doc: Min percentage kmer coverage of read to keep it [0.2]
    inputBinding:
      position: 101
      prefix: --min_kmers_per_read
  - id: match_both_pairs
    type:
      - 'null'
      - boolean
    doc: Match both pairs to keep them in assembly [False]
    inputBinding:
      position: 101
      prefix: --match_both_pairs
  - id: plot_filename
    type:
      - 'null'
      - string
    doc: Kmer plot file name [kmerplot.png]
    inputBinding:
      position: 101
      prefix: --plot_filename
  - id: kmer_plot
    type:
      - 'null'
      - boolean
    doc: Create kmer plot [False]
    inputBinding:
      position: 101
      prefix: --kmer_plot
  - id: spades_exec
    type:
      - 'null'
      - string
    doc: Set the SPAdes executable [spades.py]
    inputBinding:
      position: 101
      prefix: --spades_exec
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads [1]
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on debugging [0]
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: result_directory
    type: Directory
    doc: Output directory with the filtered assemblies
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.trait_reads)
      - $(inputs.nontrait_reads)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidtron:0.4.1--py36_1
