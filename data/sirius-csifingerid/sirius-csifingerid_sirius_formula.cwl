cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sirius
arguments:
- valueFrom: formula
  position: 50
label: sirius-csifingerid_sirius_formula
doc: 'Identify molecular formula for each compound individually using fragmentation
  trees and isotope patterns.


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
  default: formula_project
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
- id: no_recalibration
  type:
  - 'null'
  - boolean
  doc: Disable Recalibration of input Spectra
  inputBinding:
    position: 51
    prefix: --no-recalibration
- id: no_isotope_filter
  type:
  - 'null'
  - boolean
  doc: Disable molecular formula filter. When filtering is enabled, molecular formulas
    are excluded if their theoretical isotope pattern does not match the theoretical
    one, even if their MS/MS pattern has high score.
  inputBinding:
    position: 52
    prefix: --no-isotope-filter
- id: no_isotope_score
  type:
  - 'null'
  - boolean
  doc: Disable isotope pattern score.
  inputBinding:
    position: 53
    prefix: --no-isotope-score
- id: solver
  type:
  - 'null'
  - string
  doc: 'Set ILP solver to be used for fragmentation computation. Valid values: ''CLP''
    (included), ''CPLEX'', ''GUROBI''. For GUROBI and CPLEX environment variables
    need to be configure (see Manual).'
  inputBinding:
    position: 54
    prefix: --solver
- id: db
  type:
  - 'null'
  - type: array
    items: string
  doc: 'Search formulas in the Union of the given databases. If no database is given
    all possible molecular formulas will be respected (no database is used). Example:
    possible DBs: ''ALL,ALL_BUT_INSILICO,BIO,PUBCHEM,MESH,HMDB,KNAPSACK,CHEBI,PUBMED,KEGG,HSDB,MACONDA,METACYC,GNPS,ZINCBIO,UNDP,YMDB,PLANTCYC,NORMAN,ADDITIONAL,PUBCHEMANNOTATIONBIO,PUBCHEMANNOTATIONDRUG,PUBCHEMANNOTATIONSAFETYANDTOXIC,PUBCHEMANNOTATIONFOOD,KEGGMINE,ECOCYCMINE,YMDBMINE''.
    Default: none'
  inputBinding:
    position: 55
    prefix: --db
    itemSeparator: ','
- id: ppm_max
  type:
  - 'null'
  - double
  doc: 'Maximum allowed mass deviation in ppm for decomposing masses. Default: 10.0
    ppm'
  inputBinding:
    position: 56
    prefix: --ppm-max
- id: ppm_max_ms2
  type:
  - 'null'
  - double
  doc: 'Maximum allowed mass deviation in ppm for decomposing masses in MS2. If not
    specified, the same value as for the MS1 is used. Default: 10.0 ppm'
  inputBinding:
    position: 57
    prefix: --ppm-max-ms2
- id: tree_timeout
  type:
  - 'null'
  - int
  doc: 'Time out in seconds per fragmentation tree computations. 0 for an infinite
    amount of time. Default: 0'
  inputBinding:
    position: 58
    prefix: --tree-timeout
- id: compound_timeout
  type:
  - 'null'
  - int
  doc: 'Maximal computation time in seconds for a single compound. 0 for an infinite
    amount of time. Default: 0'
  inputBinding:
    position: 59
    prefix: --compound-timeout
- id: profile
  type:
  - 'null'
  - string
  doc: 'Name of the configuration profile. Predefined profiles are: `default`, ''qtof'',
    ''orbitrap'', ''fticr''. Default: default'
  inputBinding:
    position: 60
    prefix: --profile
- id: candidates
  type:
  - 'null'
  - int
  doc: 'Number of formula candidates in the output. Default: 10'
  inputBinding:
    position: 61
    prefix: --candidates
- id: candidates_per_ion
  type:
  - 'null'
  - int
  doc: 'Minimum number of candidates in the output for each ionization. Set to force
    output of results for each possible ionization, even if not part of highest ranked
    results. Default: 1'
  inputBinding:
    position: 62
    prefix: --candidates-per-ion
- id: elements_considered
  type:
  - 'null'
  - string
  doc: 'Set the allowed elements for rare element detection. Example: `SBrClBSe` to
    allow the elements S,Br,Cl,B and Se. Default: S,Br,Cl,B,Se'
  inputBinding:
    position: 63
    prefix: --elements-considered
- id: elements_enforced
  type:
  - 'null'
  - string
  doc: 'Enforce elements for molecular formula determination. Example: CHNOPSCl to
    allow the elements C, H, N, O, P, S and Cl. Add numbers in brackets to restrict
    the minimal and maximal allowed occurrence of these elements: CHNOP[5]S[8]Cl[1-2].
    When one number is given then it is interpreted as upper bound. Default: C,H,N,O,P'
  inputBinding:
    position: 64
    prefix: --elements-enforced
- id: formulas
  type:
  - 'null'
  - string
  doc: 'Specify a list of candidate formulas the method should use. Omit this option
    if you want to consider all possible molecular formulas. Default: null'
  inputBinding:
    position: 65
    prefix: --formulas
- id: ions_considered
  type:
  - 'null'
  - string
  doc: 'the iontype/adduct of the MS/MS data. Example: [M+H]+, [M-H]-, [M+Cl]-, [M+Na]+,
    [M]+. You can also provide a comma separated list of adducts.'
  inputBinding:
    position: 66
    prefix: --ions-considered
- id: ions_enforced
  type:
  - 'null'
  - string
  doc: 'the iontype/adduct of the MS/MS data. Example: [M+H]+, [M-H]-, [M+Cl]-, [M+Na]+,
    [M]+. You can also provide a comma separated list of adducts.'
  inputBinding:
    position: 67
    prefix: --ions-enforced
- id: heuristic
  type:
  - 'null'
  - int
  doc: 'Enable heuristic preprocessing for compounds >= the specified m/z. Default:
    300'
  inputBinding:
    position: 68
    prefix: --heuristic
- id: heuristic_only
  type:
  - 'null'
  - int
  doc: 'Use only heuristic tree computation compounds >= the specified m/z. Default:
    650'
  inputBinding:
    position: 69
    prefix: --heuristic-only
outputs:
- id: project
  type: Directory
  doc: Project-space folder with the formula candidates and fragmentation trees
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
