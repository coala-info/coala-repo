cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - outlier.py
  - motif
label: expansionhunterdenovo_outlier_motif
doc: "Perform motif-based outlier analysis\n\nTool homepage: https://github.com/Illumina/ExpansionHunterDenovo"
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
