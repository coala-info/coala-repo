cwlVersion: v1.2
class: CommandLineTool
baseCommand: assignAlleleCodes_py3.6.py
label: allelecodes_assignAlleleCodes_py3.6.py
doc: "Calculates nearest neighbor in hierarchical, single-linkage framework to assign
  that neighbor's code up to the corresponding distance threshold, or a new code if
  no matches found\n\nTool homepage: https://github.com/ncezid-biome/AlleleCodes"
inputs:
  - id: alleles
    type: File
    doc: csv or tsv file. Unique Keys/IDs in first column with PulseNet locus 
      names as fields afterward, preceded with acceptable prefixes CAMP, EC, 
      LMO, or SALM (e.g. EC_1, EC_2, EC_3, etc.
    inputBinding:
      position: 101
      prefix: --alleles
  - id: config
    type: File
    doc: text file containing names of core loci to match against --alleles file
      to denote which loci should be used for assignment
    inputBinding:
      position: 101
      prefix: --config
  - id: data_dir
    type: Directory
    doc: directory where logs and data files will be written if --nosave is not 
      entered as input flag
    inputBinding:
      position: 101
      prefix: --dataDir
  - id: nosave
    type:
      - 'null'
      - boolean
    doc: whether results of run will overwrite historical allele profiles and 
      nomenclature tree
    default: false
    inputBinding:
      position: 101
      prefix: --nosave
  - id: prefix
    type: string
    doc: organism-specific prefix to be added to front of Allele Code (CAMP, EC,
      LMO, or SALM)
    inputBinding:
      position: 101
      prefix: --prefix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: output what's written to log file if provided
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file (tsv or csv) into which results will be written (delimiter 
      determined by input extension)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/allelecodes:2.1--py313hdfd78af_0
