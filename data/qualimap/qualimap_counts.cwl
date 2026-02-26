cwlVersion: v1.2
class: CommandLineTool
baseCommand: qualimap counts
label: qualimap_counts
doc: "QualiMap v.2.3\n\nTool homepage: http://qualimap.bioinfo.cipf.es/"
inputs:
  - id: compare
    type:
      - 'null'
      - boolean
    doc: Perform comparison of conditions. Currently 2 maximum is possible.
    inputBinding:
      position: 101
      prefix: --compare
  - id: data
    type: File
    doc: "File describing the input data. Format of the file is a 4-column tab-delimited
      table.\n                          Column 1: sample name\n                  \
      \        Column 2: condition of the sample\n                          Column
      3: path to the counts data for the sample\n                          Column
      4: index of the column with counts"
    inputBinding:
      position: 101
      prefix: --data
  - id: info
    type:
      - 'null'
      - File
    doc: Path to info file containing genes GC-content, length and type.
    inputBinding:
      position: 101
      prefix: --info
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output folder for HTML report and raw data.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: outformat
    type:
      - 'null'
      - string
    doc: Format of the output report (PDF, HTML or both PDF:HTML, default is 
      HTML).
    default: HTML
    inputBinding:
      position: 101
      prefix: --outformat
  - id: rscriptpath
    type:
      - 'null'
      - string
    doc: Path to Rscript executable (by default it is assumed to be available 
      from system $PATH)
    inputBinding:
      position: 101
      prefix: --rscriptpath
  - id: species
    type:
      - 'null'
      - string
    doc: 'Use built-in info file for the given species: HUMAN or MOUSE.'
    inputBinding:
      position: 101
      prefix: --species
  - id: threshold
    type:
      - 'null'
      - int
    doc: Threshold for the number of counts
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file for PDF report (default value is report.pdf).
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qualimap:2.3--hdfd78af_0
