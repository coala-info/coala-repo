cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alleyoop
  - snpeval
label: slamdunk_alleyoop_snpeval
doc: "Evaluate SNP calling\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs:
  - id: bam
    type:
      type: array
      items: File
    doc: 'Bam file(s)'
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 100
  - id: snp_directory
    type: Directory
    doc: 'Directory containing SNP files.'
    inputBinding:
      position: 1
      prefix: --snp-directory
  - id: reference
    type: File
    doc: 'Reference fasta file'
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 1
      prefix: --reference
  - id: bed_file
    type: File
    doc: 'BED file'
    inputBinding:
      position: 1
      prefix: --bed
  - id: min_coverage
    type: ['null', int]
    doc: 'Minimum coverage to call variant (default: 10)'
    inputBinding:
      position: 1
      prefix: --min-coverage
  - id: var_fraction
    type: ['null', float]
    doc: 'Minimum variant fraction to call variant (default: 0.8)'
    inputBinding:
      position: 1
      prefix: --var-fraction
  - id: multi_tc_stringency
    type: ['null', boolean]
    doc: 'Multi T>C stringency'
    inputBinding:
      position: 1
      prefix: --multiTCStringency
  - id: max_read_length
    type: ['null', int]
    doc: 'Max read length in BAM file (default: None)'
    inputBinding:
      position: 1
      prefix: --max-read-length
  - id: min_base_qual
    type: ['null', int]
    doc: 'Min base quality for T -> C conversions (default: 27)'
    inputBinding:
      position: 1
      prefix: --min-base-qual
  - id: threads
    type: ['null', int]
    doc: 'Thread number (default: 1)'
    inputBinding:
      position: 1
      prefix: --threads
  - id: output_dir
    type: string
    default: snpeval_out
    doc: Output directory
    inputBinding:
      position: 1
      prefix: --outputDir
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
