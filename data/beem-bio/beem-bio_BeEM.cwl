cwlVersion: v1.2
class: CommandLineTool
baseCommand: beem-bio_BeEM
label: beem-bio_BeEM
doc: "convert PDBx/mmCIF format input file 'input.cif' to Best Effort/Minimal PDB
  files. Output results to *-pdb-bundle*\n\nTool homepage: https://github.com/kad-ecoli/BeEM"
inputs:
  - id: input_cif
    type: File
    doc: PDBx/mmCIF format input file
    inputBinding:
      position: 1
  - id: ccd5_handling
    type:
      - 'null'
      - string
    doc: how to handle expanded chemical component ID >3 characters
    inputBinding:
      position: 102
      prefix: -ccd5
  - id: chain_id_map_format
    type:
      - 'null'
      - string
    doc: format of chain ID mapping file
    inputBinding:
      position: 102
      prefix: -idmap
  - id: chains_to_output
    type:
      - 'null'
      - type: array
        items: string
    doc: "comma seperated list of chains to output\n                     default is
      to output all chains"
    inputBinding:
      position: 102
      prefix: -chain
  - id: convert_dbref
    type:
      - 'null'
      - int
    doc: whether to convert dbref record
    inputBinding:
      position: 102
      prefix: -dbref
  - id: convert_seqres
    type:
      - 'null'
      - int
    doc: whether to convert SEQRES record
    inputBinding:
      position: 102
      prefix: -seqres
  - id: gzip_compression
    type:
      - 'null'
      - int
    doc: whether to perform gzip compression
    inputBinding:
      position: 102
      prefix: -gzip
  - id: max_atoms
    type:
      - 'null'
      - int
    doc: "maximum number of atoms in a file. default is 99999.\n                 \
      \    no limit on number of atoms if maxatom<=0"
    inputBinding:
      position: 102
      prefix: -maxatom
  - id: output_format
    type:
      - 'null'
      - int
    doc: output format
    inputBinding:
      position: 102
      prefix: -outfmt
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix of output file.
    inputBinding:
      position: 102
      prefix: -p
  - id: uppercase_header
    type:
      - 'null'
      - int
    doc: whether to convert PDB header text to upper case
    inputBinding:
      position: 102
      prefix: -upper
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beem-bio:1.0.1--h9948957_0
stdout: beem-bio_BeEM.out
