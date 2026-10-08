cwlVersion: v1.2
class: CommandLineTool
baseCommand: Genepop
label: genepop
doc: "Genepop: population genetics software for exact tests, allele frequencies,
  F-statistics, isolation by distance and file conversion. In batch mode the program
  reads a Genepop input file, runs the analyses named in MenuOptions (for example
  1.1 for Hardy-Weinberg exact tests, 5.1 for allele frequencies and Fis) and writes
  result files beside the input file (for example sample.txt.D).\n\nTool homepage:
  https://kimura.univ-montp2.fr/~rousset/Genepop.htm"
inputs:
  - id: input_file
    type: File
    doc: Genepop input file (title line, locus names, Pop lines and genotypes).
    inputBinding:
      position: 1
      prefix: GenepopInputFile=
      separate: false
      valueFrom: $(self.basename)
  - id: menu_options
    type: string
    doc: Menu option(s) to run, as in the Genepop menu, for example 1.1 or 5.1.
    inputBinding:
      position: 2
      prefix: MenuOptions=
      separate: false
  - id: mode
    type:
      - 'null'
      - string
    doc: Run mode. Batch (default here) runs without the interactive menu.
    default: Batch
    inputBinding:
      position: 3
      prefix: Mode=
      separate: false
  - id: settings_file
    type:
      - 'null'
      - File
    doc: Settings file with key=value lines (for example Dememorisation, BatchNumber,
      BatchLength, HWtests).
    inputBinding:
      position: 4
      prefix: settingsFile=
      separate: false
  - id: ci_coverage
    type:
      - 'null'
      - float
    doc: Coverage of confidence intervals.
    inputBinding:
      position: 5
      prefix: CIcoverage=
      separate: false
outputs:
  - id: results
    type:
      type: array
      items: File
    doc: Result files written beside the input file (input name plus a suffix such
      as .D, .INF, .P, .GE, .ST2).
    outputBinding:
      glob: $(inputs.input_file.basename).*
  - id: cmdline
    type:
      - 'null'
      - File
    doc: Settings file the program writes from the command line arguments.
    outputBinding:
      glob: cmdline.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genepop:4.8.4--h9948957_0
