cwlVersion: v1.2
class: CommandLineTool
baseCommand: transrate
label: transrate
doc: "Analyse a de-novo transcriptome assembly using three kinds of metrics: sequence based (if --assembly is given), read mapping based (if --left and --right are given) and reference based (if --reference is given).\n\nTool homepage: http://hibberdlab.com/transrate"
inputs:
  - id: assembly
    type:
      - 'null'
      - type: array
        items: File
    doc: Assembly file(s) in FASTA format, comma-separated
    inputBinding:
      prefix: --assembly
      itemSeparator: ','
  - id: left
    type:
      - 'null'
      - type: array
        items: File
    doc: Left reads file(s) in FASTQ format, comma-separated
    inputBinding:
      prefix: --left
      itemSeparator: ','
  - id: right
    type:
      - 'null'
      - type: array
        items: File
    doc: Right reads file(s) in FASTQ format, comma-separated
    inputBinding:
      prefix: --right
      itemSeparator: ','
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference proteome or transcriptome file in FASTA format
    inputBinding:
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default: 8)"
    inputBinding:
      prefix: --threads
  - id: merge_assemblies
    type:
      - 'null'
      - string
    doc: Merge best contigs from multiple assemblies into file
    inputBinding:
      prefix: --merge-assemblies
  - id: output
    type:
      - 'null'
      - string
    default: transrate_results
    doc: "Directory where results are output (will be created) (default: transrate_results)"
    inputBinding:
      prefix: --output
  - id: loglevel
    type:
      - 'null'
      - string
    doc: "Log level. One of [error, info, warn, debug] (default: info)"
    inputBinding:
      prefix: --loglevel
  - id: install_deps
    type:
      - 'null'
      - string
    doc: "Install any missing dependencies. One of [read, ref, all]"
    inputBinding:
      prefix: --install-deps
outputs:
  - id: output_dir
    type: Directory
    doc: Results directory (assembly scores, contig scores, and files written for the merged assembly)
    outputBinding:
      glob: $(inputs.output)
  - id: merged_assembly
    type:
      - 'null'
      - File
    doc: Merged assembly written when merge_assemblies is set
    outputBinding:
      glob: $(inputs.merge_assemblies)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transrate:1.0.3--h516909a_0
