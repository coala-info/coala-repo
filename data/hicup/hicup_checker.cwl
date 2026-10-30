cwlVersion: v1.2
class: CommandLineTool
baseCommand: [hicup_checker]
label: hicup_checker
doc: "Confirm that two different HiCUP summary results files correspond exactly (or\
  \ match approximately). The help text shows two positional files, but the script\
  \ source takes --expected and --new. It prints a pass message on stdout and exits\
  \ non-zero when the files differ more than the threshold.\n\nTool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/"
inputs:
  - id: expected_file
    type: File
    doc: "Expected HiCUP summary results file (HiCUP_summary_report_*.txt)"
    inputBinding:
      position: 1
      prefix: --expected
  - id: new_file
    type: File
    doc: "New HiCUP summary results file to compare with the expected one"
    inputBinding:
      position: 2
      prefix: --new
  - id: threshold
    type: ['null', int]
    doc: "Maximum percentage by which results may differ [default: 0]"
    inputBinding:
      position: 3
      prefix: --threshold
outputs:
  - id: check_result
    type: stdout
    doc: "Check result message"
stdout: hicup_checker.out.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
