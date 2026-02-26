cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyjess
label: pyjess
doc: "PyJess - Optimized Python bindings to Jess, a 3D template matching software.\n\
  \nTool homepage: https://github.com/althonos/pyjess"
inputs:
  - id: best_match
    type:
      - 'null'
      - boolean
    doc: Return only the best match for each template/query pair.
    default: false
    inputBinding:
      position: 101
      prefix: --best-match
  - id: distance_cutoff
    type: float
    doc: The distance-cutoff.
    default: None
    inputBinding:
      position: 101
      prefix: --distance-cutoff
  - id: filenames
    type:
      - 'null'
      - boolean
    doc: Show PDB filenames in progress on stderr
    default: false
    inputBinding:
      position: 101
      prefix: --filenames
  - id: ignore_chain
    type:
      - 'null'
      - boolean
    doc: Include matches composed of residues belonging to multiple chains (if 
      template is single-chain) or matches with residues from a single chain (if
      template has residues from multiple chains).
    default: false
    inputBinding:
      position: 101
      prefix: --ignore-chain
  - id: ignore_endmdl
    type:
      - 'null'
      - boolean
    doc: Parse atoms from all models separated by ENDMDL (use with care).
    default: false
    inputBinding:
      position: 101
      prefix: --ignore-endmdl
  - id: ignore_res_chain
    type:
      - 'null'
      - boolean
    doc: Include matches composed of residues belonging to multiple chains but 
      still enforce all atoms of a residue to be part of the same chain.
    default: false
    inputBinding:
      position: 101
      prefix: --ignore-res-chain
  - id: jobs
    type:
      - 'null'
      - int
    doc: The number of jobs to use for multithreading.
    default: 20
    inputBinding:
      position: 101
      prefix: --jobs
  - id: max_candidates
    type:
      - 'null'
      - int
    doc: Set a maximum number of candidates to return by template.
    default: None
    inputBinding:
      position: 101
      prefix: --max-candidates
  - id: maximum_distance
    type: float
    doc: The maximum allowed template/query atom distance after adding the 
      global distance cutoff and the individual atom distance cutoff defined in 
      the temperature field of the ATOM record in the template file.
    default: None
    inputBinding:
      position: 101
      prefix: --maximum-distance
  - id: no_reorder
    type:
      - 'null'
      - boolean
    doc: Disable template atom reordering in the matching process, useful to 
      enforce results to be returned exactly in the same order as the original 
      Jess, at the cost of longer runtimes.
    default: true
    inputBinding:
      position: 101
      prefix: --no-reorder
  - id: no_transform
    type:
      - 'null'
      - boolean
    doc: Do not transform coordinates of hit into the template coordinate frame
    default: true
    inputBinding:
      position: 101
      prefix: --no-transform
  - id: queries
    type: File
    doc: The path to the query list file.
    default: None
    inputBinding:
      position: 101
      prefix: --queries
  - id: query_filename
    type:
      - 'null'
      - boolean
    doc: Write filename of query instead of PDB ID from HEADER
    default: false
    inputBinding:
      position: 101
      prefix: --query-filename
  - id: rmsd
    type: float
    doc: The RMSD threshold.
    default: None
    inputBinding:
      position: 101
      prefix: --rmsd
  - id: templates
    type: File
    doc: The path to the template list file.
    default: None
    inputBinding:
      position: 101
      prefix: --templates
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyjess:0.9.1--py310h1fe012e_0
stdout: pyjess.out
