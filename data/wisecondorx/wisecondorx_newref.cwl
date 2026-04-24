cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wisecondorx
  - newref
label: wisecondorx_newref
doc: "Create a new reference using healthy reference samples\n\nTool homepage: https://github.com/CenterForMedicalGeneticsGhent/wisecondorX"
inputs:
  - id: infiles
    type:
      type: array
      items: File
    doc: Path to all reference data files (e.g. path/to/reference/*.npz)
    inputBinding:
      position: 1
  - id: binsize
    type:
      - 'null'
      - float
    doc: Scale samples to this binsize, multiples of existing binsize only
    inputBinding:
      position: 102
      prefix: --binsize
  - id: cpus
    type:
      - 'null'
      - int
    doc: Use multiple cores to find reference bins
    inputBinding:
      position: 102
      prefix: --cpus
  - id: nipt
    type:
      - 'null'
      - boolean
    doc: Use flag for NIPT (e.g. path/to/reference/*.npz)
    inputBinding:
      position: 102
      prefix: --nipt
  - id: plotyfrac
    type:
      - 'null'
      - File
    doc: Path to yfrac .png plot for --yfrac optimization (e.g. 
      path/to/plot.png); software will stop after plotting after which --yfrac 
      can be set manually
    inputBinding:
      position: 102
      prefix: --plotyfrac
  - id: refsize
    type:
      - 'null'
      - int
    doc: Amount of reference locations per target
    inputBinding:
      position: 102
      prefix: --refsize
  - id: yfrac
    type:
      - 'null'
      - float
    doc: Use to manually set the y read fraction cutoff, which defines gender
    inputBinding:
      position: 102
      prefix: --yfrac
outputs:
  - id: outfile
    type: File
    doc: Path and filename for the reference output (e.g. path/to/myref.npz)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wisecondorx:1.2.9--pyhdfd78af_0
