cwlVersion: v1.2
class: CommandLineTool
baseCommand: exiftool
label: perl-image-exiftool_exiftool
doc: "Read and write meta information in files\n\nTool homepage: https://metacpan.org/pod/Image::ExifTool"
inputs:
  - id: input_file
    type:
      type: array
      items: File
    doc: One or more files to process
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-image-exiftool:13.44--pl5321hdfd78af_0
stdout: perl-image-exiftool_exiftool.out
