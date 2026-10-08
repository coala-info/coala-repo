cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - RADpainter
  - paint
label: fineradstructure_paint
doc: "Generate a co-ancestry matrix from RAD data. The input is a tab-separated
  haplotype file: one header line of sample names, then one line per RAD locus with
  one genotype per sample (alleles separated by /, missing data left empty).\n\nTool
  homepage: https://github.com/millanek/fineRADstructure"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
  - class: InlineJavascriptRequirement
inputs:
  - id: input_file
    type: File
    doc: Input RAD haplotype file (INPUT.txt)
    inputBinding:
      position: 2
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Ploidy of the species being analysed (default is 2N, i.e. diploid)
    inputBinding:
      position: 1
      prefix: -p
  - id: chr
    type:
      - 'null'
      - boolean
    doc: Output per-chromosome coancestry matrices
    inputBinding:
      position: 1
      prefix: -c
  - id: run_name
    type:
      - 'null'
      - string
    doc: Run name to include in the output file name(s)
    inputBinding:
      position: 1
      prefix: -n
  - id: missing2
    type:
      - 'null'
      - boolean
    doc: "(deprecated) output a conancestry matrix with missing data treated as if
      any pair of individuals are equally distant"
    inputBinding:
      position: 1
      prefix: -m
outputs:
  - id: chunks_files
    type:
      type: array
      items: File
    doc: Co-ancestry matrix files written next to the input (INPUT_chunks.out and
      related files)
    outputBinding:
      glob: $(inputs.input_file.basename.replace(/\.[^.]*$/, ""))*chunks*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fineradstructure:0.3.2r109--h76b9af2_7
