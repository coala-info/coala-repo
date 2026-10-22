cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtk
  - resolve
label: svtk_resolve
doc: 'Resolve complex SV from inversion/translocation breakpoints and CNV intervals.


  Tool homepage: https://github.com/talkowski-lab/svtk'
inputs:
  - id: raw
    type: File
    doc: Filtered breakpoints and CNV intervals.
    inputBinding:
      position: 1
  - id: resolved
    type: string
    doc: Resolved simple and complex variants.
    inputBinding:
      position: 2
  - id: cytobands
    type: File
    doc: Cytoband file. Required to correctly classify interchromosomal events.
    inputBinding:
      position: 103
      prefix: --cytobands
  - id: discfile
    type:
      - 'null'
      - File
    doc: Scraped discordant pairs. Required to attempt to resolve single-ender inversions.
    inputBinding:
      position: 103
      prefix: --discfile
  - id: discfile_list
    type:
      - 'null'
      - File
    doc: Tab-delimited list of discordant pair files and indices
    inputBinding:
      position: 103
      prefix: --discfile-list
  - id: mei_bed
    type: File
    doc: Mobile element insertion bed. Required to classify inverted insertions.
    inputBinding:
      position: 103
      prefix: --mei-bed
  - id: min_rescan_pe_support
    type:
      - 'null'
      - int
    doc: Minumum discordant pairs required during single-ender rescan.
    inputBinding:
      position: 103
      prefix: --min-rescan-pe-support
  - id: pe_blacklist
    type:
      - 'null'
      - File
    doc: Tabix indexed bed of blacklisted regions. Any anomalous pair falling inside
      one of these regions is excluded from PE rescanning.
    inputBinding:
      position: 103
      prefix: --pe-blacklist
  - id: prefix
    type:
      - 'null'
      - string
    doc: Variant prefix
    inputBinding:
      position: 103
      prefix: --prefix
  - id: quiet
    type:
      - 'null'
      - string
    doc: Disable progress logging to stderr.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: unresolved
    type:
      - 'null'
      - string
    doc: Unresolved complex breakpoints and CNV.
    inputBinding:
      position: 103
      prefix: --unresolved
outputs:
  - id: out_resolved
    type: File
    doc: Resolved simple and complex variants.
    outputBinding:
      glob: $(inputs.resolved)
  - id: out_unresolved
    type:
      - 'null'
      - File
    doc: Unresolved complex breakpoints and CNV.
    outputBinding:
      glob: $(inputs.unresolved)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
