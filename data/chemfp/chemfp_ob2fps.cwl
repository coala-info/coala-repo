cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ob2fps
label: chemfp_ob2fps
doc: "Generate FPS fingerprints from a structure file using Open Babel\n\nTool homepage:
  https://chemfp.com"
inputs:
  - id: filenames
    type:
      - 'null'
      - type: array
        items: File
    doc: input structure files (default is stdin)
    inputBinding:
      position: 10
  - id: fp2
    type:
      - 'null'
      - boolean
    doc: linear fragments up to 7 atoms
    inputBinding:
      position: 1
      prefix: --FP2
  - id: fp3
    type:
      - 'null'
      - boolean
    doc: SMARTS patterns specified in the file patterns.txt
    inputBinding:
      position: 1
      prefix: --FP3
  - id: fp4
    type:
      - 'null'
      - boolean
    doc: SMARTS patterns specified in the file SMARTS_InteLigand.txt
    inputBinding:
      position: 1
      prefix: --FP4
  - id: maccs
    type:
      - 'null'
      - boolean
    doc: Open Babel's implementation of the MACCS 166 keys
    inputBinding:
      position: 1
      prefix: --MACCS
  - id: substruct
    type:
      - 'null'
      - boolean
    doc: generate ChemFP substructure fingerprints
    inputBinding:
      position: 1
      prefix: --substruct
  - id: rdmaccs
    type:
      - 'null'
      - boolean
    doc: 166 bit RDKit/MACCS fingerprints (version 2)
    inputBinding:
      position: 1
      prefix: --rdmaccs
  - id: rdmaccs_v1
    type:
      - 'null'
      - boolean
    doc: use the version 1 definition for --rdmaccs
    inputBinding:
      position: 1
      prefix: --rdmaccs/1
  - id: id_tag
    type:
      - 'null'
      - string
    doc: tag name containing the record id (SD files only)
    inputBinding:
      position: 1
      prefix: --id-tag
  - id: in_format
    type:
      - 'null'
      - string
    doc: input structure format (default autodetects from the filename 
      extension)
    inputBinding:
      position: 1
      prefix: --in
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
  - id: errors
    type:
      - 'null'
      - string
    doc: how should structure parse errors be handled? (strict, report, ignore;
      default=ignore)
    inputBinding:
      position: 1
      prefix: --errors
outputs:
  - id: fingerprints
    type: File
    doc: FPS fingerprint file
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
