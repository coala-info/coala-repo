cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_get_bed_from_lastz]
label: phyluce_phyluce_align_get_bed_from_lastz
doc: "Output a BED file from a LASTZ alignment.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: lastz
    type: File
    doc: "The input lastz file."
    inputBinding:
      position: 1
      prefix: --lastz
  - id: output
    type: string
    doc: "The output BED file."
    inputBinding:
      position: 2
      prefix: --output
  - id: identity
    type: ['null', float]
    doc: "The minimum percent identity to output (default: 90.0)."
    inputBinding:
      position: 3
      prefix: --identity
  - id: continuity
    type: ['null', float]
    doc: "The minimum percent continuity to output (default: 90.0)."
    inputBinding:
      position: 4
      prefix: --continuity
  - id: long_format
    type: ['null', boolean]
    doc: "Long-format LASTZ file."
    inputBinding:
      position: 5
      prefix: --long-format
  - id: conf
    type: ['null', File]
    doc: "A python INI formatted file containing loci to keep."
    inputBinding:
      position: 6
      prefix: --conf
  - id: sections
    type:
      - 'null'
      - type: array
        items: string
    doc: "The sections of files to move."
    inputBinding:
      position: 7
      prefix: --sections
outputs:
  - id: output_bed
    type: File
    doc: "BED file of the LASTZ matches."
    outputBinding:
      glob: "$(inputs.output)"
  - id: report
    type: stdout
    doc: "Names of loci that fell below the identity or continuity cut-off."
stdout: phyluce_align_get_bed_from_lastz.stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
