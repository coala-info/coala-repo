cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawrap blobology
label: metawrap_blobology
doc: "Run blobology on assembly and reads\n\nTool homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: readsA_1
    type: File
    doc: Forward reads for sample A
    inputBinding:
      position: 1
  - id: readsA_2
    type: File
    doc: Reverse reads for sample A
    inputBinding:
      position: 2
  - id: readsB
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional paired-end reads for other samples
    inputBinding:
      position: 3
  - id: assembly_fasta
    type: File
    doc: assembly fasta file
    inputBinding:
      position: 104
      prefix: -a
  - id: bins
    type:
      - 'null'
      - Directory
    doc: Folder containing bins. Contig names must match those of the assembly 
      file.
    default: None
    inputBinding:
      position: 104
      prefix: --bins
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 104
      prefix: -o
  - id: subsamble
    type:
      - 'null'
      - int
    doc: Number of contigs to run blobology on. Subsampling is randomized.
    default: ALL
    inputBinding:
      position: 104
      prefix: --subsamble
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 104
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap:1.2--0
stdout: metawrap_blobology.out
