cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- index
label: samtools_index
doc: Generate an index for BAM/CRAM files
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: $(inputs.input_file.basename)
    entry: $(inputs.input_file)
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type: File
  doc: Input BAM file to be indexed
  inputBinding:
    position: 1
    valueFrom: $(self.basename)
- id: output_index_name
  type: string?
  doc: Optional output index file name
  inputBinding:
    position: 2
- id: bai
  type: boolean?
  doc: Generate BAI-format index for BAM files [default]
  inputBinding:
    position: 103
    prefix: --bai
- id: csi
  type: boolean?
  doc: Generate CSI-format index for BAM files
  inputBinding:
    position: 103
    prefix: --csi
- id: min_shift
  type: int?
  doc: Set minimum interval size for CSI indices to 2^INT
  inputBinding:
    position: 103
    prefix: --min-shift
- id: threads
  type: int?
  doc: Sets the number of additional threads
  inputBinding:
    position: 103
    prefix: --threads
outputs:
- id: index_file
  type: File
  doc: The generated index file
  outputBinding:
    glob: |
      ${
        if (inputs.output_index_name) {
          return inputs.output_index_name;
        }
        return inputs.input_file.basename + (inputs.csi ? '.csi' : '.bai');
      }
$namespaces:
  s: https://schema.org/
s:url: https://github.com/samtools/samtools
