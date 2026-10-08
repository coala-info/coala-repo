cwlVersion: v1.2
class: CommandLineTool
baseCommand: [fastreeR]
label: fastreer_VCF2EMB
doc: "Generate variant embeddings from a VCF file using the BioFM-265M genomic language model (needs biofm-eval, a reference FASTA and a GFF3 annotation)\n\nTool homepage: https://github.com/gkanogiannis/fastreeR"
arguments:
  - position: 1
    valueFrom: VCF2EMB
inputs:
  - id: mem
    type: ['null', int]
    doc: Max RAM for JVM in MB (default 256)
    inputBinding:
      position: 0
      prefix: --mem
  - id: lib
    type: ['null', string]
    doc: Path to JAR library folder inside the container
    inputBinding:
      position: 0
      prefix: --lib
  - id: pipe_stderr
    type: ['null', boolean]
    doc: Pipe Java stderr to CLI
    inputBinding:
      position: 0
      prefix: --pipe-stderr
  - id: extra_verbose
    type: ['null', boolean]
    doc: Print extra messages on stderr
    inputBinding:
      position: 0
      prefix: --extraVerbose
  - id: input_file
    type: ['null', File]
    doc: Input VCF file (positional)
    inputBinding:
      position: 10
  - id: named_input
    type: ['null', File]
    doc: Input VCF file (overrides positional)
    inputBinding:
      position: 9
      prefix: -i
  - id: output
    type: string
    doc: "Output embeddings file "
    inputBinding:
      position: 11
      prefix: -o
  - id: reference
    type: ['null', File]
    doc: "Path to reference genome FASTA file"
    inputBinding:
      position: 11
      prefix: -r
  - id: annotation
    type: ['null', File]
    doc: "Path to gene annotation GFF3 file"
    inputBinding:
      position: 11
      prefix: -a
  - id: model
    type: ['null', string]
    doc: "HuggingFace model name or local path (default m42-health/BioFM-265M)"
    inputBinding:
      position: 11
      prefix: -m
  - id: format
    type: ['null', string]
    doc: "Output format: TSV or HUGGINGFACE (default TSV)"
    inputBinding:
      position: 11
      prefix: -f
  - id: variant_key
    type: ['null', string]
    doc: "Variant key format in output: CHROM_POS, CHROM_POS_REF_ALT or VCF_ID"
    inputBinding:
      position: 11
      prefix: --variant-key
  - id: max_variants
    type: ['null', int]
    doc: "Maximum number of variants to process (default all)"
    inputBinding:
      position: 11
      prefix: --max-variants
  - id: device
    type: ['null', string]
    doc: "Device for model inference: cuda or cpu (default auto-detect)"
    inputBinding:
      position: 11
      prefix: --device
  - id: verbose
    type: ['null', boolean]
    doc: "Print progress messages on stderr"
    inputBinding:
      position: 11
      prefix: -v
outputs:
  - id: output_file
    type: ['null', File]
    doc: Output file written with -o
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastreer:2.1.3--pyhdfd78af_0
