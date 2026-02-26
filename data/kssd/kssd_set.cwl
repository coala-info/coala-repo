cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kssd
  - set
label: kssd_set
doc: "The set doc prefix.\n\nTool homepage: https://github.com/yhg926/public_kssd"
inputs:
  - id: combined_sketch
    type: File
    doc: combined sketch
    inputBinding:
      position: 1
  - id: combin_pan
    type:
      - 'null'
      - boolean
    doc: combine pan files to combco file.
    inputBinding:
      position: 102
      prefix: --combin_pan
  - id: grouping
    type:
      - 'null'
      - File
    doc: grouping genomes by input category file.
    inputBinding:
      position: 102
      prefix: --grouping
  - id: intsect
    type:
      - 'null'
      - File
    doc: intersect with the pan-sketch for all input sketches.
    inputBinding:
      position: 102
      prefix: --intsect
  - id: print_genome_names
    type:
      - 'null'
      - boolean
    doc: print genome names.
    inputBinding:
      position: 102
      prefix: --print
  - id: subtract
    type:
      - 'null'
      - File
    doc: subtract the pan-sketch from all input sketches.
    inputBinding:
      position: 102
      prefix: --subtract
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    inputBinding:
      position: 102
      prefix: --threads
  - id: union
    type:
      - 'null'
      - boolean
    doc: get union set of the sketches.
    inputBinding:
      position: 102
      prefix: --union
  - id: uniq_union
    type:
      - 'null'
      - boolean
    doc: get uniq union set of the sketches.
    inputBinding:
      position: 102
      prefix: --uniq_union
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: specify the output directory.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kssd:2.21--h577a1d6_3
