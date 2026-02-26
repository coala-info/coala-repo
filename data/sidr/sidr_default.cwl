cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sidr
  - default
label: sidr_default
doc: "Runs the default analysis using raw preassembly data.\n\nTool homepage: https://github.com/damurdock/SIDR"
inputs:
  - id: bam_file
    type: File
    doc: Alignment of reads to preliminary assembly, in BAM format.
    inputBinding:
      position: 101
      prefix: --bam
  - id: blast_results_file
    type: File
    doc: Classification of preliminary assembly from BLAST (or similar tools).
    inputBinding:
      position: 101
      prefix: --blastresults
  - id: classification_level
    type:
      - 'null'
      - string
    doc: The classification level to use when constructing the model.
    default: phylum
    inputBinding:
      position: 101
      prefix: --level
  - id: contigs_to_keep_path
    type:
      - 'null'
      - File
    doc: Location to save the contigs identified as the target organism 
      (optional).
    inputBinding:
      position: 101
      prefix: --tokeep
  - id: contigs_to_remove_path
    type:
      - 'null'
      - File
    doc: Location to save the contigs identified as not belonging to the target 
      organism (optional).
    inputBinding:
      position: 101
      prefix: --toremove
  - id: fasta_file
    type: File
    doc: Preliminary assembly, in FASTA format.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: target_organism
    type:
      - 'null'
      - string
    doc: The identity of the target organism at the chosen classification level.
      It is recommended to use the organism's phylum.
    inputBinding:
      position: 101
      prefix: --target
  - id: taxdump_path
    type:
      - 'null'
      - Directory
    doc: Location of the NCBI Taxonomy dump.
    default: $BLASTDB
    inputBinding:
      position: 101
      prefix: --taxdump
  - id: use_binary_classification
    type:
      - 'null'
      - boolean
    doc: Use binary target/nontarget classification.
    inputBinding:
      position: 101
      prefix: --binary
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: Output path
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sidr:0.0.2a2--pyh3252c3a_0
