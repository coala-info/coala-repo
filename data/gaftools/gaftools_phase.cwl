cwlVersion: v1.2
class: CommandLineTool
baseCommand: gaftools_phase
label: gaftools_phase
doc: "Add phasing information to the GAF file from a haplotag TSV file.\n\nThe script
  uses the TSV file containing the haplotag information generated from WhatsHap's
  haplotag command.\nThe H1 and H2 labels for each read are then added to the reads
  in the GAF file.\n\nTool homepage: https://github.com/marschall-lab/gaftools"
inputs:
  - id: gaf_file
    type: File
    doc: GAF file (can be bgzip-compressed)
    inputBinding:
      position: 1
  - id: tsv_file
    type: File
    doc: WhatsHap haplotag TSV file. Refer to 
      https://whatshap.readthedocs.io/en/latest/guide.html#whatshap-haplotag
    inputBinding:
      position: 2
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output GAF file (bgzipped if the file ends with .gz). If omitted, 
      output is directed to stdout.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gaftools:1.3.1--pyhdfd78af_0
