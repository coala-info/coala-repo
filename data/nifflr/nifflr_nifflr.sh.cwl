cwlVersion: v1.2
class: CommandLineTool
baseCommand: nifflr.sh
label: nifflr_nifflr.sh
doc: "NIFFLR version 2.0.0\n\nTool homepage: https://github.com/alguoo314/NIFFLR"
inputs:
  - id: allowed_exon_gap_or_overlap
    type:
      - 'null'
      - int
    doc: maximum allowed gap or overlap between two adjacent aligned exons for 
      building a valid transcript
    default: 15
    inputBinding:
      position: 101
      prefix: --allowed_exon_gap_or_overlap
  - id: genome_fasta
    type: File
    doc: fasta file containing the genome sequence
    inputBinding:
      position: 101
      prefix: --ref
  - id: genome_gtf
    type: File
    doc: GTF file for the genome annotation
    inputBinding:
      position: 101
      prefix: --gtf
  - id: keep_intermediate_files
    type:
      - 'null'
      - boolean
    doc: if set, all the intermediate files will be kept
    inputBinding:
      position: 101
      prefix: --keep
  - id: mer_size
    type:
      - 'null'
      - int
    doc: alignment K-mer size
    default: 12
    inputBinding:
      position: 101
      prefix: --mer
  - id: min_known_junction_coverage
    type:
      - 'null'
      - float
    doc: minimum (must be > than) intron junction coverage for detection of 
      known transcripts
    default: 0.0
    inputBinding:
      position: 101
      prefix: --known
  - id: min_novel_junction_coverage
    type:
      - 'null'
      - float
    doc: minimum (must be > than) intron junction coverage for detection of 
      novel transcripts
    default: 2.0
    inputBinding:
      position: 101
      prefix: --novel
  - id: minimum_exon_bases
    type:
      - 'null'
      - float
    doc: minimum percentage of exon bases in matching K-mers
    default: 35.0
    inputBinding:
      position: 101
      prefix: --bases
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix of the output files
    default: output
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reads_file
    type: File
    doc: fasta/fastq file containing the reads, file can ge gzipped, multiple 
      files should be listed in single quotes e.g. 'file1.fastq file2.fastq'
    inputBinding:
      position: 101
      prefix: --fasta
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 16
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nifflr:2.0.0--pl5321haf24da9_0
stdout: nifflr_nifflr.sh.out
