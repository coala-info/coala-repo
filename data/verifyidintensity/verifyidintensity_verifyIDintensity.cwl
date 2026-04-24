cwlVersion: v1.2
class: CommandLineTool
baseCommand: verifyIDintensity
label: verifyidintensity_verifyIDintensity
doc: "Command description message\n\nTool homepage: https://genome.sph.umich.edu/wiki/VerifyIDintensity"
inputs:
  - id: abf
    type:
      - 'null'
      - string
    doc: Allele frequency file (ABF), which is a plain text file with SNP_ID and
      Allele_B frequency
    inputBinding:
      position: 101
      prefix: --abf
  - id: ignore_rest
    type:
      - 'null'
      - boolean
    doc: Ignores the rest of the labeled arguments following this flag.
    inputBinding:
      position: 101
      prefix: --ignore_rest
  - id: input_intensity
    type: string
    doc: Input intensity (.adpc.bin) file
    inputBinding:
      position: 101
      prefix: --in
  - id: marker
    type: int
    doc: Number of markers
    inputBinding:
      position: 101
      prefix: --marker
  - id: number
    type: int
    doc: Number of samples
    inputBinding:
      position: 101
      prefix: --number
  - id: persample
    type:
      - 'null'
      - boolean
    doc: Do per-sample analysis, default is per-marker analysis
    inputBinding:
      position: 101
      prefix: --persample
  - id: stat
    type:
      - 'null'
      - string
    doc: Statistics file (created if not exist)
    inputBinding:
      position: 101
      prefix: --stat
  - id: threshold
    type:
      - 'null'
      - float
    doc: Minimum allele frequency for likelihood estimation
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose mode
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verifyidintensity:0.0.1--h077b44d_6
stdout: verifyidintensity_verifyIDintensity.out
