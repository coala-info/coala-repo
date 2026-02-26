cwlVersion: v1.2
class: CommandLineTool
baseCommand: deamSim
label: gargammel-slim_deamSim
doc: "Reads a fasta (default) or BAM file containing aDNA fragments and adds deamination
  according to a certain model file. Some model files are found in the models/ directory.
  If the input is fasta, the output will be fasta as well.\n\nTool homepage: https://github.com/grenaud/gargammel"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: fasta or BAM file
    inputBinding:
      position: 1
  - id: ancient_dna_matrix
    type:
      - 'null'
      - string
    doc: For default matrices, use either "single" or "double" (without quotes).
      Single strand will have C->T damage on both ends. Double strand will have 
      and C->T at the 5p end and G->A damage at the 3p end
    inputBinding:
      position: 102
      prefix: -mat
  - id: briggs_model_params
    type:
      - 'null'
      - string
    doc: 'For the Briggs et al. 2007 model. The parameters must be comma-separated
      e.g.: -damage 0.03,0.4,0.01,0.7. v: nick frequency, l: length of overhanging
      ends (geometric parameter), d: prob. of deamination of Cs in double-stranded
      parts, s: prob. of deamination of Cs in single-stranded parts'
    inputBinding:
      position: 102
      prefix: -damage
  - id: mapdamage_misincorporation_file
    type:
      - 'null'
      - File
    doc: Read the miscorporation file produced by mapDamage
    inputBinding:
      position: 102
      prefix: -mapdamage
  - id: mapdamage_protocol
    type:
      - 'null'
      - string
    doc: "[protocol] can be either \"single\" or \"double\" (without quotes). Single
      strand will have C->T damage on both ends. Double strand will have and C->T
      at the 5' end and G->A damage at the 3' end"
    inputBinding:
      position: 102
      prefix: -mapdamage
  - id: matfile_prefix
    type:
      - 'null'
      - string
    doc: Read the matrix file of substitutions instead of the default. Provide 
      the prefix only, both files must end with 5.dat and 3.dat
    inputBinding:
      position: 102
      prefix: -matfile
  - id: matfilemeth_prefix
    type:
      - 'null'
      - string
    doc: Read the matrix file of substitutions for methylated Cs. Provide the 
      prefix only, both files must end with 5.dat and 3.dat
    inputBinding:
      position: 102
      prefix: -matfilemeth
  - id: matfilenonmeth_prefix
    type:
      - 'null'
      - string
    doc: Read the matrix file of substitutions for non-methylated Cs. Provide 
      the prefix only, both files must end with 5.dat and 3.dat
    inputBinding:
      position: 102
      prefix: -matfilenonmeth
  - id: output_bam
    type:
      - 'null'
      - boolean
    doc: 'Read BAM and write output as a BAM (default: fasta)'
    inputBinding:
      position: 102
      prefix: -b
  - id: tag_read_name
    type:
      - 'null'
      - boolean
    doc: Put a tag in the read name with deam bases (default not on/not used)
    inputBinding:
      position: 102
      prefix: -name
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: Produce uncompressed BAM (good for unix pipe)
    inputBinding:
      position: 102
      prefix: -u
  - id: use_last_row_for_subst_rates
    type:
      - 'null'
      - boolean
    doc: 'If matfile is used, do not use the substitution rates of the last row over
      the rest of the molecule (default: no data = use last row)'
    inputBinding:
      position: 102
      prefix: -last
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 102
      prefix: -v
  - id: zipped_fasta_out
    type:
      - 'null'
      - boolean
    doc: Write fasta output as a zipped fasta
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gargammel-slim:1.1.2--hf107e4d_6
stdout: gargammel-slim_deamSim.out
