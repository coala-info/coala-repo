cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - annotate_ehdn.sh
label: expansionhunterdenovo_annotate_ehdn
doc: "Annotate ExpansionHunter Denovo locus results with ANNOVAR (requires an ANNOVAR installation and a refGene humandb)\n\nTool homepage: https://github.com/Illumina/ExpansionHunterDenovo"
inputs:
  - id: ehdn_results
    type: File
    doc: ExpansionHunterDenovo secondary locus analysis tsv
    inputBinding:
      position: 101
      prefix: --ehdn-results
  - id: annovar_annotate_variation
    type: File
    doc: ANNOVAR annotate_variation.pl script path
    inputBinding:
      position: 101
      prefix: --annovar-annotate-variation
  - id: annovar_humandb
    type: Directory
    doc: ANNOVAR humandb directory
    inputBinding:
      position: 101
      prefix: --annovar-humandb
  - id: annovar_buildver
    type: string
    doc: ANNOVAR buildver option (hg19, hg38, ...)
    inputBinding:
      position: 101
      prefix: --annovar-buildver
  - id: ehdn_annotated_results
    type: string
    doc: ExpansionHunterDenovo annotated output filename
    inputBinding:
      position: 102
      prefix: --ehdn-annotated-results
outputs:
  - id: annotated_results
    type:
      - 'null'
      - File
    doc: Annotated results
    outputBinding:
      glob: $(inputs.ehdn_annotated_results)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
