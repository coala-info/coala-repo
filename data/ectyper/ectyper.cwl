cwlVersion: v1.2
class: CommandLineTool
baseCommand: ectyper
label: ectyper
doc: "Prediction of Escherichia coli serotype, pathotype and shiga toxin tying from
  raw reads or assembled genome sequences. The default settings are recommended.\n\
  \nTool homepage: https://github.com/phac-nml/ecoli_serotyping"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: Location of E. coli genome file(s). Can be a single file, a 
      comma-separated list of files, or a directory
    inputBinding:
      position: 1
  - id: cores
    type:
      - 'null'
      - int
    doc: The number of cores to run ectyper with
    inputBinding:
      position: 102
      prefix: --cores
  - id: dbpath
    type:
      - 'null'
      - Directory
    doc: Path to a custom database of O and H antigen alleles in JSON format.
    inputBinding:
      position: 102
      prefix: --dbpath
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print more detailed log including debug messages
    inputBinding:
      position: 102
      prefix: --debug
  - id: longreads
    type:
      - 'null'
      - boolean
    doc: Enable for raw long reads FASTQ inputs (ONT, PacBio, other sequencing 
      platforms).
    default: false
    inputBinding:
      position: 102
      prefix: --longreads
  - id: maxdirdepth
    type:
      - 'null'
      - int
    doc: Maximum number of directories to descend when searching an input 
      directory of files. Only works on path inputs not containing '*' wildcard
    default: 0
    inputBinding:
      position: 102
      prefix: --maxdirdepth
  - id: pathotype
    type:
      - 'null'
      - boolean
    doc: Predict E.coli pathotype and Shiga toxin subtype(s) if present
    inputBinding:
      position: 102
      prefix: --pathotype
  - id: percent_coverage_htype
    type:
      - 'null'
      - float
    doc: Minimum percent coverage required for an H antigen allele match
    default: 50
    inputBinding:
      position: 102
      prefix: --percentCoverageHtype
  - id: percent_coverage_otype
    type:
      - 'null'
      - float
    doc: Minimum percent coverage required for an O antigen allele match
    default: 90
    inputBinding:
      position: 102
      prefix: --percentCoverageOtype
  - id: percent_coverage_pathotype
    type:
      - 'null'
      - float
    doc: Minimum percent coverage required for a pathotype reference allele 
      match
    default: 50
    inputBinding:
      position: 102
      prefix: --percentCoveragePathotype
  - id: percent_identity_htype
    type:
      - 'null'
      - float
    doc: Percent identity required for an H antigen allele match
    default: 95
    inputBinding:
      position: 102
      prefix: --percentIdentityHtype
  - id: percent_identity_otype
    type:
      - 'null'
      - float
    doc: Percent identity required for an O antigen allele match
    default: 95
    inputBinding:
      position: 102
      prefix: --percentIdentityOtype
  - id: percent_identity_pathotype
    type:
      - 'null'
      - float
    doc: Minimum percent identity required for a pathotype reference allele 
      match
    default: 90
    inputBinding:
      position: 102
      prefix: --percentIdentityPathotype
  - id: reference
    type:
      - 'null'
      - File
    doc: Location of pre-computed MASH sketch for species identification. If 
      provided, genomes identified as non-E. coli will have their species 
      identified using MASH dist
    inputBinding:
      position: 102
      prefix: --reference
  - id: sequence
    type:
      - 'null'
      - boolean
    doc: Prints the allele sequences if enabled as the final columns of the 
      output
    inputBinding:
      position: 102
      prefix: --sequence
  - id: verify
    type:
      - 'null'
      - boolean
    doc: Enable E. coli species verification and additional QC checks
    default: false
    inputBinding:
      position: 102
      prefix: --verify
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Directory location of output files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ectyper:2.0.0--pyhdfd78af_4
