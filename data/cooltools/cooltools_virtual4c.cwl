cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooltools
  - virtual4c
label: cooltools_virtual4c
doc: "Generate virtual 4C profile from a contact map by extracting all interactions
  of a given viewpoint with the rest of the genome.\n\nTool homepage: https://github.com/mirnylab/cooltools"
inputs:
  - id: cool_path
    type: File
    doc: the paths to a .cool file with a Hi-C map. Use the '::' syntax to 
      specify a group path in a multicooler file.
    inputBinding:
      position: 1
  - id: viewpoint
    type: string
    doc: the viewpoint to use for the virtual 4C profile. Provide as a 
      UCSC-string (e.g. chr1:1-1000)
    inputBinding:
      position: 2
  - id: bigwig
    type:
      - 'null'
      - boolean
    doc: Also save virtual 4C track as a bigWig file with the name 
      out_prefix.v4C.bw
    inputBinding:
      position: 103
      prefix: --bigwig
  - id: clr_weight_name
    type:
      - 'null'
      - string
    doc: Use balancing weight with this name. Provide empty argument to 
      calculate insulation on raw data (no masking bad pixels).
    inputBinding:
      position: 103
      prefix: --clr-weight-name
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processes to split the work between.
    inputBinding:
      position: 103
      prefix: --nproc
outputs:
  - id: out_prefix
    type: File
    doc: Save virtual 4C track as a BED-like file. Contact frequency is stored 
      in out_prefix.v4C.tsv
    outputBinding:
      glob: $(inputs.out_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
