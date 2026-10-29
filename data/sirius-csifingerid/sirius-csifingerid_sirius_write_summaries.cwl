cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sirius
arguments:
- valueFrom: write-summaries
  position: 50
label: sirius-csifingerid_sirius_write_summaries
doc: 'Write Summary files from a given project-space into the given project-space
  or a custom location.


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
- id: zip
  type:
  - 'null'
  - boolean
  doc: Summaries will be written into a compressed zip archive. This parameter will
    be ignored if the summary is written into the project-space.
  inputBinding:
    position: 51
    prefix: --zip
- id: full_summary
  type:
  - 'null'
  - boolean
  doc: Write project wide summary files with ALL Hits. (Use with care! Might create
    large files and consume large amounts of memory for large projects.)
  inputBinding:
    position: 52
    prefix: --full-summary
- id: no_full_summary
  type:
  - 'null'
  - boolean
  doc: Do not write the full summary (--no-full-summary).
  inputBinding:
    position: 53
    prefix: --no-full-summary
- id: top_hit_summary
  type:
  - 'null'
  - boolean
  doc: Write project wide summary files with all Top Hits.
  inputBinding:
    position: 54
    prefix: --top-hit-summary
- id: no_top_hit_summary
  type:
  - 'null'
  - boolean
  doc: Do not write the top hit summary (--no-top-hit-summary).
  inputBinding:
    position: 55
    prefix: --no-top-hit-summary
- id: top_hit_adduct_summary
  type:
  - 'null'
  - boolean
  doc: Write project wide summary files with all Top Hits and their adducts.
  inputBinding:
    position: 56
    prefix: --top-hit-adduct-summary
- id: no_top_hit_adduct_summary
  type:
  - 'null'
  - boolean
  doc: Do not write the top hit adduct summary (--no-top-hit-adduct-summary).
  inputBinding:
    position: 57
    prefix: --no-top-hit-adduct-summary
- id: output
  type: string
  doc: Specify location (outside the project) for writing summary files. Per default
    summaries are written to the project-space
  inputBinding:
    position: 58
    prefix: --output
  default: summaries
- id: classyfire
  type:
  - 'null'
  - boolean
  doc: Output predicted classyfire probabilities by CANOPUS.
  inputBinding:
    position: 59
    prefix: --classyfire
- id: npc
  type:
  - 'null'
  - boolean
  doc: Output predicted NPC (natural product classifier) probabilities by CANOPUS.
  inputBinding:
    position: 60
    prefix: --npc
- id: fingerprint
  type:
  - 'null'
  - boolean
  doc: Output predicted fingerprint probabilities by CSI:FingerID.
  inputBinding:
    position: 61
    prefix: --fingerprint
- id: pubchem
  type:
  - 'null'
  - boolean
  doc: Output predicted PubChem fingerprint probabilities by CSI:FingerID (subset
    of --fingerprint).
  inputBinding:
    position: 62
    prefix: --pubchem
- id: maccs
  type:
  - 'null'
  - boolean
  doc: Output predicted MACCS fingerprint probabilities by CSI:FingerID (subset of
    --fingerprint).
  inputBinding:
    position: 63
    prefix: --maccs
- id: all
  type:
  - 'null'
  - boolean
  doc: Output all predicted CSI:FingerID and CANOPUS probabilities (sets --fingerprints,
    --classyfire, --npc).
  inputBinding:
    position: 64
    prefix: --all
- id: digits
  type:
  - 'null'
  - int
  doc: 'Specify number of digits used for printing floating point values. -1 -> full
    length Double value. Default: -1'
  inputBinding:
    position: 65
    prefix: --digits
outputs:
- id: summaries
  type: Directory
  doc: Folder with the summary tables
  outputBinding:
    glob: $(inputs.output)
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
