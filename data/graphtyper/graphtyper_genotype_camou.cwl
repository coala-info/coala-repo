cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
  - genotype_camou
label: graphtyper_genotype_camou
doc: "(WIP) Run the camou SNP/indel genotyping pipeline.\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.sam_files)
inputs:
  - id: reference_fasta
    type: File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: "Reference genome in FASTA format."
    inputBinding:
      position: 1
  - id: interval_file
    type: File
    doc: "3-column BED type file with interval(s)/region(s) to filter on."
    inputBinding:
      position: 2
  - id: log
    type:
      - 'null'
      - string
    doc: "Set path to log file."
    inputBinding:
      position: 10
      prefix: "--log="
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Set to output verbose logging."
    inputBinding:
      position: 10
      prefix: "--verbose"
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: "Set to output very verbose logging."
    inputBinding:
      position: 10
      prefix: "--vverbose"
  - id: avg_cov_by_readlen
    type:
      - 'null'
      - File
    doc: "File with average coverage by read length (one value per line). The values are used for subsampling regions with extremely high coverage and should be in the same order as the BAM/CRAM list."
    inputBinding:
      position: 10
      prefix: "--avg_cov_by_readlen="
      separate: false
  - id: max_files_open
    type:
      - 'null'
      - int
    doc: "Select how many files can be open at the same time (default 864)."
    inputBinding:
      position: 10
      prefix: "--max_files_open="
      separate: false
  - id: no_bamshrink
    type:
      - 'null'
      - boolean
    doc: "Set to skip bamShrink."
    inputBinding:
      position: 10
      prefix: "--no_bamshrink"
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: "Set to skip removing temporary files. Useful for debugging."
    inputBinding:
      position: 10
      prefix: "--no_cleanup"
  - id: output
    type: string
    default: results
    doc: "Output directory. Results will be written in <output>/<contig>/<region>.vcf.gz"
    inputBinding:
      position: 10
      prefix: "--output="
      separate: false
  - id: sam
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.bai
        required: false
    doc: "Input BAM/CRAM to analyze. If you have more than one file then create a list and use sams instead."
    inputBinding:
      position: 10
      prefix: "--sam="
      separate: false
  - id: sams
    type:
      - 'null'
      - File
    doc: "File with BAM/CRAM paths to analyze (one per line); list the files in sam_files as well so that the paths resolve."
    inputBinding:
      position: 10
      prefix: "--sams="
      separate: false
  - id: sam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "BAM/CRAM files (with indices) named in the sams list, staged in the working directory."
  - id: threads
    type:
      - 'null'
      - int
    doc: "Max. number of threads to use (default 20). Note that it is not possible to utilize more threads than input BAM/CRAMs."
    inputBinding:
      position: 10
      prefix: "--threads="
      separate: false
  - id: vcf
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: "Input VCF file with variant sites."
    inputBinding:
      position: 10
      prefix: "--vcf="
      separate: false
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the genotyped VCF files per contig and region
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
stdout: graphtyper_genotype_camou.out
