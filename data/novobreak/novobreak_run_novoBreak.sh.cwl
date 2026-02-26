cwlVersion: v1.2
class: CommandLineTool
baseCommand: novobreak_run_novoBreak.sh
label: novobreak_run_novoBreak.sh
doc: "Runs the novoBreak pipeline.\n\nTool homepage: https://github.com/czc/nb_distribution"
inputs:
  - id: novo_break_exe_dir
    type: Directory
    doc: Directory containing the novoBreak executable.
    inputBinding:
      position: 1
  - id: ref
    type: File
    doc: Reference genome file.
    inputBinding:
      position: 2
  - id: tumor_bam
    type: File
    doc: Tumor BAM file.
    inputBinding:
      position: 3
  - id: normal_bam
    type: File
    doc: Normal BAM file.
    inputBinding:
      position: 4
  - id: n_cpus
    type: int
    doc: Number of CPUs to use.
    inputBinding:
      position: 5
  - id: outputdir
    type:
      - 'null'
      - Directory
    doc: Output directory. Defaults to the current working directory (PWD).
    default: PWD
    inputBinding:
      position: 6
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novobreak:1.1.3rc--h7132678_8
stdout: novobreak_run_novoBreak.sh.out
