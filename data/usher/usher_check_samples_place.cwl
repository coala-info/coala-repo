cwlVersion: v1.2
class: CommandLineTool
baseCommand: check_samples_place
label: usher_check_samples_place
doc: 'check_samples_place: checks that all samples of an original tree, with the genotypes
  of a VCF, are placed with the same mutations in a new mutation-annotated tree.


  Tool homepage: https://github.com/yatisht/usher'
inputs:
- id: original_tree
  type: File
  doc: Original mutation-annotated tree (.pb).
  inputBinding:
    position: 1
- id: samples_vcf
  type: File
  doc: VCF file with the sample genotypes.
  inputBinding:
    position: 2
- id: new_tree
  type: File
  doc: New mutation-annotated tree (.pb) to check.
  inputBinding:
    position: 3
- id: ignore_missing
  type:
  - 'null'
  - boolean
  doc: Ignore samples that are missing in the new tree (a fourth argument is added).
  inputBinding:
    position: 4
    valueFrom: '${ return self ? ''ignore_missing'' : null; }'
outputs:
- id: problems
  type: stderr
  doc: 'Standard error: reported problems (empty when all samples match).'
- id: report
  type: stdout
  doc: Standard output.
stdout: check_samples_place_stdout.txt
stderr: check_samples_place_stderr.txt
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/usher:0.6.6--hdd55de9_4
