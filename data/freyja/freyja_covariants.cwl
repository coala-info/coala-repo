cwlVersion: v1.2
class: CommandLineTool
baseCommand: freyja_covariants
label: freyja_covariants
doc: "Calls physically linked mutations in BAM_FILE using coVar (https://github.com/andersen-lab/covar)\n\
  \nTool homepage: https://github.com/andersen-lab/Freyja"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: annot
    type:
      - 'null'
      - File
    doc: Path to gff file corresponding to reference genome
    inputBinding:
      position: 102
      prefix: --annot
  - id: end_site
    type:
      - 'null'
      - string
    doc: Maximum genomic coordinate to consider (defaults to full genome)
    inputBinding:
      position: 102
      prefix: --end_site
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum count for a set of mutations to be saved
    inputBinding:
      position: 102
      prefix: --min_depth
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum quality for a base to be considered
    inputBinding:
      position: 102
      prefix: --min_quality
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference genome FASTA file
    inputBinding:
      position: 102
      prefix: --reference
  - id: start_site
    type:
      - 'null'
      - int
    doc: Minimum genomic coordinate to consider
    inputBinding:
      position: 102
      prefix: --start_site
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
