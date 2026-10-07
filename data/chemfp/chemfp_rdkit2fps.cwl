cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdkit2fps
label: chemfp_rdkit2fps
doc: "Generate FPS fingerprints from a structure file using RDKit\n\nTool homepage:
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
  - id: fp_size
    type:
      - 'null'
      - int
    doc: number of bits in the fingerprint. Default of 2048 for RDK, Morgan, 
      topological torsion, atom pair, and pattern fingerprints, and 512 for 
      Avalon fingerprints
    inputBinding:
      position: 1
      prefix: --fpSize
  - id: rdk
    type:
      - 'null'
      - boolean
    doc: generate RDK fingerprints (default)
    inputBinding:
      position: 1
      prefix: --RDK
  - id: min_path
    type:
      - 'null'
      - int
    doc: minimum number of bonds to include in the subgraph (default=1)
    inputBinding:
      position: 1
      prefix: --minPath
  - id: max_path
    type:
      - 'null'
      - int
    doc: maximum number of bonds to include in the subgraph (default=7)
    inputBinding:
      position: 1
      prefix: --maxPath
  - id: n_bits_per_hash
    type:
      - 'null'
      - int
    doc: number of bits to set per path (default=2)
    inputBinding:
      position: 1
      prefix: --nBitsPerHash
  - id: use_hs
    type:
      - 'null'
      - int
    doc: include information about the number of hydrogens on each atom (0|1, 
      default=1)
    inputBinding:
      position: 1
      prefix: --useHs
  - id: morgan
    type:
      - 'null'
      - boolean
    doc: generate Morgan fingerprints
    inputBinding:
      position: 1
      prefix: --morgan
  - id: radius
    type:
      - 'null'
      - int
    doc: radius for the Morgan algorithm (default=2)
    inputBinding:
      position: 1
      prefix: --radius
  - id: use_features
    type:
      - 'null'
      - int
    doc: use chemical-feature invariants (0|1, default=0)
    inputBinding:
      position: 1
      prefix: --useFeatures
  - id: use_chirality
    type:
      - 'null'
      - int
    doc: include chirality information (0|1, default=0)
    inputBinding:
      position: 1
      prefix: --useChirality
  - id: use_bond_types
    type:
      - 'null'
      - int
    doc: include bond type information (0|1, default=1)
    inputBinding:
      position: 1
      prefix: --useBondTypes
  - id: torsions
    type:
      - 'null'
      - boolean
    doc: generate Topological Torsion fingerprints
    inputBinding:
      position: 1
      prefix: --torsions
  - id: target_size
    type:
      - 'null'
      - int
    doc: number of bits in the fingerprint (default=4)
    inputBinding:
      position: 1
      prefix: --targetSize
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: generate Atom Pair fingerprints
    inputBinding:
      position: 1
      prefix: --pairs
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimum bond count for a pair (default=1)
    inputBinding:
      position: 1
      prefix: --minLength
  - id: max_length
    type:
      - 'null'
      - int
    doc: maximum bond count for a pair (default=30)
    inputBinding:
      position: 1
      prefix: --maxLength
  - id: maccs166
    type:
      - 'null'
      - boolean
    doc: generate MACCS fingerprints
    inputBinding:
      position: 1
      prefix: --maccs166
  - id: avalon
    type:
      - 'null'
      - boolean
    doc: generate Avalon fingerprints
    inputBinding:
      position: 1
      prefix: --avalon
  - id: is_query
    type:
      - 'null'
      - int
    doc: is the fingerprint for a query structure? (1 if yes, 0 if no) 
      (default=0)
    inputBinding:
      position: 1
      prefix: --isQuery
  - id: bit_flags
    type:
      - 'null'
      - int
    doc: bit flags, SSSBits are 32767 and similarity bits are 15761407 
      (default=15761407)
    inputBinding:
      position: 1
      prefix: --bitFlags
  - id: pattern
    type:
      - 'null'
      - boolean
    doc: generate (substructure) pattern fingerprints
    inputBinding:
      position: 1
      prefix: --pattern
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
    doc: generate 166 bit RDKit/MACCS fingerprints (version 2)
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
  - id: from_atoms
    type:
      - 'null'
      - string
    doc: fingerprint generation must use these atom indices (INT,INT,...; out 
      of range indices are ignored)
    inputBinding:
      position: 1
      prefix: --from-atoms
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
    doc: input structure format (default guesses from filename)
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
