cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktGetContigMagnitudes
label: krona_ktGetContigMagnitudes
doc: 'Takes an ACE assembly file and writes a magnitude file for use with import scripts.
  The magnitude of each contig will be the total number of reads assigned to it.


  Tool homepage: https://github.com/marbl/Krona'
inputs:
  - id: assembly_ace
    type: File
    doc: ACE assembly file.
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    default: magnitudes.txt
    doc: Output magnitude file name.
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name.
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
