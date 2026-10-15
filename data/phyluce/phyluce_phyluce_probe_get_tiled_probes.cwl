cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_probe_get_tiled_probes
label: phyluce_phyluce_probe_get_tiled_probes
doc: "Tile sequence capture probes across fastas.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input_file
    type: File
    doc: The path to the input file
    inputBinding:
      prefix: --input
  - id: output_path
    type: string
    doc: The path to the output file
    inputBinding:
      prefix: --output
  - id: probe_prefix
    type: string
    doc: The prefix (e.g. "uce-") to add to all probes designed
    inputBinding:
      prefix: --probe-prefix
  - id: designer
    type: string
    doc: Your last name (to indicate who designed the probes)
    inputBinding:
      prefix: --designer
  - id: design
    type: string
    doc: The design name.
    inputBinding:
      prefix: --design
  - id: probe_length
    type:
      - 'null'
      - int
    doc: The length of the probes sequence to design
    inputBinding:
      prefix: --probe-length
  - id: tiling_density
    type:
      - 'null'
      - float
    doc: The tiling density
    inputBinding:
      prefix: --tiling-density
  - id: overlap
    type:
      - 'null'
      - type: enum
        symbols:
          - middle
          - flush-left
    doc: The method of tiling
    inputBinding:
      prefix: --overlap
  - id: probe_bed
    type:
      - 'null'
      - string
    doc: The path to an output file for outputting the probe coordinates in BED format
    inputBinding:
      prefix: --probe-bed
  - id: locus_bed
    type:
      - 'null'
      - string
    doc: The path to an output file for outputting the locus coordinates in BED format
    inputBinding:
      prefix: --locus-bed
  - id: masking
    type:
      - 'null'
      - float
    doc: The maximum frequency of per-probe masking allowed containing the sequence
    inputBinding:
      prefix: --masking
  - id: do_not_remove_ambiguous
    type:
      - 'null'
      - boolean
    doc: Do not remove loci with probes containing ambiguous bases
    inputBinding:
      prefix: --do-not-remove-ambiguous
  - id: remove_gc
    type:
      - 'null'
      - boolean
    doc: Remove loci with GC content outside 30 <= GC <= 70
    inputBinding:
      prefix: --remove-gc
  - id: start_index
    type:
      - 'null'
      - int
    doc: The starting UCE index number to use.
    inputBinding:
      prefix: --start-index
  - id: two_probes
    type:
      - 'null'
      - boolean
    doc: Design only two probes for a given locus.
    inputBinding:
      prefix: --two-probes
outputs:
  - id: output
    type: File
    doc: The designed probe file.
    outputBinding:
      glob: $(inputs.output_path)
  - id: probe_bed_out
    type:
      - 'null'
      - File
    doc: The BED file of probe coordinates (when --probe-bed is set).
    outputBinding:
      glob: '$(inputs.probe_bed ? [inputs.probe_bed] : [])'
  - id: locus_bed_out
    type:
      - 'null'
      - File
    doc: The BED file of locus coordinates (when --locus-bed is set).
    outputBinding:
      glob: '$(inputs.locus_bed ? [inputs.locus_bed] : [])'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
