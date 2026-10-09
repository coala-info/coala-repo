cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hatchet
  - count-reads-fw
label: hatchet_count_reads_fw
doc: "Count the mapped sequencing reads in bins of fixed length, uniformly for a BAM file of a normal sample and one or more BAM files of tumor samples (WGS or WES).

Tool homepage: https://github.com/raphael-group/hatchet"
inputs:
  - id: normal
    type: File
    secondaryFiles:
      - '.bai'
    doc: BAM file corresponding to matched normal sample
    inputBinding:
      position: 10
      prefix: -N
  - id: tumors
    type:
      type: array
      items: File
    secondaryFiles:
      - '.bai'
    doc: BAM files corresponding to samples from the same tumor
    inputBinding:
      position: 10
      prefix: -T
  - id: size
    type: string
    doc: "Size of the bins, specified as a full number or using the notations either \"kb\" or \"Mb\""
    inputBinding:
      position: 10
      prefix: -b
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: "Sample names for each BAM, given in the same order where the normal name is first (default: inferred from file names)"
    inputBinding:
      position: 10
      prefix: -S
  - id: samtools
    type:
      - 'null'
      - string
    doc: "Path to the directory to \"samtools\" executable"
    inputBinding:
      position: 10
      prefix: -st
  - id: regions
    type:
      - 'null'
      - File
    doc: "BED file containing the a list of genomic regions to consider in the format \"CHR START END\", REQUIRED for WES data (default: none, consider entire genome)"
    inputBinding:
      position: 10
      prefix: -r
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - '.fai'
      - '^.dict'
    doc: Reference genome; it must be indexed and the dictionary must exist in the same directory with the same name and .dict extension
    inputBinding:
      position: 10
      prefix: -g
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of available parallel processes (default: 2)"
    inputBinding:
      position: 10
      prefix: -j
  - id: readquality
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality for an aligned read to be considered (default: 11)"
    inputBinding:
      position: 10
      prefix: -q
  - id: outputnormal
    type:
      - 'null'
      - string
    doc: "Filename of output for allele counts in the normal sample (default: standard output)"
    inputBinding:
      position: 10
      prefix: -O
  - id: outputtumors
    type:
      - 'null'
      - string
    doc: "Output filename for allele counts in tumor samples (default: standard output)"
    inputBinding:
      position: 10
      prefix: -o
  - id: outputtotal
    type:
      - 'null'
      - string
    doc: "Output filename for total read counts in all tumor samples (default: \"total_read.counts\")"
    inputBinding:
      position: 10
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use verbose log messages
    inputBinding:
      position: 10
      prefix: -v
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more chromosomes to process (default: blank to process all chromosomes)"
    inputBinding:
      position: 10
      prefix: --chromosomes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: normal_counts
    type:
      - 'null'
      - File
    doc: Bin counts of the normal sample
    outputBinding:
      glob: $(inputs.outputnormal)
  - id: tumor_counts
    type:
      - 'null'
      - File
    doc: Bin counts of the tumor samples
    outputBinding:
      glob: $(inputs.outputtumors)
  - id: total_counts
    type:
      - 'null'
      - File
    doc: Total read counts of all samples
    outputBinding:
      glob: $(inputs.outputtotal || 'total_read.counts')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hatchet:2.1.2--py310h184ae93_0
stdout: hatchet_count_reads_fw.out
