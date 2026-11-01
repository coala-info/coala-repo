cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- IndexFeatureFile
label: gatk_IndexFeatureFile
doc: |-
  Creates an index for a feature file, e.g. VCF or BED file.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type: File
  doc: Feature file (eg., VCF or BED file) to index. Must be in a tribble-supported
    format
  inputBinding:
    prefix: --input
- id: output
  type:
  - 'null'
  - string
  doc: The output index file. If missing, the tool will create an index file in the
    same directory as the input file.
  inputBinding:
    prefix: --output
outputs:
- id: index
  type: File
  doc: Index file (.idx for plain VCF/BED, .tbi for bgzipped files) written next to
    the staged input, or the file named by output
  outputBinding:
    glob: ${ if (inputs.output) { return inputs.output; } return [inputs.input.basename
      + '.tbi', inputs.input.basename + '.idx', inputs.input.basename + '.csi']; }
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.input)
    writable: true
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
