cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fpcat
label: chemfp_fpcat
doc: "Combine multiple fingerprint files into a single file.\n\nTool homepage: https://chemfp.com"
inputs:
  - id: filename
    type:
      - 'null'
      - type: array
        items: File
    doc: 'input fingerprint filenames (default: use stdin)'
    inputBinding:
      position: 10
  - id: in_format
    type:
      - 'null'
      - string
    doc: input fingerprint format. One of fps or fps.gz. (default guesses from 
      filename or is fps)
    inputBinding:
      position: 1
      prefix: --in
  - id: merge
    type:
      - 'null'
      - boolean
    doc: assume the input fingerprint files are in popcount order and do a 
      merge sort
    inputBinding:
      position: 1
      prefix: --merge
  - id: output_filename
    type: string
    doc: save the fingerprints to FILENAME
    default: combined.fps
    inputBinding:
      position: 1
      prefix: --output
  - id: out_format
    type:
      - 'null'
      - string
    doc: output fingerprint format. One of fps or fps.gz. (default guesses from
      output filename, or is 'fps')
    inputBinding:
      position: 1
      prefix: --out
  - id: reorder
    type:
      - 'null'
      - boolean
    doc: reorder the output fingerprints by popcount
    inputBinding:
      position: 1
      prefix: --reorder
  - id: preserve_order
    type:
      - 'null'
      - boolean
    doc: save the output fingerprints in the same order as the input (default 
      for FPS output)
    inputBinding:
      position: 1
      prefix: --preserve-order
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: show progress
    inputBinding:
      position: 1
      prefix: --show-progress
outputs:
  - id: fingerprints
    type: File
    doc: combined fingerprint file
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
