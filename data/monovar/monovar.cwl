cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - mpileup
label: monovar
doc: "Monovar is a single nucleotide variant (SNV) caller for single-cell DNA
  sequencing data. It reads a samtools mpileup stream of all cells on standard
  input, so this tool runs `samtools mpileup ... | monovar ...` as in the
  Monovar manual. The list of BAM files is written for you from bam_files.\n\nTool
  homepage: https://bitbucket.org/hamimzafar/monovar"
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.bam_files)
      - entryname: bam_list.txt
        entry: |-
          $(inputs.bam_files.map(function(f) { return f.basename; }).join("\n") + "\n")
inputs:
  - id: bam_files
    type: File[]
    doc: Sorted and indexed BAM files, one per single cell (the list file for
      monovar and samtools mpileup is made from them)
    secondaryFiles:
      - pattern: .bai
        required: true
  - id: reference
    type: File
    secondaryFiles:
      - pattern: .fai
        required: true
    doc: Reference genome file (FASTA, indexed with samtools faidx)
    inputBinding:
      position: 20
      prefix: -f
  - id: output_vcf_path
    type: string
    doc: Output VCF file name
    inputBinding:
      position: 21
      prefix: -o
  - id: prob_error
    type:
      - 'null'
      - float
    doc: Probability of error (default 0.002)
    inputBinding:
      position: 22
      prefix: -p
  - id: prob_deamination
    type:
      - 'null'
      - float
    doc: Probability of deamination error
    inputBinding:
      position: 22
      prefix: -d
  - id: prob_ado
    type:
      - 'null'
      - float
    doc: Probability of allelic dropout (default 0.2)
    inputBinding:
      position: 22
      prefix: -a
  - id: prob_threshold
    type:
      - 'null'
      - float
    doc: Threshold for calling a variant (default 0.05)
    inputBinding:
      position: 22
      prefix: -t
  - id: consensus_filter
    type:
      - 'null'
      - int
    doc: Use the consensus filter, 1 (default) or 0
    inputBinding:
      position: 22
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for multiprocessing (default 1)
    inputBinding:
      position: 22
      prefix: -m
  - id: min_mapping_quality
    type: ['null', int]
    default: 40
    doc: Minimum mapping quality for samtools mpileup (-q), 40 in the Monovar
      manual
    inputBinding:
      position: 3
      prefix: -q
arguments:
  - position: 1
    valueFrom: -BQ0
  - position: 2
    valueFrom: -d10000
  - position: 4
    prefix: -f
    valueFrom: $(inputs.reference.path)
  - position: 5
    prefix: -b
    valueFrom: bam_list.txt
  - position: 10
    valueFrom: '|'
    shellQuote: false
  - position: 11
    valueFrom: monovar
  - position: 23
    prefix: -b
    valueFrom: bam_list.txt
outputs:
  - id: output_vcf
    type: File
    doc: Output VCF file
    outputBinding:
      glob: $(inputs.output_vcf_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monovar:v0.0.1--py27_0
