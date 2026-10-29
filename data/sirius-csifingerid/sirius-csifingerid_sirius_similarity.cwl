cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sirius
arguments:
- valueFrom: similarity
  position: 50
label: sirius-csifingerid_sirius_similarity
doc: 'Computes the similarity between all compounds in the dataset and outputs a matrix
  of similarities.


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
- id: cosine
  type:
  - 'null'
  - boolean
  doc: Compute spectral cosine similarity between all compounds in the dataset
  inputBinding:
    position: 51
    prefix: --cosine
- id: ftalign
  type:
  - 'null'
  - boolean
  doc: Compute fragmentation tree alignments between all compounds in the dataset.
  inputBinding:
    position: 52
    prefix: --ftalign
- id: ftblast
  type:
  - 'null'
  - string
  doc: Compute fragmentation tree alignments between all compounds in the dataset,
    incorporating the given fragmentation tree library. The similarity is not the
    raw alignment score, but the correlation of the scores.
  inputBinding:
    position: 53
    prefix: --ftblast
- id: minpeaks
  type:
  - 'null'
  - int
  doc: 'For cosine: when less than K peaks are matching, set cosine to zero. Default:
    0'
  inputBinding:
    position: 54
    prefix: --minpeaks
- id: numpy
  type:
  - 'null'
  - boolean
  doc: Write as tab separated file with a comment line containing the row/col names
    (numpy compatible). Otherwise, write as tab separated file with row and column
    names.
  inputBinding:
    position: 55
    prefix: --numpy
- id: digits
  type:
  - 'null'
  - int
  doc: 'Specify number of digits used for values in the distance matrix. -1 -> full
    length Double value. Default: -1'
  inputBinding:
    position: 56
    prefix: --digits
- id: tanimoto
  type:
  - 'null'
  - boolean
  doc: compute fingerprint similarity between all compounds in the dataset
  inputBinding:
    position: 57
    prefix: --tanimoto
- id: tanimoto_canopus
  type:
  - 'null'
  - boolean
  doc: compute canopus fingerprint similarity between all compounds in the dataset
  inputBinding:
    position: 58
    prefix: --tanimoto-canopus
- id: directory
  type: string
  doc: 'Directory to store the matrices. Default: .'
  inputBinding:
    position: 59
    prefix: --directory
  default: similarity
outputs:
- id: matrices
  type: Directory
  doc: Folder with the similarity matrices (tsv)
  outputBinding:
    glob: $(inputs.directory)
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
