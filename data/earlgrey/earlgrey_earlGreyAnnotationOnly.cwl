cwlVersion: v1.2
class: CommandLineTool
baseCommand: earlGreyAnnotationOnly
label: earlgrey_earlGreyAnnotationOnly
doc: "earlGrey version 7.0.2 (AnnotationOnly)\n\nTool homepage: https://github.com/TobyBaril/EarlGrey"
inputs:
  - id: create_softmasked_genome
    type:
      - 'null'
      - string
    doc: Create soft-masked genome at the end?
    default: no
    inputBinding:
      position: 101
      prefix: -d
  - id: genome_fasta
    type: File
    doc: genome.fasta
    inputBinding:
      position: 101
      prefix: -g
  - id: remove_spurious_te
    type:
      - 'null'
      - string
    doc: Remove putative spurious TE annotations <100bp?
    default: no
    inputBinding:
      position: 101
      prefix: -m
  - id: repeatmasker_species
    type:
      - 'null'
      - string
    doc: RepeatMasker species for addition to custom library
    default: None
    inputBinding:
      position: 101
      prefix: -r
  - id: run_heliano
    type:
      - 'null'
      - string
    doc: Run HELIANO as an optional step to detect Helitrons
    default: no
    inputBinding:
      position: 101
      prefix: -e
  - id: species_name
    type: string
    doc: species name
    inputBinding:
      position: 101
      prefix: -s
  - id: starting_consensus_library
    type: File
    doc: Starting consensus library for annotation (in fasta format)
    inputBinding:
      position: 101
      prefix: -l
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of Threads (DO NOT specify more than are available)
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_directory
    type: Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/earlgrey:7.0.2--hd63eeec_0
