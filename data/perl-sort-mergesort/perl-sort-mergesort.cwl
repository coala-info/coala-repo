cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sort-mergesort
label: perl-sort-mergesort
doc: "A Perl-based implementation of the merge sort algorithm. (Note: The provided
  text contains system error messages regarding disk space and container extraction
  rather than the tool's help documentation; therefore, no arguments could be extracted.)\n\
  \nTool homepage: http://metacpan.org/pod/Sort::MergeSort"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sort-mergesort:0.31--pl5321hdfd78af_2
stdout: perl-sort-mergesort.out
