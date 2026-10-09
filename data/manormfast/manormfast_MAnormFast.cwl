cwlVersion: v1.2
class: CommandLineTool
baseCommand: MAnormFast
label: manormfast_MAnormFast
doc: 'MAnormFast: quantitative comparison of ChIP-seq peak sets (fast MAnorm).


  Tool homepage: https://github.com/semal/MAnormFast'
inputs:
  - id: peaks1
    type: File
    doc: 'Peaks file of sample 1 (numerator): at least chromosome, start and end;
      an optional fourth column is the summit position relative to the peak start'
    inputBinding:
      position: 1
      prefix: --p1
  - id: peaks2
    type: File
    doc: Peaks file of sample 2 (denominator)
    inputBinding:
      position: 1
      prefix: --p2
  - id: reads1
    type: File
    doc: Reads file of sample 1 in BED format (columns 1, 2, 3 and 6 are chromosome,
      start, end and strand)
    inputBinding:
      position: 1
      prefix: --r1
  - id: reads2
    type: File
    doc: Reads file of sample 2 in BED format
    inputBinding:
      position: 1
      prefix: --r2
  - id: output_folder
    type: string
    doc: Name of this comparison, also used as the name of the folder created to store
      the results
    inputBinding:
      position: 1
      prefix: -o
  - id: shift_size1
    type:
      - 'null'
      - int
    doc: Read shift size of sample 1; set to the average DNA fragment size (default=100)
    inputBinding:
      position: 1
      prefix: --s1
  - id: shift_size2
    type:
      - 'null'
      - int
    doc: Read shift size of sample 2 (default=100)
    inputBinding:
      position: 1
      prefix: --s2
  - id: random_time
    type:
      - 'null'
      - int
    doc: Number of random permutations to test the enrichment of overlapping between
      two peak sets (default=5)
    inputBinding:
      position: 1
      prefix: -n
  - id: extension
    type:
      - 'null'
      - int
    doc: 2*extension is the size of the window centered at the peak summit to calculate
      the read density (default=1000)
    inputBinding:
      position: 1
      prefix: -e
  - id: summit_distance
    type:
      - 'null'
      - int
    doc: Summit to summit distance cutoff (default=extension/2)
    inputBinding:
      position: 1
      prefix: -d
  - id: output_no_merge
    type:
      - 'null'
      - boolean
    doc: Do not merge the common peaks; peaks in the output files are exactly those
      of the input
    inputBinding:
      position: 1
      prefix: -s
  - id: overlap_dependent
    type:
      - 'null'
      - boolean
    doc: Choose biased peaks only from unique peaks and unbiased peaks only from common
      peaks
    inputBinding:
      position: 1
      prefix: -v
  - id: biased_p
    type:
      - 'null'
      - float
    doc: P-value cutoff to define biased peaks (default=0.01)
    inputBinding:
      position: 1
      prefix: -p
  - id: biased_m
    type:
      - 'null'
      - float
    doc: M-value cutoff to define biased peaks (default=1)
    inputBinding:
      position: 1
      prefix: -m
  - id: unbiased_m
    type:
      - 'null'
      - float
    doc: M-value cutoff to define unbiased peaks (default=1)
    inputBinding:
      position: 1
      prefix: -u
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Result folder
    outputBinding:
      glob: $(inputs.output_folder)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/manormfast:0.1.2--py36_1
stdout: manormfast_MAnormFast.out
