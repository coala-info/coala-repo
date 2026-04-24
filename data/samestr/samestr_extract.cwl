cwlVersion: v1.2
class: CommandLineTool
baseCommand: samestr_extract
label: samestr_extract
doc: "Extracts marker sequences from input FASTA files based on a specified clade
  and database.\n\nTool homepage: https://github.com/danielpodlesny/samestr/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Reference genomes in fasta format.
    inputBinding:
      position: 1
  - id: clade
    type: string
    doc: Clade to process from input files. Names must correspond to the 
      taxonomy of the respective database [e.g. t__SGB10068 for MetaPhlAn or 
      ref_mOTU_v3_00095 for mOTUs]
    inputBinding:
      position: 2
  - id: aln_program
    type:
      - 'null'
      - string
    doc: Program to use for alignment of marker sequences.
    inputBinding:
      position: 103
      prefix: --aln-program
  - id: keep_tmp_files
    type:
      - 'null'
      - boolean
    doc: If not working from memory, keeps extracted alignments per sample on 
      disk.
    inputBinding:
      position: 103
      prefix: --keep-tmp-files
  - id: marker_dir
    type: Directory
    doc: Path to MetaPhlAn or mOTUs clade marker database.
    inputBinding:
      position: 103
      prefix: --marker-dir
  - id: marker_trunc_len
    type:
      - 'null'
      - int
    doc: Number of Nucleotides to be cut from each side of a marker.
    inputBinding:
      position: 103
      prefix: --marker-trunc-len
  - id: nprocs
    type:
      - 'null'
      - int
    doc: The number of processing units to use.
    inputBinding:
      position: 103
      prefix: --nprocs
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to output directory.
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: save_marker_aln
    type:
      - 'null'
      - boolean
    doc: Keep alignment files for individual markers.
    inputBinding:
      position: 103
      prefix: --save-marker-aln
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Path to temporary directory
    inputBinding:
      position: 103
      prefix: --tmp-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samestr:1.2025.111--pyhdfd78af_0
stdout: samestr_extract.out
