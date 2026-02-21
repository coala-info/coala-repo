cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam
label: bamutil_bam
doc: "Set of tools for operating on SAM/BAM files, including rewriting, modifying,
  and informational utilities.\n\nTool homepage: http://genome.sph.umich.edu/wiki/BamUtil"
inputs:
  - id: tool
    type: string
    doc: 'The specific tool to execute. Available tools include: convert, writeRegion,
      splitChromosome, splitBam, findCigars, clipOverlap, filter, revert, squeeze,
      trimBam, mergeBam, polishBam, dedup, dedup_LowMem, recab, validate, diff, stats,
      gapInfo, dumpHeader, dumpRefInfo, dumpIndex, readReference, explainFlags, bam2FastQ,
      and readIndexedBam.'
    inputBinding:
      position: 1
  - id: tool_arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments specific to the selected tool.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
stdout: bamutil_bam.out
