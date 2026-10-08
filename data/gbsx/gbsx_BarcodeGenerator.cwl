cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gbsx
  - --BarcodeGenerator
label: gbsx_BarcodeGenerator
doc: "GBSX Barcode Generator v1.0: generates a given number of random self-correcting barcodes (Hamming distance of at least 3).\n\nTool homepage: https://github.com/GenomicsCoreLeuven/GBSX"
inputs:
  - id: barcode_count
    type: int
    doc: "The number of barcodes needed"
    inputBinding:
      position: 101
      prefix: -b
  - id: enzyme
    type: string
    doc: "The enzyme used for the experiment"
    inputBinding:
      position: 101
      prefix: -e
  - id: enzyme_file
    type:
      - 'null'
      - File
    doc: "Enzyme file that adds new enzymes: tab-delimited, enzyme name then cut sites separated by commas"
    inputBinding:
      position: 101
      prefix: -ef
  - id: bootstraps
    type:
      - 'null'
      - int
    doc: "Maximum number of bootstraps to run (standard 10000); each bootstrap makes a new design and the best one is kept"
    inputBinding:
      position: 101
      prefix: -nb
  - id: barcode_tries
    type:
      - 'null'
      - int
    doc: "Number of tries with a new random barcode before restarting the bootstrap (standard 20)"
    inputBinding:
      position: 101
      prefix: -bt
  - id: out_dir
    type:
      - 'null'
      - string
    doc: "The output directory (standard: the current working directory)"
    inputBinding:
      position: 101
      prefix: -o
  - id: ultimate_match
    type:
      - 'null'
      - boolean
    doc: "Try to find the best barcode combination with the best base distribution, and continue even when the right number of barcodes is found (standard false)"
    inputBinding:
      position: 101
      prefix: -us
      valueFrom: '$(self === null ? null : (self ? "true" : "false"))'
  - id: basic_set_file
    type:
      - 'null'
      - File
    doc: "File with barcodes that are used as the basic set (one of the possible output files)"
    inputBinding:
      position: 101
      prefix: -bf
  - id: not_allowed_file
    type:
      - 'null'
      - File
    doc: "File with barcodes that may not be used in the design"
    inputBinding:
      position: 101
      prefix: -nf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory with the generated barcode files
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbsx:1.3--0
stdout: gbsx_BarcodeGenerator.out
