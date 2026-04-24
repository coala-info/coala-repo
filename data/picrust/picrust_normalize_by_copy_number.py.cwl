cwlVersion: v1.2
class: CommandLineTool
baseCommand: normalize_by_copy_number.py
label: picrust_normalize_by_copy_number.py
doc: "Normalize the OTU abundances for a given OTU table picked against the newest
  version of Greengenes\n\nTool homepage: http://picrust.github.com"
inputs:
  - id: gg_version
    type:
      - 'null'
      - string
    doc: 'Version of GreenGenes that was used for OTU picking. Valid choices are:
      13_5, 18may2012'
    inputBinding:
      position: 101
      prefix: --gg_version
  - id: input_count_fp
    type:
      - 'null'
      - File
    doc: 'Precalculated input marker gene copy number predictions on per otu basis
      in biom format (can be gzipped).Note: using this option overrides --gg_version.'
    inputBinding:
      position: 101
      prefix: --input_count_fp
  - id: input_otu_fp
    type: File
    doc: the input otu table filepath in biom format
    inputBinding:
      position: 101
      prefix: --input_otu_fp
  - id: load_precalc_file_in_biom
    type:
      - 'null'
      - boolean
    doc: Instead of loading the precalculated file in tab- delimited format 
      (with otu ids as row ids and traits as columns) load the data in biom 
      format (with otu as SampleIds and traits as ObservationIds)
    inputBinding:
      position: 101
      prefix: --load_precalc_file_in_biom
  - id: metadata_identifer
    type:
      - 'null'
      - string
    doc: identifier for copy number entry as observation metadata
    inputBinding:
      position: 101
      prefix: --metadata_identifer
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print information during execution -- useful for debugging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_otu_fp
    type: File
    doc: the output otu table filepath in biom format
    outputBinding:
      glob: $(inputs.output_otu_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust:1.1.4--pyh24bf2e0_0
