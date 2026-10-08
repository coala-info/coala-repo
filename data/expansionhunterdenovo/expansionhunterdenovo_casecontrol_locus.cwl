cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - casecontrol.py
  - locus
label: expansionhunterdenovo_casecontrol_locus
doc: "Perform locus-based case-control analysis\n\nTool homepage: https://github.com/Illumina/ExpansionHunterDenovo"
inputs:
  - id: manifest
    type: File
    doc: TSV file describing all STR profiles (only the sample names and case or control status are read)
    inputBinding:
      position: 101
      prefix: --manifest
  - id: multisample_profile
    type: File
    doc: JSON file with combined counts of anchored in-repeat reads
    inputBinding:
      position: 101
      prefix: --multisample-profile
  - id: min_inrepeat_reads
    type:
      - 'null'
      - int
    doc: Require regions to have at least this many in-repeat reads (default 5)
    inputBinding:
      position: 101
      prefix: --min-inrepeat-reads
  - id: target_regions
    type:
      - 'null'
      - File
    doc: BED file with regions to which analysis should be restricted
    inputBinding:
      position: 101
      prefix: --target-regions
  - id: test_params
    type:
      - 'null'
      - string
    doc: Method of calculating Wilcoxon Rank-Sum Test p-value (default normal)
    inputBinding:
      position: 101
      prefix: --test-params
  - id: output
    type: string
    doc: Name of the TSV file with the results of the analysis
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: results
    type:
      - 'null'
      - File
    doc: TSV file with the results of the analysis
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
