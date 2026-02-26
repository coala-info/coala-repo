cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy_mss-ga
label: hyphy_mss-ga
doc: "Genetic Algorithms for Recombination Detection. Implements a heuristic approach
  to screening alignments of sequences for recombination, by using the CHC genetic
  algorithm to search for phylogenetic incongruence among different partitions of
  the data. The number of partitions is determined using a step-down procedure, while
  the placement of breakpoints is searched for with the GA. The best fitting model
  (based on c-AIC) is returned; and additional post-hoc tests run to distinguish topological
  incongruence from rate-variation. v0.2 adds and spooling results to JSON after each
  breakpoint search conclusion\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: List of files to include in this analysis
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
stdout: hyphy_mss-ga.out
