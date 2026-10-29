cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - anno
  - trf
label: truvari_anno_trf
doc: "Intersect vcf with reference tandem repeats and annotate variants with the best fitting repeat motif and its copy number relative to the reference\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: input
    type: File
    secondaryFiles: &id001
      - .tbi
    doc: VCF to annotate
    inputBinding:
      position: 1
      prefix: "-i"
  - id: output
    type:
      - 'null'
      - string
    default: trf.vcf
    doc: Output filename (stdout)
    inputBinding:
      position: 1
      prefix: "-o"
  - id: executable
    type:
      - 'null'
      - File
    doc: Path to tandem repeat finder (trf409.linux64); give the executable as a file when it is not on PATH in the image
    inputBinding:
      position: 1
      prefix: "-e"
  - id: trf_params
    type:
      - 'null'
      - string
    doc: Default parameters to send to trf (3 7 7 80 5 40 500 -h -ngs)
    inputBinding:
      position: 1
      prefix: "-T="
      separate: false
  - id: repeats
    type: File
    secondaryFiles: *id001
    doc: Reference repeat annotations
    inputBinding:
      position: 1
      prefix: "-r"
  - id: buffer
    type:
      - 'null'
      - int
    doc: buffer on annotations during intersection (5)
    inputBinding:
      position: 1
      prefix: "--buffer"
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: Reference fasta file
    inputBinding:
      position: 1
      prefix: "-f"
  - id: motif_similarity
    type:
      - 'null'
      - float
    doc: Motif similarity threshold (0.9)
    inputBinding:
      position: 1
      prefix: "-s"
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum size of entry to annotate (50)
    inputBinding:
      position: 1
      prefix: "-m"
  - id: regions_only
    type:
      - 'null'
      - boolean
    doc: Only write variants within --repeats regions (False)
    inputBinding:
      position: 1
      prefix: "-R"
  - id: no_estimate
    type:
      - 'null'
      - boolean
    doc: Skip INS estimation procedure and run everything through TRF. (False)
    inputBinding:
      position: 1
      prefix: "--no-estimate"
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Size (in mbs) of reference chunks for parallelization (5)
    inputBinding:
      position: 1
      prefix: "-C"
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (1)
    inputBinding:
      position: 1
      prefix: "-t"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 1
      prefix: "--debug"
outputs:
  - id: output_vcf
    type: File
    doc: Annotated VCF
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
