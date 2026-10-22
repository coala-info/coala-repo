cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alleyoop
  - dump
label: slamdunk_alleyoop_dump
doc: "Print all info available for slamdunk reads\n\nTool homepage: http://t-neumann.github.io/slamdunk"
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
  - id: reference
    type: File
    doc: 'Reference fasta file'
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 1
      prefix: --reference
  - id: snp_directory
    type: ['null', Directory]
    doc: 'Directory containing SNP files.'
    inputBinding:
      position: 1
      prefix: --snp-directory
  - id: vcf_file
    type: ['null', File]
    doc: 'Skip SNP step and provide custom variant file.'
    inputBinding:
      position: 1
      prefix: --vcf
  - id: min_basequality
    type: ['null', int]
    doc: 'Minimal base quality for SNPs (default: 0)'
    inputBinding:
      position: 1
      prefix: --min-basequality
  - id: threads
    type: ['null', int]
    doc: 'Thread number (default: 1)'
    inputBinding:
      position: 1
      prefix: --threads
  - id: output_dir
    type: string
    default: dump_out
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
