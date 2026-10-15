cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_get_locus_bed_from_lastz_files
label: phyluce_phyluce_probe_get_locus_bed_from_lastz_files
doc: "Given an input directory of lastz files, write a directory of BED files giving\
  \ the locus locations\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input_dir
    type: Directory
    doc: The input directory containing lastz files
    inputBinding:
      prefix: --input
  - id: output_dir
    type: string
    doc: The output directory to hold BED-formatted files (created for you)
    inputBinding:
      prefix: --output
  - id: regex
    type: string
    doc: A regular expression to apply to the probe sequences for replacement (the
      tool fails without it; for example ^(uce-\d+)(?:_p\d+.*))
    inputBinding:
      prefix: --regex
outputs:
  - id: output
    type: Directory
    doc: The directory of BED files.
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({class: "Directory", basename: inputs.output_dir, listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
