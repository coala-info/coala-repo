cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigToWig.pl
label: perl-bio-bigfile_bigWigToWig.pl
doc: "Dump the contents of a bigWig file as a tab-separated table (sequence ID, start, end, score), without track lines.\n\nTool homepage: https://metacpan.org/pod/Bio::DB::BigFile"
inputs:
  - id: input_bigwig
    type: File
    doc: Path to the input bigWig file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the dumped intervals
stdout: $(inputs.input_bigwig.nameroot).wig.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-bigfile:1.07--pl5321h41f7678_7
