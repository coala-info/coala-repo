cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python3
  - /usr/local/bin/ExtractCountFreqGenes.py
label: desman_ExtractCountFreqGenes.py
doc: "Build a DESMAN base frequency table (gene, position, then A,C,G,T counts per
  sample) for the genes or COGs listed in a location file, from a directory of
  per-sample bam-readcount files (*.cnt.gz).\n\nTool homepage: https://github.com/chrisquince/DESMAN"
inputs:
  - id: cog_file
    type: File
    doc: cogs and contig locations for frequencies to be called on 
      (cog,contig,start,end,gene,strand; or gene,contig,start,end,strand with 
      -g)
    inputBinding:
      position: 10
  - id: input_dir
    type: Directory
    doc: input directory to glob *.cnt.gz from
    inputBinding:
      position: 11
  - id: output_file
    type: string
    doc: Output frequency table
    default: Select_freq.csv
    inputBinding:
      position: 1
      prefix: --output_file
  - id: gene_file
    type:
      - 'null'
      - boolean
    doc: alternate input format
    inputBinding:
      position: 1
      prefix: -g
outputs:
  - id: freq_table
    type: File
    doc: Base frequency table (CSV)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/desman:2.1--py39h4747326_10
