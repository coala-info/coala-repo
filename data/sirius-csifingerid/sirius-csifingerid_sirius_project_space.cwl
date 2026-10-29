cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sirius
arguments:
- valueFrom: project-space
  position: 50
label: sirius-csifingerid_sirius_project_space
doc: 'Modify a given project Space: Read project(s) with --input, apply modification
  and write the result via --output. If either --input or --output is given, the modifications
  will be made in-place.


  Tool homepage: https://bio.informatik.uni-jena.de/software/sirius/'
inputs:
- id: log
  type:
  - 'null'
  - string
  doc: 'Set logging level of the Jobs SIRIUS will execute. Valid values: SEVERE, WARNING,
    INFO, FINER, ALL. Default: WARNING'
  inputBinding:
    position: 1
    prefix: --log
- id: cores
  type:
  - 'null'
  - int
  doc: Number of cpu cores to use. If not specified Sirius uses all available cores.
  inputBinding:
    position: 2
    prefix: --cores
- id: instance_buffer
  type:
  - 'null'
  - int
  doc: 'Number of compounds that will be loaded into the Memory. A larger buffer ensures
    that there are enough compounds available to use all cores efficiently during
    computation. A smaller buffer saves Memory. To load all compounds immediately
    set it to -1. Default (numeric value 0): 3 x --cores.'
  inputBinding:
    position: 3
    prefix: --instance-buffer
- id: workspace
  type:
  - 'null'
  - string
  doc: Specify sirius workspace location. This is the directory for storing Property
    files, logs, databases and caches. This is NOT for the project-space that stores
    the results! Default is $USER_HOME/.sirius-<MINOR_VERSION>
  inputBinding:
    position: 4
    prefix: --workspace
- id: recompute
  type:
  - 'null'
  - boolean
  doc: Recompute results of ALL tools where results are already present. Per default
    already present results will be preserved and the instance will be skipped for
    the corresponding Task/Tool
  inputBinding:
    position: 5
    prefix: --recompute
- id: maxmz
  type:
  - 'null'
  - double
  doc: 'Only considers compounds with a precursor m/z lower or equal [--maxmz]. All
    other compounds in the input will be skipped. Default: Infinity'
  inputBinding:
    position: 6
    prefix: --maxmz
- id: no_cite
  type:
  - 'null'
  - boolean
  doc: Do not write summary files to the project-space
  inputBinding:
    position: 7
    prefix: --noCite
- id: output_project
  type: string
  doc: Specify the project-space to write into. If no [--input] is specified it is
    also used as input. A folder name without .sirius ending gives a project-space
    folder.
  inputBinding:
    position: 8
    prefix: --output
  default: project_out
- id: naming_convention
  type:
  - 'null'
  - string
  doc: Specify a naming scheme for the compound directories ins the project-space.
    Default %index_%filename_%compoundname
  inputBinding:
    position: 9
    prefix: --naming-convention
- id: no_compression
  type:
  - 'null'
  - boolean
  doc: Does not use compressed project-space format (not recommended) when creating
    the project-space. If an existing project-space is opened this parameter has no
    effect.
  inputBinding:
    position: 10
    prefix: --no-compression
- id: update_fingerprint_version
  type:
  - 'null'
  - boolean
  doc: 'Updates Fingerprint versions of the input project to the one used by this
    SIRIUS version. WARNING: All Fingerprint related results (CSI:FingerID, CANOPUS)
    will be lost!'
  inputBinding:
    position: 11
    prefix: --update-fingerprint-version
- id: input
  type:
  - 'null'
  - type: array
    items:
    - File
    - Directory
  doc: 'Specify the input in multi-compound input formats: Preprocessed mass spectra
    in .ms or .mgf file format, LC/MS runs in .mzML/.mzXml format or already existing
    SIRIUS project-spaces (uncompressed/compressed) but also any other file type e.g.
    to provide input for STANDALONE tools.'
  inputBinding:
    position: 12
    prefix: --input
    itemSeparator: ','
- id: ignore_formula
  type:
  - 'null'
  - boolean
  doc: ignore given molecular formula if present in .ms or .mgf input files.
  inputBinding:
    position: 13
    prefix: --ignore-formula
- id: allow_ms1_only
  type:
  - 'null'
  - boolean
  doc: Allow MS1 only data to be imported.
  inputBinding:
    position: 14
    prefix: --allow-ms1-only
- id: ms1
  type:
  - 'null'
  - type: array
    items: File
  doc: MS1 spectra files
  inputBinding:
    position: 15
    prefix: --ms1
    itemSeparator: ','
- id: ms2
  type:
  - 'null'
  - type: array
    items: File
  doc: MS2 spectra files
  inputBinding:
    position: 16
    prefix: --ms2
    itemSeparator: ','
- id: parent_mass
  type:
  - 'null'
  - double
  doc: The mass of the parent ion for the specified ms2 spectra
  inputBinding:
    position: 17
    prefix: --mz
- id: adduct
  type:
  - 'null'
  - string
  doc: 'Specify the adduct for this compound. Default: [M+?]+'
  inputBinding:
    position: 18
    prefix: --adduct
- id: formula
  type:
  - 'null'
  - string
  doc: Specify the neutralized formula of this compound. This will be used for tree
    computation. If given no mass decomposition will be performed.
  inputBinding:
    position: 19
    prefix: --formula
- id: delete_by_idx
  type:
  - 'null'
  - type: array
    items: int
  doc: Delete all compounds that match the given indices from the given project-space.
  inputBinding:
    position: 51
    prefix: --delete-by-idx
    itemSeparator: ','
- id: delete_by_mass
  type:
  - 'null'
  - string
  doc: 'Delete all compounds that are within the given mass window. Example: Use ''mass1:mass2''
    to match compounds with mass1 <= mass <= mass2. Leave a value empty to set no
    bound.'
  inputBinding:
    position: 52
    prefix: --delete-by-mass
- id: delete_by_name
  type:
  - 'null'
  - string
  doc: Delete all compounds where the 'identifier' (dir name, ID) matches the given
    regex (JAVA).
  inputBinding:
    position: 53
    prefix: --delete-by-name
- id: keep_by_idx
  type:
  - 'null'
  - type: array
    items: int
  doc: Keep all compounds that match the given indices from the given project-space
  inputBinding:
    position: 54
    prefix: --keep-by-idx
    itemSeparator: ','
- id: keep_by_confidence
  type:
  - 'null'
  - double
  doc: Keep all compounds that have a valid confidence score greater or equal than
    the given minimum confidence.
  inputBinding:
    position: 55
    prefix: --keep-by-confidence
- id: keep_by_explained_intensity
  type:
  - 'null'
  - double
  doc: Keep all compounds that have at least one fragmentation tree that explains
    at least a minimum total intensity of the spectrum. Value between 0 to 1.
  inputBinding:
    position: 56
    prefix: --keep-by-explained-intensity
- id: keep_by_mass
  type:
  - 'null'
  - string
  doc: 'Keep all compounds that are within the given mass window. Example: Use ''mass1:mass2''
    to match compounds with mass1 <= mass <= mass2. Leave a value empty to set no
    bound.'
  inputBinding:
    position: 57
    prefix: --keep-by-mass
- id: keep_by_name
  type:
  - 'null'
  - string
  doc: Keep all compounds where the 'identifier' (Dir name, ID) matches the given
    regex (JAVA).
  inputBinding:
    position: 58
    prefix: --keep-by-name
- id: keep_by_tree_size
  type:
  - 'null'
  - int
  doc: Keep all compounds that have at least one fragmentation tree with number of
    fragments (including precursor) greater or equal than the given minimum.
  inputBinding:
    position: 59
    prefix: --keep-by-tree-size
- id: move
  type:
  - 'null'
  - boolean
  doc: 'DANGERZONE: Move instead of copy data (where possible) when merging or splitting
    projects to save time. Be aware of the risk that you may end up with corrupted
    input or output data when the program crashes.'
  inputBinding:
    position: 60
    prefix: --move
- id: merge_compounds_cosine
  type:
  - 'null'
  - double
  doc: Merge compounds which have the same spectra and m/z into one. The criteria
    for merging can be specified with --merge-compounds-cosine and --merge-compounds-rtdiff.
  inputBinding:
    position: 61
    prefix: --merge-compounds-cosine
- id: merge_compounds_rtdiff
  type:
  - 'null'
  - string
  doc: Merge compounds which have the same spectra and m/z into one. Retention time
    difference for merging is either specified in seconds, or by adding a unit after
    the number (e.g., '5 min').
  inputBinding:
    position: 62
    prefix: --merge-compounds-rtdiff
- id: merge_compounds_top
  type:
  - 'null'
  - int
  doc: Merge compounds which have the same spectra and m/z into one. For each such
    cluster of compounds, keep only the top k most abundant ones.
  inputBinding:
    position: 63
    prefix: --merge-compounds-top
- id: split
  type:
  - 'null'
  - string
  doc: 'Split the output into batches. Either in a specific number of batches or in
    batches of specific size! Default: NO'
  inputBinding:
    position: 64
    prefix: --split
- id: count
  type:
  - 'null'
  - int
  doc: 'Sets batch number or batch size depending on <--split>. Default: 1'
  inputBinding:
    position: 65
    prefix: --count
- id: split_order
  type:
  - 'null'
  - string
  doc: 'Specify the order of Compounds before putting them into batches. Default:
    SHUFFLE'
  inputBinding:
    position: 66
    prefix: --split-order
outputs:
- id: project
  type: Directory
  doc: Modified project-space folder
  outputBinding:
    glob: $(inputs.output_project)
requirements:
- class: ResourceRequirement
  coresMin: 1
  ramMin: 4000
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.input)
    writable: true
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
