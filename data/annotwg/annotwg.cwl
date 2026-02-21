cwlVersion: v1.2
class: CommandLineTool
baseCommand: annotwg
label: annotwg
doc: "AnnotWG annotate a WG bgzipped and tabixed VCF file\n\nTool homepage: https://gitlab.com/cnrgh/annotwg"
inputs:
  - id: annot
    type: File
    doc: path to an annotation file (bcf format csi indexed)
    inputBinding:
      position: 101
      prefix: --annot
  - id: annot_list
    type:
      - 'null'
      - string
    doc: a comma separated list of INFO features to annotate (all annotations by default)
    inputBinding:
      position: 101
      prefix: --annot-list
  - id: annotprefix
    type:
      - 'null'
      - string
    doc: prefix that will be added before every annotation from the annotation file
    default: "''"
    inputBinding:
      position: 101
      prefix: --annotprefix
  - id: compression_level
    type:
      - 'null'
      - int
    doc: The level of compression (integer from 1 to 9) (optional)
    default: -1
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: id
    type:
      - 'null'
      - boolean
    doc: Annotate the ID field from the annotation source
    inputBinding:
      position: 101
      prefix: --id
  - id: indexing
    type:
      - 'null'
      - boolean
    doc: perform on the fly csi index generation of the ouput
    inputBinding:
      position: 101
      prefix: --indexing
  - id: join_alleles
    type:
      - 'null'
      - boolean
    doc: Annotation of splitted alleles can skip variants with bcftools. This flag
      try to use bcftools norm -m + to join alleles to correct this behavior
    inputBinding:
      position: 101
      prefix: --join-alleles
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'b: compressed BCF, z: compressed VCF'
    default: z
    inputBinding:
      position: 101
      prefix: --output-format
  - id: reference
    type: File
    doc: indexed fasta genome reference (.fai or .dict format)
    inputBinding:
      position: 101
      prefix: --reference
  - id: tbi
    type:
      - 'null'
      - boolean
    doc: generate a tbi index instead of csi
    inputBinding:
      position: 101
      prefix: --tbi
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: path to annotWG temporary directory
    default: working directory
    inputBinding:
      position: 101
      prefix: --tempdir
  - id: thread
    type:
      - 'null'
      - int
    doc: number of threads used by annotwg (optional)
    default: 1
    inputBinding:
      position: 101
      prefix: --thread
  - id: vcf
    type: File
    doc: vcf file bgzipped and indexed with tabix to annotate
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output, e.g. annotated VCF file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/annotwg:1.0--hdfd78af_1
