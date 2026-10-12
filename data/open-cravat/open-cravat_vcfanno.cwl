cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - oc
  - vcfanno
label: open-cravat_vcfanno
doc: "Annotate a VCF file with Open-CRAVAT annotators.\n\nTool homepage: http://www.opencravat.org"
inputs:
  - id: input_path
    type: File
    doc: "Input VCF file."
    inputBinding:
      position: 1
  - id: annotators
    type:
      - 'null'
      - string[]
    doc: "Annotator modules to use."
    inputBinding:
      position: 101
      prefix: "--annotators"
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of CPU threads to use."
    inputBinding:
      position: 101
      prefix: "--threads"
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: "Temporary directory for working files."
    inputBinding:
      position: 101
      prefix: "--temp-dir"
  - id: output_path
    type: string
    doc: "Output vcf path (gzipped). Defaults to input_path.oc.vcf.gz."
    inputBinding:
      position: 101
      prefix: "--output-path"
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: "Number of lines to annotate in each thread before syncing to disk."
    inputBinding:
      position: 101
      prefix: "--chunk-size"
outputs:
  - id: annotated_vcf
    type: File
    doc: "Annotated gzipped VCF"
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/open-cravat:2.16.0--pyhdfd78af_0
