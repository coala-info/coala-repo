cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - MethylExtractBSPvalue.pl
label: methylextract_MethylExtractBSPvalue.pl
doc: "MethylExtractBSPvalue calculates the bisulfite error probability (p-value) of
  each cytosine methylation value in a MethylExtract output file, given the bisulfite
  conversion rate.\n\nTool homepage: http://bioinfo2.ugr.es/MethylExtract/"
inputs:
  - id: in_file
    type: File
    doc: input file (methylation output of MethylExtract)
    inputBinding:
      position: 101
      prefix: inFile=
      separate: false
  - id: bscr
    type: float
    doc: Bisulfite conversion rate
    inputBinding:
      position: 101
      prefix: BSCR=
      separate: false
  - id: out_file_name
    type: string
    default: output.prob
    doc: 'Output file [default: inFile.prob]'
    inputBinding:
      position: 101
      prefix: outFile=
      separate: false
  - id: error_interval
    type:
      - 'null'
      - float
    doc: 'Error interval allowed [default: 0.2]'
    inputBinding:
      position: 101
      prefix: errorInterval=
      separate: false
  - id: fdr
    type:
      - 'null'
      - float
    doc: 'False discovery rate allowed [default: NA]'
    inputBinding:
      position: 101
      prefix: FDR=
      separate: false
outputs:
  - id: out_file
    type: File
    doc: Methylation table with the bisulfite error probability column
    outputBinding:
      glob: $(inputs.out_file_name)
  - id: no_sig_file
    type:
      - 'null'
      - File
    doc: Rows that are not significant at the chosen FDR (written when FDR is set)
    outputBinding:
      glob: $(inputs.out_file_name).noSig
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylextract:1.9.1--0
