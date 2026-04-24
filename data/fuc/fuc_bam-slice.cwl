cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - bam-slice
label: fuc_bam-slice
doc: "Slice a BAM file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: bam
    type: File
    doc: Input BAM file. It must be already indexed to allow random access. You 
      can index a BAM file with the bam-index command.
    inputBinding:
      position: 1
  - id: regions
    type:
      type: array
      items: string
    doc: One or more regions to be sliced. Each region must have the format 
      chrom:start-end and be a half-open interval with (start, end]. This means,
      for example, chr1:100-103 will extract positions 101, 102, and 103. 
      Alternatively, you can provide a BED file (compressed or uncompressed) to 
      specify regions. Note that the 'chr' prefix in contig names (e.g. 'chr1' 
      vs. '1') will be automatically added or removed as necessary to match the 
      input BED's contig names.
    inputBinding:
      position: 2
  - id: fasta
    type:
      - 'null'
      - File
    doc: FASTA file. Required when --format is 'CRAM'.
    inputBinding:
      position: 103
      prefix: --fasta
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format
    inputBinding:
      position: 103
      prefix: --format
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_bam-slice.out
