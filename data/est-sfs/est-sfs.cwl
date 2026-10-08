cwlVersion: v1.2
class: CommandLineTool
baseCommand: est-sfs
label: est-sfs
doc: "Estimate the unfolded site frequency spectrum (SFS) and the probability that the major allele is ancestral, from allele counts in an ingroup and one to three outgroups.\n\nThe seed file is updated by the program, so it is staged as a writable copy.\n\nTool homepage: https://sourceforge.net/projects/est-usfs/"
inputs:
  - id: config_file_name
    type: File
    doc: Configuration file name
    inputBinding:
      position: 1
  - id: input_file_name
    type: File
    doc: Input file name
    inputBinding:
      position: 2
  - id: seedfile_name
    type: File
    doc: Seed file name (the program writes a new seed back into this file)
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  - id: output_file_sfs
    type: string
    doc: Output SFS file name
    inputBinding:
      position: 4
  - id: output_file_p_anc
    type: string
    doc: Output P(anc) file name
    inputBinding:
      position: 5
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Optional verbose output flag
    inputBinding:
      position: 6
      prefix: verbose
outputs:
  - id: sfs
    type: File
    doc: Output SFS file
    outputBinding:
      glob: $(inputs.output_file_sfs)
  - id: p_anc
    type: File
    doc: Output P(anc) file
    outputBinding:
      glob: $(inputs.output_file_p_anc)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.seedfile_name)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/est-sfs:2.04--h985cbd6_1
stdout: est-sfs.out
