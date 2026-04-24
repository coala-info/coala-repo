cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamdam_combine
label: bamdam_combine
doc: "Combine multiple bamdam compute output TSV files into a single file.\n\nTool
  homepage: https://github.com/bdesanctis/bamdam"
inputs:
  - id: in_tsv
    type:
      type: array
      items: File
    doc: List of input tsv file(s)
    inputBinding:
      position: 101
      prefix: --in_tsv
  - id: in_tsv_list
    type: File
    doc: Path to a text file containing paths to input tsv files, one per line
    inputBinding:
      position: 101
      prefix: --in_tsv_list
  - id: include
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra metrics to include in output file. Specify any combination of 
      columns in your bamdam compute output files. TaxNodeID, TaxName, 
      TotalReads, Duplicity, MeanDust, Damage+1 and taxpath are always included.
    inputBinding:
      position: 101
      prefix: --include
  - id: minreads
    type:
      - 'null'
      - int
    doc: Minimum reads across samples to include a taxon
    inputBinding:
      position: 101
      prefix: --minreads
outputs:
  - id: out_tsv
    type:
      - 'null'
      - File
    doc: Path to output tsv file name
    outputBinding:
      glob: $(inputs.out_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamdam:0.4.3--pyhdfd78af_0
