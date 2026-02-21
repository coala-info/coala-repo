cwlVersion: v1.2
class: CommandLineTool
baseCommand: paf2lastz
label: cactus-gfa-tools_paf2lastz
doc: "Convert PAF(s) with cg cigars to LASTZ cigars\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools"
inputs:
  - id: paf
    type: File
    doc: Input PAF file
    inputBinding:
      position: 1
  - id: extra_pafs
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional input PAF files
    inputBinding:
      position: 2
  - id: mapq_score
    type:
      - 'null'
      - boolean
    doc: Take score from MAPQ field (PAF column 12) instead of AS tag
    inputBinding:
      position: 103
      prefix: --mapq-score
outputs:
  - id: secondary_file
    type:
      - 'null'
      - File
    doc: Separate out secondaries (tp tag == S) and write them to given path
    outputBinding:
      glob: $(inputs.secondary_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cactus-gfa-tools:0.1--h9948957_0
