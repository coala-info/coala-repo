cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scTagger.py, extract_lr_bc]
label: sctagger_extract_lr_bc
doc: "Extract from long reads the segment where a cellular barcode is most likely to be found (after the short-read adapter)\n\nTool homepage: https://github.com/vpc-ccg/sctagger"
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: "Paths to reads in FASTQ"
    inputBinding:
      prefix: -r
  - id: ranges
    type:
      - 'null'
      - type: array
        items: string
    doc: "Ranges of where the short-read adapter should be found on the long reads, each starting with \"f\" or \"r\" for the read side (e.g. f20:40 r1:30). Default: detect from data."
    inputBinding:
      prefix: -g
  - id: gzipped
    type: ['null', boolean]
    doc: "Indicate input is gzipped. Default: assume input is gzipped if it ends with \".gz\"."
    inputBinding:
      prefix: -z
  - id: threads
    type: ['null', int]
    doc: "Number of threads. Default: 1"
    inputBinding:
      prefix: -t
  - id: short_read_adapter
    type: ['null', string]
    doc: "Short-read adapter. Default: CTACACGACGCTCTTCCGATCT"
    inputBinding:
      prefix: -sa
  - id: outfile
    type: ['null', string]
    doc: "Path to output file. Output file is gzipped. Default: stdout"
    inputBinding:
      prefix: -o
  - id: plotfile
    type: ['null', string]
    doc: "Path to plot file. Default: no plotting"
    inputBinding:
      prefix: -p
  - id: num_bp_after
    type: ['null', int]
    doc: "Number of bases after the end of the short-read adapter alignment to generate. Default: 20"
    inputBinding:
      prefix: --num-bp-after
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
stdout: sctagger_extract_lr_bc.out
