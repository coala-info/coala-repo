cwlVersion: v1.2
class: CommandLineTool
baseCommand: blat2gff
label: gff2aplot_blat2gff
doc: "Convert BLAT PSL output files into GFF records for gff2aplot (reads the PSL file from standard input).\n\nTool homepage: http://genome.imim.es/software/gfftools/GFF2APLOT.html"
inputs:
  - id: psl_file
    type: File
    doc: "BLAT output file in PSL format (read from standard input)"
outputs:
  - id: gff_stdout
    type: stdout
    doc: "GFF records on standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gff2aplot:v2.0-11-deb_cv1
stdout: gff2aplot_blat2gff.gff
stdin: $(inputs.psl_file.path)
