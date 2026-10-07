cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - interactions
  - fragments-to-bins
label: capcruncher_interactions_fragments-to-bins
doc: "Convert a cooler group containing restriction fragments to constant genomic windows; optionally adds normalised counts.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: cooler_path
    type: File
    doc: "Cooler HDF5 file with restriction fragment counts"
    inputBinding:
      position: 1
  - id: binsizes
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: -b
    doc: "Binsizes to use for windowing"
    inputBinding:
      position: 2
  - id: normalise
    type:
      - 'null'
      - boolean
    doc: "Enables normalisation of interaction counts during windowing"
    inputBinding:
      position: 2
      prefix: --normalise
  - id: overlap_fraction
    type:
      - 'null'
      - float
    doc: "Minimum overlap between genomic bins and restriction fragments for overlap"
    inputBinding:
      position: 2
      prefix: --overlap_fraction
  - id: n_cores
    type:
      - 'null'
      - int
    doc: "Number of cores used for binning"
    inputBinding:
      position: 2
      prefix: -p
  - id: scale_factor
    type:
      - 'null'
      - int
    doc: "Scaling factor used for normalisation"
    inputBinding:
      position: 2
      prefix: --scale-factor
  - id: conversion_tables
    type:
      - 'null'
      - File
    doc: "Pickle file containing pre-computed fragment -> bin conversions."
    inputBinding:
      position: 2
      prefix: --conversion_tables
  - id: output
    type: string
    default: out.hdf5
    doc: "Name of output file. (Cooler formatted hdf5 file)"
    inputBinding:
      position: 2
      prefix: -o
  - id: assay
    type:
      - 'null'
      - string
    doc: "Assay type: capture, tri or tiled"
    inputBinding:
      position: 2
      prefix: --assay
outputs:
  - id: binned_cooler
    type: File
    doc: "Binned cooler HDF5 file"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
