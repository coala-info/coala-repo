cwlVersion: v1.2
class: CommandLineTool
baseCommand: osra
label: osra
doc: "OSRA: Optical Structure Recognition Application, created by Igor Filippov, 2013\n\
  \nTool homepage: http://cactus.nci.nih.gov/osra/"
inputs:
  - id: input_filename
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: adaptive_thresholding
    type:
      - 'null'
      - boolean
    doc: Adaptive thresholding pre-processing, useful for low light/low contrast
      images
    inputBinding:
      position: 102
      prefix: --adaptive
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print out debug information on spelling corrections
    inputBinding:
      position: 102
      prefix: --debug
  - id: dimensions
    type:
      - 'null'
      - string
    doc: Resize image on output
    inputBinding:
      position: 102
      prefix: --size
  - id: embedded_format
    type:
      - 'null'
      - string
    doc: Embedded format
    inputBinding:
      position: 102
      prefix: --embedded-format
  - id: ignore_rest
    type:
      - 'null'
      - boolean
    doc: Ignores the rest of the labeled arguments following this flag.
    inputBinding:
      position: 102
      prefix: --
  - id: invert_color
    type:
      - 'null'
      - boolean
    doc: Invert color (white on black)
    inputBinding:
      position: 102
      prefix: --negate
  - id: jaggy_thinning
    type:
      - 'null'
      - boolean
    doc: Additional thinning/scaling down of low quality documents
    inputBinding:
      position: 102
      prefix: --jaggy
  - id: learn
    type:
      - 'null'
      - boolean
    doc: Print out all structure guesses with confidence parameters
    inputBinding:
      position: 102
      prefix: --learn
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format
    inputBinding:
      position: 102
      prefix: --format
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Write recognized structures to image files with given prefix
    inputBinding:
      position: 102
      prefix: --output
  - id: preview_filename
    type:
      - 'null'
      - File
    doc: Preview Image
    inputBinding:
      position: 102
      prefix: --preview
  - id: print_confidence_estimate
    type:
      - 'null'
      - boolean
    doc: Print out confidence estimate
    inputBinding:
      position: 102
      prefix: --print
  - id: print_resolution_guess
    type:
      - 'null'
      - boolean
    doc: Print out resolution guess
    inputBinding:
      position: 102
      prefix: --guess
  - id: resolution
    type:
      - 'null'
      - string
    doc: Resolution in dots per inch
    inputBinding:
      position: 102
      prefix: --resolution
  - id: rotate_degrees
    type:
      - 'null'
      - int
    doc: Rotate image clockwise by specified number of degrees
    inputBinding:
      position: 102
      prefix: --rotate
  - id: show_average_bond_length
    type:
      - 'null'
      - boolean
    doc: Show average bond length in pixels (only for SDF/SMI/CAN output format)
    inputBinding:
      position: 102
      prefix: --bond
  - id: show_page_number
    type:
      - 'null'
      - boolean
    doc: Show page number for PDF/PS/TIFF documents (only for SDF/SMI/CAN output
      format)
    inputBinding:
      position: 102
      prefix: --page
  - id: show_surrounding_box_coordinates
    type:
      - 'null'
      - boolean
    doc: Show surrounding box coordinates (only for SDF/SMI/CAN output format)
    inputBinding:
      position: 102
      prefix: --coordinates
  - id: spelling_configfile
    type:
      - 'null'
      - File
    doc: Spelling correction dictionary
    inputBinding:
      position: 102
      prefix: --spelling
  - id: superatom_configfile
    type:
      - 'null'
      - File
    doc: Superatom label map to SMILES
    inputBinding:
      position: 102
      prefix: --superatom
  - id: threshold
    type:
      - 'null'
      - float
    doc: Gray level threshold
    inputBinding:
      position: 102
      prefix: --threshold
  - id: unpaper_rounds
    type:
      - 'null'
      - int
    doc: Pre-process image with unpaper algorithm, rounds
    inputBinding:
      position: 102
      prefix: --unpaper
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose and print the program flow
    inputBinding:
      position: 102
      prefix: --verbose
  - id: write_filename
    type:
      - 'null'
      - File
    doc: Write recognized structures to text file
    inputBinding:
      position: 102
      prefix: --write
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/osra:2.1.0--0
stdout: osra.out
