cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi
  - contrast
label: fermi_contrast
doc: "Contrast two FMD-index based genomes.\n\nTool homepage: https://github.com/lh3/fermi"
inputs:
  - id: idx1_fmd
    type: File
    doc: First FMD-index file
    inputBinding:
      position: 1
  - id: idx1_rank
    type: File
    doc: First rank file
    inputBinding:
      position: 2
  - id: idx1_to_idx2_sub
    type: string
    doc: Name of the output bit array file (1-2.sub) marking reads of index 1 that are not supported by index 2
    inputBinding:
      position: 3
  - id: idx2_fmd
    type: File
    doc: Second FMD-index file
    inputBinding:
      position: 4
  - id: idx2_rank
    type: File
    doc: Second rank file
    inputBinding:
      position: 5
  - id: idx2_to_idx1_sub
    type: string
    doc: Name of the output bit array file (2-1.sub) marking reads of index 2 that are not supported by index 1
    inputBinding:
      position: 6
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length
    inputBinding:
      position: 107
      prefix: -k
  - id: min_occurrence
    type:
      - 'null'
      - int
    doc: minimum occurrence
    inputBinding:
      position: 107
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 107
      prefix: -t
outputs:
  - id: idx1_sub_array
    type: File
    doc: Bit array of the reads selected from the first index (written to the 1-2.sub file name)
    outputBinding:
      glob: $(inputs.idx1_to_idx2_sub)
  - id: idx2_sub_array
    type: File
    doc: Bit array of the reads selected from the second index (written to the 2-1.sub file name)
    outputBinding:
      glob: $(inputs.idx2_to_idx1_sub)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_contrast.out
