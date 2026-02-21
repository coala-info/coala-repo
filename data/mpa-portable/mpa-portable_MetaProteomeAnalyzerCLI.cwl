cwlVersion: v1.2
class: CommandLineTool
baseCommand: MetaProteomeAnalyzerCLI
label: mpa-portable_MetaProteomeAnalyzerCLI
doc: "MetaProteomeAnalyzer (MPA) is a tool for metaproteomics data analysis. (Note:
  The provided help text contains only system error messages regarding container execution
  and does not list available arguments.)\n\nTool homepage: https://github.com/compomics/meta-proteome-analyzer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mpa-portable:2.0.0--0
stdout: mpa-portable_MetaProteomeAnalyzerCLI.out
