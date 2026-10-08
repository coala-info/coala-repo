cwlVersion: v1.2
class: CommandLineTool
baseCommand: fpocket
label: fpocket
doc: "fpocket is a very fast open source protein pocket detection algorithm based on Voronoi tessellation.\n\nTool homepage: https://github.com/Discngine/fpocket"
inputs:
  - id: input_pdb
    type:
      - 'null'
      - File
    doc: "PDB or mmCIF file to analyze (mandatory unless a file list is given)"
    inputBinding:
      position: 101
      prefix: -f
  - id: file_list
    type:
      - 'null'
      - File
    doc: "File that lists the PDB files to process (give the listed files in listed_files so that they are staged)"
    inputBinding:
      position: 101
      prefix: -F
  - id: calculate_interaction_grids
    type:
      - 'null'
      - boolean
    doc: "Calculate VdW and Coulomb grids for each pocket"
    inputBinding:
      position: 101
      prefix: -x
  - id: pocket_descr_stdout
    type:
      - 'null'
      - boolean
    doc: "Write the fpocket descriptors to the standard output"
    inputBinding:
      position: 101
      prefix: -d
  - id: model_number
    type:
      - 'null'
      - int
    doc: "Number of the model to analyze"
    inputBinding:
      position: 101
      prefix: -l
  - id: topology_file
    type:
      - 'null'
      - File
    doc: "Topology file (Amber prmtop)"
    inputBinding:
      position: 101
      prefix: -y
  - id: custom_ligand
    type:
      - 'null'
      - string
    doc: "String specifying a ligand like residuenumber:residuename:chain_code (for example 1224:PU8:A)"
    inputBinding:
      position: 101
      prefix: -r
  - id: chain_as_ligand
    type:
      - 'null'
      - string
    doc: "Character specifying a chain to consider as a ligand"
    inputBinding:
      position: 101
      prefix: -a
  - id: min_sphere_radius
    type:
      - 'null'
      - float
    doc: "Minimum radius of an alpha-sphere (default 3.4)"
    inputBinding:
      position: 101
      prefix: -m
  - id: max_sphere_radius
    type:
      - 'null'
      - float
    doc: "Maximum radius of an alpha-sphere (default 6.2)"
    inputBinding:
      position: 101
      prefix: -M
  - id: clustering_distance
    type:
      - 'null'
      - float
    doc: "Distance threshold for the clustering algorithm (default 2.4)"
    inputBinding:
      position: 101
      prefix: -D
  - id: clustering_method
    type:
      - 'null'
      - string
    doc: "Clustering method for grouping Voronoi vertices: s single linkage, m complete linkage, a average linkage, c centroid linkage (default s)"
    inputBinding:
      position: 101
      prefix: -C
  - id: clustering_measure
    type:
      - 'null'
      - string
    doc: "Distance measure for clustering: e euclidean, b Manhattan (default e)"
    inputBinding:
      position: 101
      prefix: -e
  - id: min_alpha_spheres
    type:
      - 'null'
      - int
    doc: "Minimum number of alpha-spheres per pocket (default 15)"
    inputBinding:
      position: 101
      prefix: -i
  - id: ratio_apol_spheres_pocket
    type:
      - 'null'
      - float
    doc: "Minimum proportion of apolar spheres in a pocket (default 0.0)"
    inputBinding:
      position: 101
      prefix: -p
  - id: number_apol_asph_pocket
    type:
      - 'null'
      - int
    doc: "Minimum number of apolar neighbors for an alpha-sphere to be considered apolar (default 3)"
    inputBinding:
      position: 101
      prefix: -A
  - id: iterations_volume_mc
    type:
      - 'null'
      - int
    doc: "Number of Monte-Carlo iterations for the calculation of each pocket volume (default 300)"
    inputBinding:
      position: 101
      prefix: -v
  - id: drop_chains
    type:
      - 'null'
      - string
    doc: "Chains to delete before pocket detection, up to 20 (for example A,B,E)"
    inputBinding:
      position: 101
      prefix: -c
  - id: keep_chains
    type:
      - 'null'
      - string
    doc: "Chains to keep before pocket detection, up to 20 (for example A,B,C,E)"
    inputBinding:
      position: 101
      prefix: -k
  - id: write_mode
    type:
      - 'null'
      - string
    doc: "Writing mode after pocket detection: d default (same format as input), b or both, p or pdb, m or cif or mmcif"
    inputBinding:
      position: 101
      prefix: -w
  - id: listed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "The PDB files named in the file list; they are staged next to it so that the names resolve"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: output_dirs
    type:
      type: array
      items: Directory
    doc: "Output directories <name>_out written for each input file (pockets, PDB with pockets, info text file)"
    outputBinding:
      glob: '*_out'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_pdb)
        writable: true
      - $(inputs.file_list)
      - $(inputs.listed_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fpocket:4.0.0
stdout: fpocket.out
