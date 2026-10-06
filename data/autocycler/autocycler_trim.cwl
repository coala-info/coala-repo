cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - autocycler
  - trim
label: autocycler_trim
doc: "trim contigs in a cluster\n\nTool homepage: https://github.com/rrwick/Autocycler"
inputs:
  - id: cluster_dir
    type: Directory
    doc: Autocycler cluster directory containing 1_untrimmed.gfa file
    inputBinding:
      position: 101
      prefix: --cluster_dir
  - id: mad
    type:
      - 'null'
      - float
    doc: Allowed variability in cluster length, measured in median absolute deviations,
      set to 0 to disable exclusion of length outliers
    inputBinding:
      position: 101
      prefix: --mad
  - id: max_unitigs
    type:
      - 'null'
      - int
    doc: Maximum unitigs used for overlap alignment, set to 0 to disable trimming
    inputBinding:
      position: 101
      prefix: --max_unitigs
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum alignment identity for trimming alignments
    inputBinding:
      position: 101
      prefix: --min_identity
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: cluster_dir_out
    type: Directory
    doc: Cluster directory with the new 2_trimmed.gfa and 2_trimmed.yaml
    outputBinding:
      glob: $(inputs.cluster_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.cluster_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0
stdout: autocycler_trim.out
