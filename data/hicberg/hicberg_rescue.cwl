cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicberg
  - rescue
label: hicberg_rescue
doc: "Reallocate ambiguous reads to the most plausible position according to\n  model.\n\
  \nTool homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: genome
    type: File
    doc: Genome FASTA file.
    inputBinding:
      position: 1
  - id: output_folder
    type: Directory
    doc: Result folder created by hicberg create-folder (and filled by the earlier
      stages). It is staged writable; the stage adds its files to it.
    inputBinding:
      position: 100
      prefix: --output
      valueFrom: $(runtime.outdir)/$(inputs.output_folder.basename)
  - id: enzyme
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --enzyme
    doc: Enzymes to use for genome digestion (restriction enzyme names such as DpnII,
      or a number for Micro-C fragment size). Give one or more.
    inputBinding:
      position: 104
  - id: mode
    type:
      - 'null'
      - string
    doc: Statistical model to use for ambiguous reads assignment.
    inputBinding:
      position: 104
      prefix: --mode
  - id: cpus
    type:
      - 'null'
      - int
    doc: Threads to use for analysis.
    inputBinding:
      position: 104
      prefix: --cpus
outputs:
  - id: output_folder_out
    type: Directory
    doc: The same result folder with the files this stage wrote.
    outputBinding:
      glob: $(inputs.output_folder.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.output_folder)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
