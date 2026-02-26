cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphtyper
label: graphtyper_genotype_camou
doc: "GraphTyper\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: ref_fa
    type: File
    doc: Reference genome in FASTA format.
    inputBinding:
      position: 1
  - id: interval_file
    type: File
    doc: 3-column BED type file with interval(s)/region(s) to filter on.
    inputBinding:
      position: 2
  - id: avg_cov_by_readlen
    type:
      - 'null'
      - File
    doc: File with average coverage by read length.
    inputBinding:
      position: 103
      prefix: --avg_cov_by_readlen
  - id: log
    type:
      - 'null'
      - string
    doc: Set path to log file.
    inputBinding:
      position: 103
      prefix: --log
  - id: max_files_open
    type:
      - 'null'
      - int
    doc: Select how many files can be open at the same time.
    default: 864
    inputBinding:
      position: 103
      prefix: --max_files_open
  - id: no_bamshrink
    type:
      - 'null'
      - boolean
    doc: Set to skip bamShrink.
    inputBinding:
      position: 103
      prefix: --no_bamshrink
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Set to skip removing temporary files. Useful for debugging.
    inputBinding:
      position: 103
      prefix: --no_cleanup
  - id: sam
    type:
      - 'null'
      - File
    doc: SAM/BAM/CRAM to analyze.
    inputBinding:
      position: 103
      prefix: --sam
  - id: sams
    type:
      - 'null'
      - type: array
        items: File
    doc: File with SAM/BAM/CRAMs to analyze (one per line).
    inputBinding:
      position: 103
      prefix: --sams
  - id: threads
    type:
      - 'null'
      - int
    doc: Max. number of threads to use.
    default: 20
    inputBinding:
      position: 103
      prefix: --threads
  - id: vcf
    type:
      - 'null'
      - File
    doc: "Input VCF file with variant sites. Use this option if you want GraphTyper\
      \ \n      to only genotype variants from this VCF."
    inputBinding:
      position: 103
      prefix: --vcf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set to output verbose logging.
    inputBinding:
      position: 103
      prefix: --verbose
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: Set to output very verbose logging.
    inputBinding:
      position: 103
      prefix: --vverbose
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: "Output directory. Results will be written in \n      <output>/<contig>/<region>.vcf.gz"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
