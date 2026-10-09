cwlVersion: v1.2
class: CommandLineTool
baseCommand: is6110
label: is6110
doc: "Find IS elements in a BAM file.\n\nTool homepage: https://github.com/jodyphelan/is6110"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file.
    secondaryFiles:
      - pattern: .bai
        required: true
    inputBinding:
      position: 101
      prefix: --bam
  - id: clipping_gap
    type:
      - 'null'
      - int
    doc: Maximum gap between left and right clipped reads.
    inputBinding:
      position: 101
      prefix: --clipping-gap
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging.
    inputBinding:
      position: 101
      prefix: --debug
  - id: gff_file
    type:
      - 'null'
      - File
    doc: Reference genome file.
    inputBinding:
      position: 101
      prefix: --gff
  - id: is_sequences
    type: File
    doc: "FASTA file containing the IS sequences (for example IS6110; the package
      file is src/is6110/data/IS.fasta). The tool indexes it with samtools faidx, so
      a .fai index must exist beside it: the default IS.fasta inside the read-only
      container cannot be indexed."
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 101
      prefix: --is-sequences
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth for positions to be considered.
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: min_score
    type:
      - 'null'
      - int
    doc: Minimum alignment score for BWA MEM (-T).
    inputBinding:
      position: 101
      prefix: --min-score
  - id: min_seed
    type:
      - 'null'
      - int
    doc: Minimum seed length for BWA MEM (-k).
    inputBinding:
      position: 101
      prefix: --min-seed
  - id: reference_genome
    type: File
    doc: Reference genome file.
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 101
      prefix: --ref
  - id: target_region
    type:
      - 'null'
      - string
    doc: Region to search in the format 'chr:start-end'.
    inputBinding:
      position: 101
      prefix: --target
  - id: targets_file
    type:
      - 'null'
      - File
    doc: Bed file with regions to search.
    inputBinding:
      position: 101
      prefix: --targets-file
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_file_path
    type: string
    doc: Output file for IS counts.
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: output_file
    type: File
    doc: Output file for IS counts.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/is6110:0.5.0--pyh7e72e81_0
