cwlVersion: v1.2
class: CommandLineTool
baseCommand: trident
label: poseidon-trident_rectify
doc: 'Adjust POSEIDON.yml files automatically to package changes


  Tool homepage: https://poseidon-framework.github.io/#/'
arguments:
  - position: 50
    valueFrom: rectify
inputs:
  - id: log_mode
    type:
      - 'null'
      - string
    doc: 'How information should be reported: NoLog, SimpleLog, DefaultLog, ServerLog
      or VerboseLog. (default: DefaultLog)'
    inputBinding:
      position: 1
      prefix: --logMode
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Short for --logMode VerboseLog.
    inputBinding:
      position: 2
      prefix: --debug
  - id: err_length
    type:
      - 'null'
      - string
    doc: 'After how many characters should a potential genotype data parsing error
      message be truncated. "Inf" for no truncation. (default: CharCount 1500)'
    inputBinding:
      position: 3
      prefix: --errLength
  - id: in_plink_pop_name
    type:
      - 'null'
      - string
    doc: 'Where to read the population/group name from the FAM file in Plink-format:
      asFamily (default) | asPhenotype | asBoth.'
    inputBinding:
      position: 4
      prefix: --inPlinkPopName
  - id: base_dir
    type: Directory
    doc: A base directory to search for Poseidon packages. It is staged writable because
      rectify changes the POSEIDON.yml files in place.
    inputBinding:
      position: 100
      prefix: --baseDir
      valueFrom: $(self.basename)
  - id: ignore_poseidon_version
    type:
      - 'null'
      - boolean
    doc: Read packages even if their poseidonVersion is not compatible with trident.
    inputBinding:
      position: 100
      prefix: --ignorePoseidonVersion
  - id: poseidon_version
    type:
      - 'null'
      - string
    doc: Poseidon version the packages should be updated to, e.g. "2.5.3".
    inputBinding:
      position: 100
      prefix: --poseidonVersion
  - id: package_version
    type:
      - 'null'
      - string
    doc: 'Part of the package version number that should be updated: Major, Minor
      or Patch.'
    inputBinding:
      position: 100
      prefix: --packageVersion
  - id: log_text
    type:
      - 'null'
      - string
    doc: Log text for this version in the CHANGELOG file.
    inputBinding:
      position: 100
      prefix: --logText
  - id: checksum_all
    type:
      - 'null'
      - boolean
    doc: Update all checksums.
    inputBinding:
      position: 100
      prefix: --checksumAll
  - id: checksum_geno
    type:
      - 'null'
      - boolean
    doc: Update genotype data checksums.
    inputBinding:
      position: 100
      prefix: --checksumGeno
  - id: checksum_janno
    type:
      - 'null'
      - boolean
    doc: Update .janno file checksum.
    inputBinding:
      position: 100
      prefix: --checksumJanno
  - id: checksum_ssf
    type:
      - 'null'
      - boolean
    doc: Update .ssf file checksum.
    inputBinding:
      position: 100
      prefix: --checksumSSF
  - id: checksum_bib
    type:
      - 'null'
      - boolean
    doc: Update .bib file checksum.
    inputBinding:
      position: 100
      prefix: --checksumBib
  - id: new_contributors
    type:
      - 'null'
      - string
    doc: Contributors to add to the POSEIDON.yml file in the form "[Firstname Lastname](Email
      address);...".
    inputBinding:
      position: 100
      prefix: --newContributors
  - id: janno_remove_empty
    type:
      - 'null'
      - boolean
    doc: Reorder the .janno file and remove empty columns. Pair with --checksumJanno.
    inputBinding:
      position: 100
      prefix: --jannoRemoveEmpty
  - id: only_latest
    type:
      - 'null'
      - boolean
    doc: Consider only the latest versions of packages.
    inputBinding:
      position: 100
      prefix: --onlyLatest
outputs:
  - id: stderr
    type: stderr
    doc: Log messages written by the tool
  - id: base_dir_out
    type: Directory
    doc: The base directory with the updated packages.
    outputBinding:
      glob: $(inputs.base_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.base_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poseidon-trident:1.6.7.1--hebebf5b_0
stderr: poseidon-trident_rectify.err
