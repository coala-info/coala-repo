cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_demodulate
label: relion_relion_demodulate
doc: "Remove the CTF-related modulation (high-resolution noise demodulation) from particles.\n\nTool homepage:\
  \ https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input STAR file with a list of particles
    inputBinding:
      position: 101
      prefix: --i
  - id: output_path
    type: string
    doc: Output path
    inputBinding:
      position: 101
      prefix: --out
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of OMP threads (RELION default: 6)'
    inputBinding:
      position: 101
      prefix: --j
  - id: r31
    type:
      - 'null'
      - boolean
    doc: Write output in Relion-3.1 format
    inputBinding:
      position: 101
      prefix: --r31
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the demodulated particle images
    outputBinding:
      glob: $(inputs.output_path)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_demodulate.out
