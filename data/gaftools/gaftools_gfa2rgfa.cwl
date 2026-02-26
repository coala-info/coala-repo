cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gaftools
  - gfa2rgfa
label: gaftools_gfa2rgfa
doc: "Converting a GFA file to rGFA format using the W-lines and the acyclic reference
  path. (e.g., minigraph-based graphs)\n\nTool homepage: https://github.com/marschall-lab/gaftools"
inputs:
  - id: gfa_file
    type: File
    doc: GFA file (can be bgzip-compressed). This GFA should have a W-line 
      corresponding to the reference genome or the reference nodes have to be 
      tagged already.
    inputBinding:
      position: 1
  - id: reference_name
    type:
      - 'null'
      - string
    doc: The name of the reference genome given in the W-line.
    default: CHM13
    inputBinding:
      position: 102
      prefix: --reference-name
  - id: reference_tagged
    type:
      - 'null'
      - boolean
    doc: Flag to denote reference nodes are already tagged in the GFA.
    inputBinding:
      position: 102
      prefix: --reference-tagged
  - id: seqfile
    type:
      - 'null'
      - File
    doc: 'File containing the sequence in which assemblies were given. Provide the
      seqfile given as part of running minigraph-cactus (only the first column is
      required). It has the format: <assembly_name><tab><assembly_path>. If not provided,
      the order of assemblies will be taken from the GFA file. User-defined order
      of assemblies can also be given. There should be W lines for each assembly in
      the GFA.'
    inputBinding:
      position: 102
      prefix: --seqfile
outputs:
  - id: output_rgfa
    type:
      - 'null'
      - File
    doc: Output rGFA (bgzipped if the file ends with .gz). If omitted, use 
      standard output.
    outputBinding:
      glob: $(inputs.output_rgfa)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
