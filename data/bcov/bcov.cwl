cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcov
label: bcov
doc: "Computes beta strand pairing and contact maps from Multiple Sequence Alignments
  (MSAs) or pre-computed contact matrices.\n\nTool homepage: http://biocomp.unibo.it/savojard/bcov/index.html"
inputs:
  - id: beta_strand_boundaries_file
    type: File
    doc: Read beta strand boundaries from file. REQUIRED.
    inputBinding:
      position: 101
      prefix: -s
  - id: input_contact_matrix_file
    type:
      - 'null'
      - File
    doc: Read a pre-computed residue contact score matrix from file. This option
      conflicts with the -c option. REQUIRED if -a is not set
    inputBinding:
      position: 101
      prefix: -m
  - id: input_msa_file
    type:
      - 'null'
      - File
    doc: Input MSA file in the PSICOV format. A contact score matrix is 
      internally computed using the PSICOV method (Jones et al., 2012). This 
      option conflicts with the -m option. REQUIRED if -m is not set
    inputBinding:
      position: 101
      prefix: -a
  - id: min_sequence_separation
    type:
      - 'null'
      - int
    doc: 'Minimum sequence separation for parallel strand pairing. 0 = no threshold.
      OPTIONAL, default: 6'
    default: 6
    inputBinding:
      position: 101
      prefix: -n
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: 'Verbose level, 0/1 (default: 0).'
    default: 0
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_beta_contact_map_file
    type: File
    doc: Write predicted beta contact map to file. REQUIRED.
    outputBinding:
      glob: $(inputs.output_beta_contact_map_file)
  - id: output_beta_strand_pairing_file
    type: File
    doc: Write predicted beta strand pairing to file. REQUIRED.
    outputBinding:
      glob: $(inputs.output_beta_strand_pairing_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcov:1.0--h67df5e2_11
