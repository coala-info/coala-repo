cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mimodd, snpeff-genomes]
label: mimodd_snpeff-genomes
doc: "List the SnpEff genomes installed for use with the annotate tool.\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: snpeff_path
    type:
      - 'null'
      - Directory
    doc: location of the SnpEff installation directory. Will override MiModD 
      config settings if provided.
    inputBinding:
      position: 101
      prefix: --config
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: 'redirect the output to the specified file (default: stdout)'
    inputBinding:
      position: 102
      prefix: --ofile
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file written when output_file_path is given
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
stdout: mimodd_snpeff-genomes.out
