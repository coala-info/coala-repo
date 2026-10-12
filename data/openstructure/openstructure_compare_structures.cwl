cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ost
  - compare-structures
label: openstructure_compare_structures
doc: "Evaluate a model structure against a reference structure (LDDT, QS-score, DockQ, TM-score and more).\n\nTool homepage: https://openstructure.org"
inputs:
  - id: model
    type: File
    doc: "Path to model file."
    inputBinding:
      position: 101
      prefix: "--model"
  - id: reference
    type: File
    doc: "Path to reference file."
    inputBinding:
      position: 101
      prefix: "--reference"
  - id: output
    type:
      - 'null'
      - string
    doc: "Output file name. The output will be saved as a JSON file. default: out.json"
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
  - id: reference_format
    type:
      - 'null'
      - string
    doc: "Format of reference file. pdb reads pdb but also pdb.gz, same applies to cif/mmcif. Inferred from filepath if not given."
    inputBinding:
      position: 101
      prefix: "--reference-format"
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
  - id: residue_number_alignment
    type:
      - 'null'
      - boolean
    doc: "Make alignment based on residue number instead of using a global BLOSUM62-based alignment (NUC44 for nucleotides)."
    inputBinding:
      position: 101
      prefix: "--residue-number-alignment"
  - id: enforce_consistency
    type:
      - 'null'
      - boolean
    doc: "Enforce consistency. By default residue name discrepancies between a model and reference are reported but the program proceeds. If this flag is ON, the program fails for these cases."
    inputBinding:
      position: 101
      prefix: "--enforce-consistency"
  - id: dump_structures
    type:
      - 'null'
      - boolean
    doc: "Dump cleaned structures used to calculate all the scores as PDB or mmCIF files using specified suffix. Files will be dumped to the same location and in the same format as original files."
    inputBinding:
      position: 101
      prefix: "--dump-structures"
  - id: dump_suffix
    type:
      - 'null'
      - string
    doc: "Use this suffix to dump structures. Defaults to _compare_structures"
    inputBinding:
      position: 101
      prefix: "--dump-suffix"
  - id: fault_tolerant
    type:
      - 'null'
      - boolean
    doc: "Fault tolerant parsing."
    inputBinding:
      position: 101
      prefix: "--fault-tolerant"
  - id: chain_mapping
    type:
      - 'null'
      - string[]
    doc: "Custom mapping of chains between the reference and the model. Each separate mapping consist of key:value pairs where key is the chain name in reference and value is the chain name in model."
    inputBinding:
      position: 101
      prefix: "--chain-mapping"
  - id: lddt
    type:
      - 'null'
      - boolean
    doc: "Compute global LDDT score with default parameterization and store as key \"lddt\". Stereochemical irregularities affecting LDDT are reported as keys \"model_clashes\", \"model_bad_bonds\", \"model_bad_angles\" and the respective reference counterparts."
    inputBinding:
      position: 101
      prefix: "--lddt"
  - id: local_lddt
    type:
      - 'null'
      - boolean
    doc: "Compute per-residue LDDT scores with default parameterization and store as key \"local_lddt\". Score for each residue is accessible by key <chain_name>.<resnum>.<resnum_inscode>. Residue with number 42 in chain X can be extracted with: data[\"local_lddt\"][\"X.42.\"]. If there is an insertion code, lets say A, the residue key becomes \"X.42.A\". Stereochemical irregularities affecting LDDT are reported as keys \"model_clashes\", \"model_bad_bonds\", \"model_bad_angles\" and the respective reference counterparts. Atoms specified in there follow the following format: <chain_name>.<resnum>.<resnum_inscode>.<atom_name>"
    inputBinding:
      position: 101
      prefix: "--local-lddt"
  - id: aa_local_lddt
    type:
      - 'null'
      - boolean
    doc: "Compute per-atom LDDT scores with default parameterization and store as key \"aa_local_lddt\". Score for each atom is accessible by key <chain_name>.<resnum>.<resnum_inscode>.<aname>. Alpha carbon from residue with number 42 in chain X can be extracted with: data[\"aa_local_lddt\"][\"X.42..CA\"]. If there is a residue insertion code, lets say A, the atom key becomes \"X.42.A.CA\". Stereochemical irregularities affecting LDDT are reported as keys \"model_clashes\", \"model_bad_bonds\", \"model_bad_angles\" and the respective reference counterparts. Atoms specified in there follow the following format: <chain_name>.<resnum>.<resnum_inscode>.<atom_name>"
    inputBinding:
      position: 101
      prefix: "--aa-local-lddt"
  - id: bb_lddt
    type:
      - 'null'
      - boolean
    doc: "Compute global LDDT score with default parameterization and store as key \"bb_lddt\". LDDT in this case is only computed on backbone atoms: CA for peptides and C3' for nucleotides"
    inputBinding:
      position: 101
      prefix: "--bb-lddt"
  - id: bb_local_lddt
    type:
      - 'null'
      - boolean
    doc: "Compute per-residue LDDT scores with default parameterization and store as key \"bb_local_lddt\". LDDT in this case is only computed on backbone atoms: CA for peptides and C3' for nucleotides. Per-residue scores are accessible as described for local_lddt."
    inputBinding:
      position: 101
      prefix: "--bb-local-lddt"
  - id: ilddt
    type:
      - 'null'
      - boolean
    doc: "Compute global LDDT score which is solely based on inter-chain contacts and store as key \"ilddt\". Same stereochemical irregularities as for lddt apply."
    inputBinding:
      position: 101
      prefix: "--ilddt"
  - id: cad_score
    type:
      - 'null'
      - boolean
    doc: "Compute global CAD's atom-atom (AA) score and store as key \"cad_score\". --residue-number-alignment must be enabled to compute this score. Requires voronota_cadscore executable in PATH. Alternatively you can set cad-exec."
    inputBinding:
      position: 101
      prefix: "--cad-score"
  - id: local_cad_score
    type:
      - 'null'
      - boolean
    doc: "Compute local CAD's atom-atom (AA) scores and store as key \"local_cad_score\". Per-residue scores are accessible as described for local_lddt. --residue- number-alignments must be enabled to compute this score. Requires voronota_cadscore executable in PATH. Alternatively you can set cad-exec."
    inputBinding:
      position: 101
      prefix: "--local-cad-score"
  - id: cad_exec
    type:
      - 'null'
      - string
    doc: "Path to voronota-cadscore executable (installed from https://github.com/kliment-olechnovic/voronota). Searches PATH if not set."
    inputBinding:
      position: 101
      prefix: "--cad-exec"
  - id: usalign_exec
    type:
      - 'null'
      - string
    doc: "Path to USalign executable to compute TM-score. If not given, an OpenStructure internal copy of USalign code is used."
    inputBinding:
      position: 101
      prefix: "--usalign-exec"
  - id: override_usalign_mapping
    type:
      - 'null'
      - boolean
    doc: "Override USalign mapping and inject our own rigid mapping. Only works if external usalign executable is provided that is reasonably new and contains that feature."
    inputBinding:
      position: 101
      prefix: "--override-usalign-mapping"
  - id: qs_score
    type:
      - 'null'
      - boolean
    doc: "Compute QS-score, stored as key \"qs_global\", and the QS-best variant, stored as key \"qs_best\". Interfaces in the reference with non-zero contribution to QS- score are available as key \"qs_reference_interfaces\", the ones from the model as key \"qs_model_interfaces\". \"qs_interfaces\" is a subset of \"qs_reference_interfaces\" that contains interfaces that can be mapped to the model. They are stored as lists in format [ref_ch1, ref_ch2, mdl_ch1, mdl_ch2]. The respective per-interface scores for \"qs_interfaces\" are available as keys \"per_interface_qs_global\" and \"per_interface_qs_best\""
    inputBinding:
      position: 101
      prefix: "--qs-score"
  - id: dockq
    type:
      - 'null'
      - boolean
    doc: "Compute DockQ scores and its components. Relevant interfaces with at least one contact (any atom within 5A) of the reference structure are available as key \"dockq_reference_interfaces\". Protein-protein, protein-nucleotide and nucleotide-nucleotide interfaces are considered. Key \"dockq_interfaces\" is a subset of \"dockq_reference_interfaces\" that contains interfaces that can be mapped to the model. They are stored as lists in format [ref_ch1, ref_ch2, mdl_ch1, mdl_ch2]. The respective DockQ scores for \"dockq_interfaces\" are available as key \"dockq\". It's components are available as keys: \"fnat\" (fraction of reference contacts which are also there in model) \"irmsd\" (interface RMSD), \"lrmsd\" (ligand RMSD). The DockQ score is strictly designed to score each interface individually. We also provide two averaged versions to get one full model score: \"dockq_ave\", \"dockq_wave\". The first is simply the average of \"dockq_scores\", the latter is a weighted average with weights derived from number of contacts in the reference interfaces. These two scores only consider interfaces that are present in both, the model and the reference. \"dockq_ave_full\" and \"dockq_wave_full\" add zeros in the average computation for each interface that is only present in the reference but not in the model."
    inputBinding:
      position: 101
      prefix: "--dockq"
  - id: dockq_capri_peptide
    type:
      - 'null'
      - boolean
    doc: "Flag that changes two things in the way DockQ and its underlying scores are computed which is proposed by the CAPRI community when scoring peptides (PMID: 31886916). ONE: Two residues are considered in contact if any of their atoms is within 5A. This is relevant for fnat and fnonat scores. CAPRI suggests to lower this threshold to 4A for protein-peptide interactions. TWO: irmsd is computed on interface residues. A residue is defined as interface residue if any of its atoms is within 10A of another chain. CAPRI suggests to lower the default of 10A to 8A in combination with only considering CB atoms for protein-peptide interactions. Note that the resulting DockQ is not evaluated for these slightly updated fnat and irmsd (lrmsd stays the same). Raises an error if reference contains nucleotide chains. This flag has no influence on patch_dockq scores."
    inputBinding:
      position: 101
      prefix: "--dockq-capri-peptide"
  - id: ics
    type:
      - 'null'
      - boolean
    doc: "Computes interface contact similarity (ICS) related scores. A contact between two residues of different chains is defined as having at least one heavy atom within 5A. Contacts in reference structure are available as key \"reference_contacts\". Each contact specifies the interacting residues in format \"<cname>.<rnum>.<ins_code>\". Model contacts are available as key \"model_contacts\". The precision which is available as key \"ics_precision\" reports the fraction of model contacts that are also present in the reference. The recall which is available as key \"ics_recall\" reports the fraction of reference contacts that are correctly reproduced in the model. The ICS score (Interface Contact Similarity) available as key \"ics\" combines precision and recall using the F1-measure. All these measures are also available on a per-interface basis for each interface in the reference structure that are defined as chain pairs with at least one contact (available as key \"contact_reference_interfaces\"). The respective metrics are available as keys \"per_interface_ics_precision\", \"per_interface_ics_recall\" and \"per_interface_ics\"."
    inputBinding:
      position: 101
      prefix: "--ics"
  - id: ics_trimmed
    type:
      - 'null'
      - boolean
    doc: "Computes interface contact similarity (ICS) related scores but on a trimmed model. That means that a mapping between model and reference is performed and all model residues without reference counterpart are removed. As a consequence, model contacts for which we have no experimental evidence do not affect the score. The effect of these added model contacts without mapping to target would be decreased precision and thus lower ics. Recall is not affected. Enabling this flag adds the following keys: \"ics_trimmed\", \"ics_precision_trimmed\", \"ics_recall_trimmed\", \"model_contacts_trimmed\". The reference contacts and reference interfaces are the same as for ics and available as keys: \"reference_contacts\", \"contact_reference_interfaces\". All these measures are also available on a per-interface basis for each interface in the reference structure that are defined as chain pairs with at least one contact (available as key \"contact_reference_interfaces\"). The respective metrics are available as keys \"per_interface_ics_precision_trimmed\", \"per_interface_ics_recall_trimmed\" and \"per_interface_ics_trimmed\"."
    inputBinding:
      position: 101
      prefix: "--ics-trimmed"
  - id: ips
    type:
      - 'null'
      - boolean
    doc: "Computes interface patch similarity (IPS) related scores. They focus on interface residues. They are defined as having at least one contact to a residue from any other chain. In short: if they show up in the contact lists used to compute ICS. If ips is enabled, these contacts get reported too and are available as keys \"reference_contacts\" and \"model_contacts\".The precision which is available as key \"ips_precision\" reports the fraction of model interface residues, that are also interface residues in the reference. The recall which is available as key \"ips_recall\" reports the fraction of reference interface residues that are also interface residues in the model. The IPS score (Interface Patch Similarity) available as key \"ips\" is the Jaccard coefficient between interface residues in reference and model. All these measures are also available on a per-interface basis for each interface in the reference structure that are defined as chain pairs with at least one contact (available as key \"contact_reference_interfaces\"). The respective metrics are available as keys \"per_interface_ips_precision\", \"per_interface_ips_recall\" and \"per_interface_ips\"."
    inputBinding:
      position: 101
      prefix: "--ips"
  - id: ips_trimmed
    type:
      - 'null'
      - boolean
    doc: "The IPS equivalent of ICS on trimmed models."
    inputBinding:
      position: 101
      prefix: "--ips-trimmed"
  - id: rigid_scores
    type:
      - 'null'
      - boolean
    doc: "Computes rigid superposition based scores. They're based on a Kabsch superposition of all mapped CA positions (C3' for nucleotides). Makes the following keys available: \"oligo_gdtts\": GDT with distance thresholds [1.0, 2.0, 4.0, 8.0] given these positions and transformation, \"oligo_gdtha\": same with thresholds [0.5, 1.0, 2.0, 4.0], \"rmsd\": RMSD given these positions and transformation, \"transform\": the used 4x4 transformation matrix that superposes model onto reference, \"rigid_chain_mapping\": equivalent of \"chain_mapping\" which is used for rigid scores (optimized for RMSD instead of QS-score/LDDT)."
    inputBinding:
      position: 101
      prefix: "--rigid-scores"
  - id: patch_scores
    type:
      - 'null'
      - boolean
    doc: "Local interface quality score used in CASP15. Scores each model residue that is considered in the interface (CB pos within 8A of any CB pos from another chain (CA for GLY)). The local neighborhood gets represented by \"interface patches\" which are scored with QS-score and DockQ. Scores where not the full patches are represented by the reference are set to None. Model interface residues are available as key \"model_interface_residues\", reference interface residues as key \"reference_interface_residues\". Residues are represented as string in form <chain_name>.<resnum>.<resnum_inscode>. The respective scores are available as keys \"patch_qs\" and \"patch_dockq\""
    inputBinding:
      position: 101
      prefix: "--patch-scores"
  - id: tm_score
    type:
      - 'null'
      - boolean
    doc: "Computes TM-score with the USalign tool. Also computes a chain mapping in case of complexes that is stored in the same format as the default mapping. TM-score and the mapping are available as keys \"tm_score\" and \"usalign_mapping\""
    inputBinding:
      position: 101
      prefix: "--tm-score"
  - id: lddt_no_stereochecks
    type:
      - 'null'
      - boolean
    doc: "Disable stereochecks for LDDT computation"
    inputBinding:
      position: 101
      prefix: "--lddt-no-stereochecks"
  - id: n_max_naive
    type:
      - 'null'
      - int
    doc: "Parameter for chain mapping. If the number of possible mappings is <= *n_max_naive*, the full mapping solution space is enumerated to find the the mapping with optimal QS-score. A heuristic is used otherwise. The default of 40320 corresponds to an octamer (8! = 40320). A structure with stoichiometry A6B2 would be 6!*2! = 1440 etc."
    inputBinding:
      position: 101
      prefix: "--n-max-naive"
  - id: dump_aligned_residues
    type:
      - 'null'
      - boolean
    doc: "Dump additional info on aligned model and reference residues."
    inputBinding:
      position: 101
      prefix: "--dump-aligned-residues"
  - id: dump_pepnuc_alns
    type:
      - 'null'
      - boolean
    doc: "Dump alignments of mapped chains but with sequences that did not undergo Molck preprocessing in the scorer. Sequences are extracted from model/target after undergoing selection for peptide and nucleotide residues."
    inputBinding:
      position: 101
      prefix: "--dump-pepnuc-alns"
  - id: dump_pepnuc_aligned_residues
    type:
      - 'null'
      - boolean
    doc: "Dump additional info on model and reference residues that occur in pepnuc alignments."
    inputBinding:
      position: 101
      prefix: "--dump-pepnuc-aligned-residues"
  - id: min_pep_length
    type:
      - 'null'
      - int
    doc: "Default: 6 - Relevant parameter if short peptides are involved in scoring. Minimum peptide length for a chain in the target structure to be considered in chain mapping. The chain mapping algorithm first performs an all vs. all pairwise sequence alignment to identify \"equal\" chains within the target structure. We go for simple sequence identity there. Short sequences can be problematic as they may produce high sequence identity alignments by pure chance."
    inputBinding:
      position: 101
      prefix: "--min-pep-length"
  - id: min_nuc_length
    type:
      - 'null'
      - int
    doc: "Default: 4 - Relevant parameter if short nucleotides are involved in scoring.Minimum nucleotide length for a chain in the target structure to be considered in chain mapping. The chain mapping algorithm first performs an all vs. all pairwise sequence alignment to identify \"equal\" chains within the target structure. We go for simple sequence identity there. Short sequences can be problematic as they may produce high sequence identity alignments by pure chance."
    inputBinding:
      position: 101
      prefix: "--min-nuc-length"
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Set verbosity level. Defaults to 2 (Script)."
    inputBinding:
      position: 101
      prefix: "--verbosity"
  - id: lddt_add_mdl_contacts
    type:
      - 'null'
      - boolean
    doc: "Only using contacts in LDDT that are within a certain distance threshold in the reference does not penalize for added model contacts. If set to True, this flag will also consider reference contacts that are within the specified distance threshold in the model but not necessarily in the reference. No contact will be added if the respective atom pair is not resolved in the reference."
    inputBinding:
      position: 101
      prefix: "--lddt-add-mdl-contacts"
  - id: lddt_inclusion_radius
    type:
      - 'null'
      - float
    doc: "Passed to LDDT scorer. Affects all LDDT scores but not chain mapping."
    inputBinding:
      position: 101
      prefix: "--lddt-inclusion-radius"
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
    doc: "Default: None - Maps each polymer chain in reference to a sequence in *seqres*. Each mapping is a key:value pair where key is the chain name in reference and value is the sequence name in seqres. So let's say you have a homo-dimer reference with chains \"A\" and \"B\"for which you provide a seqres file containing one sequence with name \"1\". You can specify this mapping with: --trg-seqres-mapping A:1 B:1[help] ost compare-structures: ok via ost compare-structures --help (--help=ok, -h=ok, -help=ok, (no args)=ok)"
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
