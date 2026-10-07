cwlVersion: v1.2
class: CommandLineTool
baseCommand: cas-offinder
label: cas-offinder
doc: "Cas-OFFinder v2.4.1 (Jul 24 2025)\n\nTool homepage: https://github.com/snugel/cas-offinder"
inputs:
  - id: input_filename
    type: File
    doc: Input file (genome directory, PAM pattern, query sequences with mismatch
      counts)
    inputBinding:
      position: 1
  - id: device_type_and_ids
    type: string
    doc: Device type (C, G, A) and device ID(s)
    inputBinding:
      position: 2
  - id: output_filename
    type: string
    doc: Output filename
    inputBinding:
      position: 3
  - id: genome_dir
    type:
      - 'null'
      - Directory
    doc: Directory of FASTA or 2bit chromosome files named on the first line of
      the input file. It is staged in the working directory under its own name,
      so the first line of the input file should be that name.
outputs:
  - id: output
    type: File
    doc: Output file with the off-target sites
    outputBinding:
      glob: $(inputs.output_filename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.genome_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cas-offinder:2.4.1--h503566f_0
