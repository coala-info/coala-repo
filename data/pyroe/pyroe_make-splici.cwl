cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyroe
  - make-spliced+intronic
label: pyroe_make-splici
doc: "Make spliced + intronic (splici) reference.\n\nTool homepage: https://github.com/COMBINE-lab/pyroe"
inputs:
  - id: genome_path
    type: File
    doc: The path to a genome fasta file.
    inputBinding:
      position: 1
  - id: gtf_path
    type: File
    doc: The path to a gtf file.
    inputBinding:
      position: 2
  - id: read_length
    type: int
    doc: The read length of the single-cell experiment being processed (determines flank size).
    inputBinding:
      position: 3
  - id: output_dir
    type: string
    doc: The output directory where the reference files will be written.
    inputBinding:
      position: 4
  - id: filename_prefix
    type:
      - 'null'
      - string
    doc: The file name prefix of the generated output files.
    inputBinding:
      position: 101
      prefix: --filename-prefix
  - id: flank_trim_length
    type:
      - 'null'
      - int
    doc: Determines the amount subtracted from the read length to get the flank length.
    inputBinding:
      position: 101
      prefix: --flank-trim-length
  - id: extra_spliced
    type:
      - 'null'
      - File
    doc: The path to an extra spliced sequence fasta file.
    inputBinding:
      position: 101
      prefix: --extra-spliced
  - id: extra_unspliced
    type:
      - 'null'
      - File
    doc: The path to an extra unspliced sequence fasta file.
    inputBinding:
      position: 101
      prefix: --extra-unspliced
  - id: bt_path
    type:
      - 'null'
      - string
    doc: The path to bedtools v2.30.0 or greater.
    inputBinding:
      position: 101
      prefix: --bt-path
  - id: no_bt
    type:
      - 'null'
      - boolean
    doc: A flag indicates whether bedtools will be used for generating the reference files.
    inputBinding:
      position: 101
      prefix: --no-bt
  - id: dedup_seqs
    type:
      - 'null'
      - boolean
    doc: A flag indicates whether identical sequences will be deduplicated.
    inputBinding:
      position: 101
      prefix: --dedup-seqs
  - id: no_flanking_merge
    type:
      - 'null'
      - boolean
    doc: A flag indicates whether flank lengths will be considered when merging introns.
    inputBinding:
      position: 101
      prefix: --no-flanking-merge
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type: Directory
    doc: Output directory with the reference files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyroe:0.9.3--pyhdfd78af_0
stdout: pyroe_make-splici.out
