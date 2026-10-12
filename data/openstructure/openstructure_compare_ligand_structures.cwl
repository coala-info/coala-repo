cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ost
  - compare-ligand-structures
label: openstructure_compare_ligand_structures
doc: "Compare ligand poses of a model against a reference (LDDT-PLI and ligand RMSD).\n\nTool homepage: https://openstructure.org"
inputs:
  - id: model
    type: File
    doc: "Path to model file."
    inputBinding:
      position: 101
      prefix: "--model"
  - id: model_ligands
    type:
      - 'null'
      - File[]
    doc: "Path to model ligand files."
    inputBinding:
      position: 101
      prefix: "--model-ligands"
  - id: reference
    type: File
    doc: "Path to reference file."
    inputBinding:
      position: 101
      prefix: "--reference"
  - id: reference_ligands
    type:
      - 'null'
      - File[]
    doc: "Path to reference ligand files."
    inputBinding:
      position: 101
      prefix: "--reference-ligands"
  - id: output
    type:
      - 'null'
      - string
    doc: "Output file name. Default depends on format: out.json or out.csv"
    default: "out.json"
    inputBinding:
      position: 101
      prefix: "--output"
  - id: model_format
    type:
      - 'null'
      - string
    doc: "Format of model file. pdb reads pdb but also pdb.gz, same applies to cif/mmcif. Inferred from filepath if not given."
    inputBinding:
      position: 101
      prefix: "--model-format"
  - id: ref_format
    type:
      - 'null'
      - string
    doc: "Format of reference file. pdb reads pdb but also pdb.gz, same applies to cif/mmcif. Inferred from filepath if not given."
    inputBinding:
      position: 101
      prefix: "--ref-format"
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output format, JSON or CSV, in lowercase. default: json"
    inputBinding:
      position: 101
      prefix: "--output-format"
  - id: by_model_ligand_output
    type:
      - 'null'
      - boolean
    doc: "For CSV output, this flag changes the output so that each line reports one model ligand, instead of a reference ligand. Has no effect with JSON output."
    inputBinding:
      position: 101
      prefix: "--by-model-ligand-output"
  - id: csv_extra_header
    type:
      - 'null'
      - string
    doc: "Extra header prefix for CSV output. This allows adding additional annotations (such as target ID, group, etc) to the output"
    inputBinding:
      position: 101
      prefix: "--csv-extra-header"
  - id: csv_extra_data
    type:
      - 'null'
      - string
    doc: "Additional data (columns) for CSV output."
    inputBinding:
      position: 101
      prefix: "--csv-extra-data"
  - id: model_biounit
    type:
      - 'null'
      - string
    doc: "Only has an effect if model is in mmcif format. By default, the asymmetric unit (AU) is used for scoring. If there are biounits defined in the mmcif file, you can specify the ID (as a string) of the one which should be used."
    inputBinding:
      position: 101
      prefix: "--model-biounit"
  - id: reference_biounit
    type:
      - 'null'
      - string
    doc: "Only has an effect if reference is in mmcif format. By default, the asymmetric unit (AU) is used for scoring. If there are biounits defined in the mmcif file, you can specify the ID (as a string) of the one which should be used."
    inputBinding:
      position: 101
      prefix: "--reference-biounit"
  - id: fault_tolerant
    type:
      - 'null'
      - boolean
    doc: "Fault tolerant parsing."
    inputBinding:
      position: 101
      prefix: "--fault-tolerant"
  - id: residue_number_alignment
    type:
      - 'null'
      - boolean
    doc: "Make alignment based on residue number instead of using a global BLOSUM62-based alignment (NUC44 for nucleotides)."
    inputBinding:
      position: 101
      prefix: "--residue-number-alignment"
  - id: substructure_match
    type:
      - 'null'
      - boolean
    doc: "Allow incomplete (ie partially resolved) target ligands."
    inputBinding:
      position: 101
      prefix: "--substructure-match"
  - id: coverage_delta
    type:
      - 'null'
      - float
    doc: "Coverage delta for partial ligand assignment."
    inputBinding:
      position: 101
      prefix: "--coverage-delta"
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Set verbosity level. Defaults to 2 (Script)."
    inputBinding:
      position: 101
      prefix: "--verbosity"
  - id: full_results
    type:
      - 'null'
      - boolean
    doc: "Outputs scoring results for all model/reference ligand pairs and store as key \"full_results\""
    inputBinding:
      position: 101
      prefix: "--full-results"
  - id: lddt_pli
    type:
      - 'null'
      - boolean
    doc: "Compute LDDT-PLI scores and store as key \"lddt_pli\"."
    inputBinding:
      position: 101
      prefix: "--lddt-pli"
  - id: lddt_pli_radius
    type:
      - 'null'
      - float
    doc: "LDDT inclusion radius for LDDT-PLI."
    inputBinding:
      position: 101
      prefix: "--lddt-pli-radius"
  - id: lddt_pli_add_mdl_contacts
    type:
      - 'null'
      - boolean
    doc: "Add model contacts when computing LDDT-PLI. This is enabled by default."
    inputBinding:
      position: 101
      prefix: "--lddt-pli-add-mdl-contacts"
  - id: no_lddt_pli_add_mdl_contacts
    type:
      - 'null'
      - boolean
    doc: "DO NOT add model contacts when computing LDDT-PLI."
    inputBinding:
      position: 101
      prefix: "--no-lddt-pli-add-mdl-contacts"
  - id: rmsd
    type:
      - 'null'
      - boolean
    doc: "Compute RMSD scores and store as key \"rmsd\"."
    inputBinding:
      position: 101
      prefix: "--rmsd"
  - id: radius
    type:
      - 'null'
      - float
    doc: "Inclusion radius to extract reference binding site that is used for RMSD computation. Any residue with atoms within this distance of the ligand will be included in the binding site."
    inputBinding:
      position: 101
      prefix: "--radius"
  - id: lddt_lp_radius
    type:
      - 'null'
      - float
    doc: "LDDT inclusion radius for LDDT-LP."
    inputBinding:
      position: 101
      prefix: "--lddt-lp-radius"
  - id: full_bs_search
    type:
      - 'null'
      - boolean
    doc: "Enumerate all potential binding sites in the model when searching rigid superposition for RMSD computation"
    inputBinding:
      position: 101
      prefix: "--full-bs-search"
  - id: max_symmetries
    type:
      - 'null'
      - int
    doc: "If more than that many isomorphisms exist for a target-ligand pair, it will be ignored and reported as unassigned."
    inputBinding:
      position: 101
      prefix: "--max-symmetries"
  - id: min_pep_length
    type:
      - 'null'
      - int
    doc: "Default: 6 - Minimum length of a protein chain to be considered for being part of a binding site."
    inputBinding:
      position: 101
      prefix: "--min-pep-length"
  - id: min_nuc_length
    type:
      - 'null'
      - int
    doc: "Default: 4 - Minimum length of a NA chain to be considered for being part of a binding site."
    inputBinding:
      position: 101
      prefix: "--min-nuc-length"
  - id: chem_group_seqid_thresh
    type:
      - 'null'
      - float
    doc: "Default: 95 - Sequence identity threshold used to group identical chains in reference structure in the chain mapping step. The same threshold is applied to peptide and nucleotide chains."
    inputBinding:
      position: 101
      prefix: "--chem-group-seqid-thresh"
  - id: chem_map_seqid_thresh
    type:
      - 'null'
      - float
    doc: "Default: 70 - Sequence identity threshold used to map model chains to groups derived in the chem grouping step in chain mapping. If set to 0., a mapping is enforced and each model chain is assigned to the chem group with maximum sequence identity. If larger than 0., a mapping only happens if the respective model chain can be aligned to a chem group with the specified sequence identity threshold AND if at least min-pep-length/min-nuc-length residues are aligned. The same threshold is applied to peptide and nucleotide chains."
    inputBinding:
      position: 101
      prefix: "--chem-map-seqid-thresh"
  - id: seqres
    type:
      - 'null'
      - File
    doc: "Default: None - manually define chem groups by specifying path to a fasta file. Each sequence in that file is considered a reference sequence of a chem group. All polymer chains in reference will be aligned to these sequences. This only works if -rna/--residue- number-alignment is enabled and an error is raised otherwise. Additionally, you need to manually specify a mapping of the polymer chains using trg-seqres- mapping and an error is raised otherwise. The one letter codes in the structure must exactly match the respective characters in seqres and an error is raised if not."
    inputBinding:
      position: 101
      prefix: "--seqres"
  - id: trg_seqres_mapping
    type:
      - 'null'
      - string[]
    doc: "Default: None - Maps each polymer chain in reference to a sequence in *seqres*. Each mapping is a key:value pair where key is the chain name in reference and value is the sequence name in seqres. So let's say you have a homo-dimer reference with chains \"A\" and \"B\"for which you provide a seqres file containing one sequence with name \"1\". You can specify this mapping with: --trg-seqres-mapping A:1 B:1[help] ost compare-ligand-structures: ok via ost compare-ligand-structures --help (--help=ok, -h=ok, -help=ok, (no args)=ok)"
    inputBinding:
      position: 101
      prefix: "--trg-seqres-mapping"
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
