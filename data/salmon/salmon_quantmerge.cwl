cwlVersion: v1.2
class: CommandLineTool
baseCommand: salmon_quantmerge
label: salmon_quantmerge
doc: "Merge multiple quantification results into a single file.\n\nTool homepage:
  https://github.com/COMBINE-lab/salmon"
inputs:
  - id: column
    type:
      - 'null'
      - string
    doc: The name of the column that will be merged together into the output 
      files. The options are {len, elen, tpm, numreads}
    default: TPM
    inputBinding:
      position: 101
      prefix: --column
  - id: genes
    type:
      - 'null'
      - boolean
    doc: Use gene quantification instead of transcript.
    inputBinding:
      position: 101
      prefix: --genes
  - id: missing
    type:
      - 'null'
      - string
    doc: The value of missing values.
    default: NA
    inputBinding:
      position: 101
      prefix: --missing
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional list of names to give to the samples.
    inputBinding:
      position: 101
      prefix: --names
  - id: quants
    type:
      - 'null'
      - type: array
        items: string
    doc: List of quantification directories.
    inputBinding:
      position: 101
      prefix: --quants
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output quantification file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/salmon:1.10.3--h45fbf2d_5
