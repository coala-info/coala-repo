cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - bam-depth
label: fuc_bam-depth
doc: "Compute per-base read depth from BAM files.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: bams
    type:
      type: array
      items: File
    doc: One or more input BAM files. Alternatively, you can provide a text file
      (.txt, .tsv, .csv, or .list) containing one BAM file per line.
    inputBinding:
      position: 1
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: By default, the command counts all reads in BAM files, which can be 
      excruciatingly slow for large files (e.g. whole genome sequencing). 
      Therefore, use this argument to only output positions in given regions. 
      Each region must have the format chrom:start-end and be a half-open 
      interval with (start, end]. This means, for example, chr1:100-103 will 
      extract positions 101, 102, and 103. Alternatively, you can provide a BED 
      file (compressed or uncompressed) to specify regions. Note that the 'chr' 
      prefix in contig names (e.g. 'chr1' vs. '1') will be automatically added 
      or removed as necessary to match the input BAM's contig names.
    inputBinding:
      position: 102
      prefix: --regions
  - id: zero
    type:
      - 'null'
      - boolean
    doc: Output all positions including those with zero depth.
    inputBinding:
      position: 102
      prefix: --zero
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_bam-depth.out
