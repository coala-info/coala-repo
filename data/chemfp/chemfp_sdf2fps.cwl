cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sdf2fps
label: chemfp_sdf2fps
doc: "Extract a fingerprint tag from an SD file and generate FPS fingerprints\n\n\
  Tool homepage: https://chemfp.com"
inputs:
  - id: filenames
    type:
      - 'null'
      - type: array
        items: File
    doc: input SD files (default is stdin)
    inputBinding:
      position: 10
  - id: id_tag
    type:
      - 'null'
      - string
    doc: get the record id from TAG instead of the first line of the record
    inputBinding:
      position: 1
      prefix: --id-tag
  - id: fp_tag
    type:
      - 'null'
      - string
    doc: get the fingerprint from tag TAG (required unless a shortcut such as 
      --pubchem sets it)
    inputBinding:
      position: 1
      prefix: --fp-tag
  - id: in_format
    type:
      - 'null'
      - string
    doc: Specify if the input SD file is uncompressed or gzip compressed
    inputBinding:
      position: 1
      prefix: --in
  - id: num_bits
    type:
      - 'null'
      - int
    doc: use the first INT bits of the input. Use only when the last 1-7 bits 
      of the last byte are not part of the fingerprint.
    inputBinding:
      position: 1
      prefix: --num-bits
  - id: errors
    type:
      - 'null'
      - string
    doc: how should structure parse errors be handled? (strict, report, ignore;
      default=strict)
    inputBinding:
      position: 1
      prefix: --errors
  - id: output_filename
    type: string
    doc: save the fingerprints to FILENAME
    default: fingerprints.fps
    inputBinding:
      position: 1
      prefix: --output
  - id: out_format
    type:
      - 'null'
      - string
    doc: output structure format (default guesses from output filename, or is 
      'fps')
    inputBinding:
      position: 1
      prefix: --out
  - id: software
    type:
      - 'null'
      - string
    doc: use TEXT as the software description
    inputBinding:
      position: 1
      prefix: --software
  - id: fp_type
    type:
      - 'null'
      - string
    doc: use TEXT as the fingerprint type description
    inputBinding:
      position: 1
      prefix: --type
  - id: binary
    type:
      - 'null'
      - boolean
    doc: Encoded with the characters '0' and '1'. Bit #0 comes first.
    inputBinding:
      position: 1
      prefix: --binary
  - id: binary_msb
    type:
      - 'null'
      - boolean
    doc: Encoded with the characters '0' and '1'. Bit #0 comes last.
    inputBinding:
      position: 1
      prefix: --binary-msb
  - id: hex
    type:
      - 'null'
      - boolean
    doc: Hex encoded. Bit #0 is the first bit (1<<0) of the first byte.
    inputBinding:
      position: 1
      prefix: --hex
  - id: hex_lsb
    type:
      - 'null'
      - boolean
    doc: Hex encoded. Bit #0 is the eigth bit (1<<7) of the first byte.
    inputBinding:
      position: 1
      prefix: --hex-lsb
  - id: hex_msb
    type:
      - 'null'
      - boolean
    doc: Hex encoded. Bit #0 is the first bit (1<<0) of the last byte.
    inputBinding:
      position: 1
      prefix: --hex-msb
  - id: base64
    type:
      - 'null'
      - boolean
    doc: Base-64 encoded. Bit #0 is first bit (1<<0) of first byte.
    inputBinding:
      position: 1
      prefix: --base64
  - id: cactvs
    type:
      - 'null'
      - boolean
    doc: CACTVS encoding, based on base64 and includes a version and bit length
    inputBinding:
      position: 1
      prefix: --cactvs
  - id: daylight
    type:
      - 'null'
      - boolean
    doc: Daylight encoding, which is is base64 variant
    inputBinding:
      position: 1
      prefix: --daylight
  - id: decoder
    type:
      - 'null'
      - string
    doc: import and use the DECODER function to decode the fingerprint
    inputBinding:
      position: 1
      prefix: --decoder
  - id: pubchem
    type:
      - 'null'
      - boolean
    doc: decode CACTVS substructure keys used in PubChem (sets --software, 
      --type, --fp-tag=PUBCHEM_CACTVS_SUBSKEYS and --cactvs)
    inputBinding:
      position: 1
      prefix: --pubchem
outputs:
  - id: fingerprints
    type: File
    doc: FPS fingerprint file
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
