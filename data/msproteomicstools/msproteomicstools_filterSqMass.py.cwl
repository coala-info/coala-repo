cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - filterSqMass.py
label: msproteomicstools_filterSqMass.py
doc: "Filter chromatograms of an sqMass file by native id or by a TSV file.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: infile
    type: File
    doc: "An input file"
    inputBinding:
      prefix: --in
  - id: output_path
    type: string
    doc: "An output file"
    inputBinding:
      prefix: --out
  - id: chrom_filter
    type: ['null', string]
    doc: "Filter chromatograms by native id"
    inputBinding:
      prefix: --chrom_filter
  - id: tsv_filter
    type: ['null', File]
    doc: "Filter chromatograms by TSV file"
    inputBinding:
      prefix: --tsv_filter
outputs:
  - id: output
    type: File
    doc: "Filtered sqMass file"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_filterSqMass.py.out
