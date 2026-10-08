cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gget
  - pdb
label: gget_pdb
doc: 'Query RCSB PDB for the protein structutre/metadata of a given PDB ID.


  Tool homepage: https://github.com/pachterlab/gget'
inputs:
  - id: pdb_id
    type: string
    doc: PDB ID to be queried, e.g. '7S7U'.
    inputBinding:
      position: 1
  - id: identifier
    type:
      - 'null'
      - string
    doc: 'Can be used to define assembly, entity or chain ID if applicable (default:
      None). Assembly/entity IDs are numbers (e.g. 1), and chain IDs are letters (e.g.
      A).'
    inputBinding:
      position: 102
      prefix: --identifier
  - id: resource
    type:
      - 'null'
      - string
    doc: 'Defines type of information to be returned: pdb (default), entry, pubmed,
      assembly, branched_entity, nonpolymer_entity, polymer_entity, uniprot, branched_entity_instance,
      polymer_entity_instance or nonpolymer_entity_instance. Resource ''pdb'' is returned
      in PDB format; all others in JSON.'
    inputBinding:
      position: 102
      prefix: --resource
  - id: out_path
    type: string
    default: results.pdb
    doc: Path to the file the results will be saved in, e.g. path/to/directory/7S7U.pdb
      or path/to/directory/7S7U_entry.json. Resource 'pdb' is returned in PDB format.
      All other resources are returned in JSON format.
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Structure (PDB format) or metadata (JSON).
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
