cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_ctf_mask_test
label: relion_relion_ctf_mask_test
doc: "Test the effect of CTF-based masking of particles at different frequency steps.\n\nTool homepage:\
  \ https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input particle *.star file
    inputBinding:
      position: 101
      prefix: --i
  - id: s
    type: int
    doc: Image size
    inputBinding:
      position: 101
      prefix: --s
  - id: r
    type: float
    doc: Particle radius
    inputBinding:
      position: 101
      prefix: --r
  - id: t
    type: float
    doc: Frequency step
    inputBinding:
      position: 101
      prefix: --t
  - id: tw
    type: float
    doc: Filter step width
    inputBinding:
      position: 101
      prefix: --tw
  - id: output
    type: string
    doc: Output path
    inputBinding:
      position: 101
      prefix: --o
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
  - id: mg
    type:
      - 'null'
      - int
    doc: 'Micrograph index (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --mg
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Output files written with the output path as prefix
    outputBinding:
      glob: $(inputs.output)*
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_ctf_mask_test.out
