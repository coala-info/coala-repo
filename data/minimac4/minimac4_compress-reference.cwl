cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimac4
label: minimac4_compress-reference
doc: "Compresses a VCF, BCF or SAV reference panel to the MSAV format.\n\nTool homepage: https://github.com/statgen/Minimac4"
inputs:
  - id: reference
    type: File
    doc: 'Reference file in SAV, BCF, or VCF.gz format to compress'
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .tbi
        required: false
      - pattern: .s1r
        required: false
    inputBinding:
      position: 1
      prefix: --compress-reference
  - id: region
    type:
      - 'null'
      - string
    doc: 'Genomic region to impute'
    inputBinding:
      position: 103
      prefix: -r
  - id: sample_ids
    type:
      - 'null'
      - string
    doc: 'Comma-separated list of sample IDs to subset from reference panel'
    inputBinding:
      position: 103
      prefix: --sample-ids
  - id: sample_ids_file
    type:
      - 'null'
      - File
    doc: 'Text file containing sample IDs to subset from reference panel (one ID per line)'
    inputBinding:
      position: 103
      prefix: --sample-ids-file
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output path (default: /dev/stdout)'
    inputBinding:
      position: 103
      prefix: -o
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Default output file format used for ambiguous filenames (bcf, sav, vcf.gz, ubcf, usav, or vcf; default: sav)'
    inputBinding:
      position: 103
      prefix: -O
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (default: 1)'
    inputBinding:
      position: 103
      prefix: -t
  - id: min_block_size
    type:
      - 'null'
      - int
    doc: 'Minimium block size for unique haplotype compression (default: 10)'
    inputBinding:
      position: 103
      prefix: --min-block-size
  - id: max_block_size
    type:
      - 'null'
      - int
    doc: 'Maximum block size for unique haplotype compression (default: 65535)'
    inputBinding:
      position: 103
      prefix: --max-block-size
  - id: slope_unit
    type:
      - 'null'
      - int
    doc: 'Parameter for unique haplotype compression heuristic (default: 10)'
    inputBinding:
      position: 103
      prefix: --slope-unit
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Compressed reference panel (MSAV)
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output (the result when no output path is given)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minimac4:4.1.6--hcb620b3_1
stdout: minimac4_compress-reference.out
