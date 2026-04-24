cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genmod
  - annotate
label: genmod_annotate
doc: "Annotate vcf variants.\n\nAnnotate variants with a number of different sources.
  Please use --help for\nmore info.\n\nTool homepage: http://github.com/moonso/genmod"
inputs:
  - id: vcf_file
    type: File
    doc: Input VCF file or '-' for stdin
    inputBinding:
      position: 1
  - id: annotate_regions
    type:
      - 'null'
      - boolean
    doc: Annotate what regions a variant belongs to (eg. genes).
    inputBinding:
      position: 102
      prefix: --annotate_regions
  - id: cadd_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify the path to a bgzipped cadd file (with index) with variant 
      scores.
    inputBinding:
      position: 102
      prefix: --cadd-file
  - id: cadd_raw
    type:
      - 'null'
      - boolean
    doc: If the raw cadd scores should be annotated.
    inputBinding:
      position: 102
      prefix: --cadd-raw
  - id: cosmic
    type:
      - 'null'
      - File
    doc: Specify the path to a bgzipped vcf file (with index) with COSMIC 
      variants.
    inputBinding:
      position: 102
      prefix: --cosmic
  - id: exac
    type:
      - 'null'
      - File
    doc: Specify the path to a bgzipped vcf file (with index) with exac 
      variants.
    inputBinding:
      position: 102
      prefix: --exac
  - id: genome_build
    type:
      - 'null'
      - string
    doc: Choose what genome build to use.
    inputBinding:
      position: 102
      prefix: --genome-build
  - id: max_af
    type:
      - 'null'
      - boolean
    doc: If the MAX AF should be annotated
    inputBinding:
      position: 102
      prefix: --max-af
  - id: region_file
    type:
      - 'null'
      - File
    doc: Choose a bed file with regions that should be used.
    inputBinding:
      position: 102
      prefix: --region-file
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print the variants.
    inputBinding:
      position: 102
      prefix: --silent
  - id: spidex
    type:
      - 'null'
      - File
    doc: Specify the path to a bgzipped tsv file (with index) with spidex 
      information.
    inputBinding:
      position: 102
      prefix: --spidex
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Path to tempdir
    inputBinding:
      position: 102
      prefix: --temp_dir
  - id: thousand_g
    type:
      - 'null'
      - File
    doc: Specify the path to a bgzipped vcf file (with index) with 1000g 
      variants
    inputBinding:
      position: 102
      prefix: --thousand-g
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Specify the path to a file where results should be stored.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genmod:3.10.2--pyh7e72e81_0
