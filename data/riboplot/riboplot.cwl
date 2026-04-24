cwlVersion: v1.2
class: CommandLineTool
baseCommand: riboplot.py
label: riboplot
doc: "Plot and output read counts for a single transcript\n\nTool homepage: https://github.com/hsinyenwu/RiboPlotR"
inputs:
  - id: color_scheme
    type:
      - 'null'
      - string
    doc: 'Color scheme to use (default: default)'
    inputBinding:
      position: 101
      prefix: --color_scheme
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Flag. Produce debug output
    inputBinding:
      position: 101
      prefix: --debug
  - id: read_lengths
    type:
      - 'null'
      - string
    doc: 'Read lengths to consider (default: 0). Multiple read lengths should be separated
      by commas. If multiple read lengths are specified, corresponding read offsets
      should also be specified. If you do not wish to apply an offset, please input
      0 for the corresponding read length'
    inputBinding:
      position: 101
      prefix: --read_lengths
  - id: read_offsets
    type:
      - 'null'
      - string
    doc: 'Read offsets (default: 0). Multiple read offsets should be separated by
      commas'
    inputBinding:
      position: 101
      prefix: --read_offsets
  - id: ribo_file
    type: File
    doc: Ribo-Seq alignment file in BAM format
    inputBinding:
      position: 101
      prefix: --ribo_file
  - id: rna_file
    type:
      - 'null'
      - File
    doc: RNA-Seq alignment file (BAM)
    inputBinding:
      position: 101
      prefix: --rna_file
  - id: transcript_name
    type: string
    doc: Transcript name
    inputBinding:
      position: 101
      prefix: --transcript_name
  - id: transcriptome_fasta
    type: File
    doc: FASTA format file of the transcriptome
    inputBinding:
      position: 101
      prefix: --transcriptome_fasta
outputs:
  - id: html_file
    type:
      - 'null'
      - File
    doc: Output file for results (HTML)
    outputBinding:
      glob: $(inputs.html_file)
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: Files are saved in this directory
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboplot:0.3.1--py27_0
