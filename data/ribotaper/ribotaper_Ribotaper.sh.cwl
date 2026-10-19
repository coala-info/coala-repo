cwlVersion: v1.2
class: CommandLineTool
baseCommand: Ribotaper.sh
label: ribotaper_Ribotaper.sh
doc: "Run RiboTaper: define translated ORFs from Ribo-seq and RNA-seq alignments using
  the 3-nucleotide periodicity.\n\nTool homepage: https://github.com/boboppie/RiboTaper"
inputs:
  - id: ribo_bam
    type: File
    doc: Ribo-seq alignment file (BAM)
    inputBinding:
      position: 1
  - id: rna_bam
    type: File
    doc: RNA-seq alignment file (BAM)
    inputBinding:
      position: 2
  - id: annotation_dir
    type: Directory
    doc: Annotation directory made by create_annotations_files.bash
    inputBinding:
      position: 3
  - id: read_lengths
    type: string
    doc: Comma-separated read lengths of the Ribo-seq reads (for example 28,29)
    inputBinding:
      position: 4
  - id: cutoffs
    type: string
    doc: Comma-separated P-site offsets (cutoffs) for these read lengths
    inputBinding:
      position: 5
  - id: n_cores
    type: int
    doc: Number of cores (must be greater than 1)
    inputBinding:
      position: 6
outputs:
  - id: results
    type:
      type: array
      items:
        - File
        - Directory
    doc: All files and folders written by the run
    outputBinding:
      glob: '*'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotaper:1.3.1--0
stdout: ribotaper_Ribotaper.sh.out
