cwlVersion: v1.2
class: CommandLineTool
baseCommand: novasplice
label: novasplice
doc: "NovaSplice is a tool for identifying novel splice sites.\n\nTool homepage: https://github.com/aryakaul/novasplice"
inputs:
  - id: bed_file
    type: File
    doc: Full path to the reference exon boundary bed file being used
    inputBinding:
      position: 101
      prefix: --bed
  - id: chromosome_lengths_file
    type: File
    doc: Full path to the chromosome length file being used
    inputBinding:
      position: 101
      prefix: --chrlens
  - id: intermediate_files_folder
    type:
      - 'null'
      - Directory
    doc: Path to output folder that will hold intermediate files generated, not 
      specific to the provided vcf. Especially useful when running NovaSplice on
      a large number of VCFs that all come from the same reference and make use 
      of the same --bed option.
    inputBinding:
      position: 101
      prefix: --intermediate
  - id: library_name
    type:
      - 'null'
      - string
    doc: Name of the final file novasplice outputs with predictions
    inputBinding:
      position: 101
      prefix: --libraryname
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Path to the output folder to dump simdigree's output to. Default is 
      working directory under /novasplice_output
    default: /novasplice_output
    inputBinding:
      position: 101
      prefix: --output
  - id: percent_novel_splice_site
    type:
      - 'null'
      - float
    doc: Lower bound percent to call novel splice site
    inputBinding:
      position: 101
      prefix: --percent
  - id: reference_genome
    type:
      - 'null'
      - File
    doc: Full path to the reference genome being used
    inputBinding:
      position: 101
      prefix: --reference
  - id: temp_files_directory
    type:
      - 'null'
      - Directory
    doc: Full path to an alternative directory to use for temp files. Default is
      /tmp
    default: /tmp
    inputBinding:
      position: 101
      prefix: --temp
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: Full path to the sorted vcf file being used
    inputBinding:
      position: 101
      prefix: --vcf
  - id: zipped_reference_genome
    type:
      - 'null'
      - File
    doc: Full path to the zipped reference genome being used
    inputBinding:
      position: 101
      prefix: --zippedreference
  - id: zipped_vcf_file
    type:
      - 'null'
      - File
    doc: Full path to the sorted zipped vcf file being used
    inputBinding:
      position: 101
      prefix: --zippedvcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novasplice:0.0.4--py_0
stdout: novasplice.out
