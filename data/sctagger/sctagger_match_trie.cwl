cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scTagger.py, match_trie]
label: sctagger_match_trie
doc: "Match long-read barcode segments with the selected short-read barcodes\n\nTool homepage: https://github.com/vpc-ccg/sctagger"
inputs:
  - id: long_read_segments
    type: File
    doc: "Long-read segments TSV file"
    inputBinding:
      prefix: -lr
  - id: short_read_barcodes
    type: File
    doc: "Short-read barcode list TSV file"
    inputBinding:
      prefix: -sr
  - id: max_error
    type: ['null', int]
    doc: "Maximum number of errors allowed for barcode matching. Default: 2"
    inputBinding:
      prefix: -mr
  - id: mem
    type: ['null', double]
    doc: "Maximum number of GB of RAM to be used. Default: 16.0"
    inputBinding:
      prefix: -m
  - id: barcode_length
    type: ['null', int]
    doc: "Length of barcodes. Default: 16"
    inputBinding:
      prefix: -bl
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for searching. Default: 16"
    inputBinding:
      prefix: -t
  - id: plotfile
    type: ['null', string]
    doc: "Path of plot file. Default: no plotting"
    inputBinding:
      prefix: -p
  - id: outfile
    type: ['null', string]
    doc: "Path to output file. Output file is gzipped. Default: stdout"
    inputBinding:
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (used when no output file is given)
  - id: output_file
    type: ['null', File]
    doc: Output file written with the output option
    outputBinding:
      glob: $(inputs.outfile)
  - id: plot_file
    type: ['null', File]
    doc: Plot file written with the plot option
    outputBinding:
      glob: $(inputs.plotfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sctagger:1.1.1--hdfd78af_0
stdout: sctagger_match_trie.out
