cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ost
  - compare-structures-legacy
label: openstructure_compare_structures_legacy
doc: "Legacy model-versus-reference comparison (LDDT, QS-score) with optional molck cleaning.\n\nTool homepage: https://openstructure.org"
inputs:
  - id: model
    type: File
    doc: "Path to the model file."
    inputBinding:
      position: 101
      prefix: "--model"
  - id: reference
    type: File
    doc: "Path to the reference file. general arguments:"
    inputBinding:
      position: 101
      prefix: "--reference"
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Set verbosity level. Defaults to 3."
    inputBinding:
      position: 101
      prefix: "--verbosity"
  - id: output
    type:
      - 'null'
      - string
    doc: "Output file name. The output will be saved as a JSON file."
    default: "out.json"
    inputBinding:
      position: 101
      prefix: "--output"
  - id: dump_structures
    type:
      - 'null'
      - boolean
    doc: "Dump cleaned structures used to calculate all the scores as PDB files using specified suffix. Files will be dumped to the same location as original files."
    inputBinding:
      position: 101
      prefix: "--dump-structures"
  - id: dump_suffix
    type:
      - 'null'
      - string
    doc: "Use this suffix to dump structures. Defaults to .compare.structures.pdb."
    inputBinding:
      position: 101
      prefix: "--dump-suffix"
  - id: reference_selection
    type:
      - 'null'
      - string
    doc: "Selection performed on reference structures."
    inputBinding:
      position: 101
      prefix: "--reference-selection"
  - id: model_selection
    type:
      - 'null'
      - string
    doc: "Selection performed on model structures."
    inputBinding:
      position: 101
      prefix: "--model-selection"
  - id: c_alpha_only
    type:
      - 'null'
      - boolean
    doc: "Use C-alpha atoms only. Equivalent of calling the action with '--model-selection=\"aname=CA\" --reference-selection=\"aname=CA\"' options."
    inputBinding:
      position: 101
      prefix: "--c-alpha-only"
  - id: fault_tolerant
    type:
      - 'null'
      - boolean
    doc: "Fault tolerant parsing."
    inputBinding:
      position: 101
      prefix: "--fault-tolerant"
  - id: compound_library
    type:
      - 'null'
      - File
    doc: "Location of the compound library file (compounds.chemlib). If not provided, the following locations are searched in this order: 1. Working directory, 2. OpenStructure standard library location. molecular check arguments:"
    inputBinding:
      position: 101
      prefix: "--compound-library"
  - id: molck
    type:
      - 'null'
      - boolean
    doc: "Run molecular checker to clean up input."
    inputBinding:
      position: 101
      prefix: "--molck"
  - id: remove
    type:
      - 'null'
      - string[]
    doc: "Remove atoms and residues matching some criteria: * zeroocc - Remove atoms with zero occupancy * hyd - remove hydrogen atoms * oxt - remove terminal oxygens * nonstd - remove all residues not one of the 20 standard amino acids * unk - Remove unknown and atoms not following the nomenclature Defaults to hyd."
    inputBinding:
      position: 101
      prefix: "--remove"
  - id: clean_element_column
    type:
      - 'null'
      - boolean
    doc: "Clean up element column"
    inputBinding:
      position: 101
      prefix: "--clean-element-column"
  - id: map_nonstandard_residues
    type:
      - 'null'
      - boolean
    doc: "Map modified residues back to the parent amino acid, for example MSE -> MET, SEP -> SER. structural check arguments:"
    inputBinding:
      position: 101
      prefix: "--map-nonstandard-residues"
  - id: structural_checks
    type:
      - 'null'
      - boolean
    doc: "Perform structural checks and filter input data."
    inputBinding:
      position: 101
      prefix: "--structural-checks"
  - id: parameter_file
    type:
      - 'null'
      - File
    doc: "Location of the stereochemical parameter file (stereo_chemical_props.txt). If not provided, the following locations are searched in this order: 1. Working directory, 2. OpenStructure standard library location."
    inputBinding:
      position: 101
      prefix: "--parameter-file"
  - id: bond_tolerance
    type:
      - 'null'
      - float
    doc: "Tolerance in STD for bonds. Defaults to 12."
    inputBinding:
      position: 101
      prefix: "--bond-tolerance"
  - id: angle_tolerance
    type:
      - 'null'
      - float
    doc: "Tolerance in STD for angles. Defaults to 12. chain mapping arguments:"
    inputBinding:
      position: 101
      prefix: "--angle-tolerance"
  - id: chain_mapping
    type:
      - 'null'
      - string[]
    doc: "Mapping of chains between the reference and the model. Each separate mapping consist of key:value pairs where key is the chain name in reference and value is the chain name in model."
    inputBinding:
      position: 101
      prefix: "--chain-mapping"
  - id: qs_max_mappings_extensive
    type:
      - 'null'
      - int
    doc: "Maximal number of chain mappings to test for 'extensive' chain mapping scheme which is used as a last resort if other schemes failed. The extensive chain mapping search must in the worst case check O(N!) possible mappings for complexes with N chains. Two octamers without symmetry would require 322560 mappings to be checked. To limit computations, no scores are computed if we try more than the maximal number of chain mappings. Defaults to 1000000. sequence alignment arguments:"
    inputBinding:
      position: 101
      prefix: "--qs-max-mappings-extensive"
  - id: consistency_checks
    type:
      - 'null'
      - boolean
    doc: "Take consistency checks into account. By default residue name consistency between a model-reference pair would be checked but only a warning message will be displayed and the script will continue to calculate scores. If this flag is ON, checks will not be ignored and if the pair does not pass the test all the scores for that pair will be marked as a FAILURE."
    inputBinding:
      position: 101
      prefix: "--consistency-checks"
  - id: residue_number_alignment
    type:
      - 'null'
      - boolean
    doc: "Make alignment based on residue number instead of using a global BLOSUM62-based alignment. QS score arguments:"
    inputBinding:
      position: 101
      prefix: "--residue-number-alignment"
  - id: qs_score
    type:
      - 'null'
      - boolean
    doc: "Calculate QS-score."
    inputBinding:
      position: 101
      prefix: "--qs-score"
  - id: qs_rmsd
    type:
      - 'null'
      - boolean
    doc: "Calculate CA RMSD between shared CA atoms of mapped chains. This uses a superposition using all mapped chains which minimizes the CA RMSD. lDDT score arguments:"
    inputBinding:
      position: 101
      prefix: "--qs-rmsd"
  - id: lddt
    type:
      - 'null'
      - boolean
    doc: "Calculate lDDT."
    inputBinding:
      position: 101
      prefix: "--lddt"
  - id: inclusion_radius
    type:
      - 'null'
      - float
    doc: "Distance inclusion radius for lDDT. Defaults to 15 A."
    inputBinding:
      position: 101
      prefix: "--inclusion-radius"
  - id: sequence_separation
    type:
      - 'null'
      - int
    doc: "Sequence separation. Only distances between residues whose separation is higher than the provided parameter are considered when computing the score. Defaults to 0."
    inputBinding:
      position: 101
      prefix: "--sequence-separation"
outputs:
  - id: result
    type: File
    doc: "Comparison result"
    outputBinding:
      glob: $(inputs.output)
  - id: dumped_structures
    type: File[]
    doc: "Cleaned structures written with --dump-structures"
    outputBinding:
      glob: "*.pdb"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openstructure:2.11.1--py310h1f7f436_0
