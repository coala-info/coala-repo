cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sirius
arguments:
- valueFrom: zodiac
  position: 50
label: sirius-csifingerid_sirius_zodiac
doc: 'Identify Molecular formulas of all compounds in a dataset together using ZODIAC.


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
  default: zodiac_project
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
- id: burn_in
  type:
  - 'null'
  - int
  doc: 'Number of epochs considered as ''burn-in period''. Default: 2000'
  inputBinding:
    position: 51
    prefix: --burn-in
- id: considered_candidates_at_300
  type:
  - 'null'
  - int
  doc: 'Maximum number of candidate molecular formulas (fragmentation trees computed
    by SIRIUS) per compound which are considered by ZODIAC for compounds below 300
    m/z. Default: 10'
  inputBinding:
    position: 52
    prefix: --considered-candidates-at-300
- id: considered_candidates_at_800
  type:
  - 'null'
  - int
  doc: 'Maximum number of candidate molecular formulas (fragmentation trees computed
    by SIRIUS) per compound which are considered by ZODIAC for compounds above 800
    m/z. Default: 50'
  inputBinding:
    position: 53
    prefix: --considered-candidates-at-800
- id: ignore_spectra_quality
  type:
  - 'null'
  - boolean
  doc: As default ZODIAC runs a 2-step approach. First running 'good quality compounds'
    only, and afterwards including the remaining.
  inputBinding:
    position: 54
    prefix: --ignore-spectra-quality
- id: iterations
  type:
  - 'null'
  - int
  doc: 'Number of epochs to run the Gibbs sampling. When multiple Markov chains are
    computed, all chains'' iterations sum up to this value. Default: 20000'
  inputBinding:
    position: 55
    prefix: --iterations
- id: lambda
  type:
  - 'null'
  - double
  doc: 'Lambda used in the scoring function of spectral library hits. The higher this
    value the higher are library hits weighted in ZODIAC scoring. Default: 1000'
  inputBinding:
    position: 56
    prefix: --lambda
- id: library_hits
  type:
  - 'null'
  - File
  doc: CSV file containing spectral library hits. Library hits are used as anchors
    to improve ZODIAC scoring.
  inputBinding:
    position: 57
    prefix: --library-hits
- id: min_cosine
  type:
  - 'null'
  - double
  doc: 'Spectral library hits must have at least this cosine or higher to be considered
    in scoring. Value must be in [0,1]. Default: 0.5'
  inputBinding:
    position: 58
    prefix: --min-cosine
- id: min_local_connections
  type:
  - 'null'
  - int
  doc: 'Minimum number of compounds to which at least one candidate per compound must
    be connected to. Default: 10'
  inputBinding:
    position: 59
    prefix: --minLocalConnections
- id: threshold_filter
  type:
  - 'null'
  - double
  doc: 'Defines the proportion of edges of the complete network which will be ignored.
    Default: 0.95'
  inputBinding:
    position: 60
    prefix: --thresholdFilter
outputs:
- id: project
  type: Directory
  doc: Project-space folder with ZODIAC re-ranked formulas
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
