cwlVersion: v1.2
class: CommandLineTool
label: samtools_samples
doc: "List samples from BAM/CRAM files, optionally checking for indices and associating
  with reference fasta files.\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.reference_fasta)
  - entry: $(inputs.reference_list_file)
- class: InlineJavascriptRequirement
baseCommand:
- samtools
- samples
inputs:
- id: input
  type: File[]
  doc: Input BAM/CRAM files
  inputBinding:
    position: 1
- id: custom_index
  type: boolean?
  doc: use a custom index file.
  inputBinding:
    position: 102
    prefix: -X
- id: header
  type: boolean?
  doc: add the columns header before printing the results
  inputBinding:
    position: 102
    prefix: -h
- id: reference_fasta
  type: File[]?
  doc: load an indexed fasta file in the collection of references. Can be used 
    multiple times.
  inputBinding:
    position: 102
    prefix: -f
    valueFrom: |
      ${
        if (self) {
          return self.map(function(e) { return e.basename; });
        }
        return self;
      }
- id: reference_list_file
  type: File?
  doc: read a file containing the paths to indexed fasta files. One path per 
    line.
  inputBinding:
    position: 102
    prefix: -F
    valueFrom: $(self.basename)
- id: sample_tag
  type: string?
  doc: provide the sample tag name from the @RG line [SM].
  default: SM
  inputBinding:
    position: 102
    prefix: -T
- id: test_indexed
  type: boolean?
  doc: test if the file is indexed.
  inputBinding:
    position: 102
    prefix: -i
outputs:
- id: output_file
  type: stdout
  doc: output file [stdout].
stdout: samples.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
