cwlVersion: v1.2
class: CommandLineTool
baseCommand: mudskipper sc
label: mudskipper_sc
doc: "Convert alignment of single-cell RNA-Seq reads against genome to alignment against
  transcriptome.\n\nTool homepage: https://github.com/OceanGenomics/mudskipper"
inputs:
  - id: alignment
    type: File
    doc: Input SAM/BAM file
    inputBinding:
      position: 101
      prefix: --alignment
  - id: corrected_tags
    type:
      - 'null'
      - boolean
    doc: Output error-corrected cell barcode and UMI
    inputBinding:
      position: 101
      prefix: --corrected-tags
  - id: gtf
    type:
      - 'null'
      - File
    doc: Input GTF/GFF file
    inputBinding:
      position: 101
      prefix: --gtf
  - id: index
    type:
      - 'null'
      - Directory
    doc: Index directory containing parsed GTF files
    inputBinding:
      position: 101
      prefix: --index
  - id: max_softclip
    type: int
    doc: Max allowed softclip length
    default: 50
    inputBinding:
      position: 101
      prefix: --max-softclip
  - id: rad
    type:
      - 'null'
      - boolean
    doc: Output in RAD format instead of BAM
    inputBinding:
      position: 101
      prefix: --rad
  - id: rad_mapped
    type: File
    doc: Name of output rad file; Only used with --rad
    default: map.rad
    inputBinding:
      position: 101
      prefix: --rad-mapped
  - id: rad_unmapped
    type: File
    doc: Name of file containing the number of unmapped reads for each barcode; 
      Only used with --rad
    default: unmapped_bc_count.bin
    inputBinding:
      position: 101
      prefix: --rad-unmapped
  - id: threads
    type: int
    doc: Number of threads for processing bam files
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type: File
    doc: Output file name (or directory name when --rad is passed)
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mudskipper:0.1.0--h7d875b9_0
