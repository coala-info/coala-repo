cwlVersion: v1.2
class: CommandLineTool
baseCommand: PreProcessR
label: strainr2_PreProcessR
doc: "PreProcessR counts the unique hashes in subcontigs for StrainR to normalize
  reads with.\n\nTool homepage: https://github.com/BisanzLab/StrainR2"
inputs:
  - id: excludesize
    type:
      - 'null'
      - int
    doc: exclude subcontig size (minimum subcontig size)
    inputBinding:
      position: 101
      prefix: --excludesize
  - id: indir
    type: Directory
    doc: path to the directory for all community genomes
    inputBinding:
      position: 101
      prefix: --indir
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: path to your output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: readsize
    type:
      - 'null'
      - int
    doc: 'Size of one end of a read. e.g.: for 150bp paired end reads readsize is
      150.'
    inputBinding:
      position: 101
      prefix: --readsize
  - id: singleend
    type:
      - 'null'
      - boolean
    doc: Flag that should be used if only single end reads will be provided to 
      StrainR2. Disabled by default.
    inputBinding:
      position: 101
      prefix: --singleend
  - id: subcontigsize
    type:
      - 'null'
      - int
    doc: maximum subcontig size (overrides default use of calculated smallest 
      N50)
    inputBinding:
      position: 101
      prefix: --subcontigsize
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainr2:2.3.0--r44h577a1d6_0
stdout: strainr2_PreProcessR.out
