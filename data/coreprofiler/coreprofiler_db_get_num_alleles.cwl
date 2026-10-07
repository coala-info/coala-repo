cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coreprofiler
  - db
  - get_num_alleles
label: coreprofiler_db_get_num_alleles
doc: "Get number of alleles per locus.\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: scheme_dir
    type: Directory
    doc: Path to scheme files directory.
    inputBinding:
      position: 101
      prefix: --scheme_dir
  - id: output
    type: string
    doc: Output TSV file.
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: num_alleles
    type: File
    doc: TSV file with the number of alleles per locus.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
