cwlVersion: v1.2
class: CommandLineTool
baseCommand: pal_finder
label: pal_finder
doc: "A tool for finding microsatellite repeats and designing primers from NGS data.
  The tool requires a configuration file containing necessary parameters. The config
  file names the read files, the primer3 mispriming library and the output files with
  relative paths. Give those files in support_files so they are staged beside the config.
  Name the output files so that they contain 'summary' (for example
  test_microsat_summary.txt and test_PAL_summary.txt).\n\nTool homepage: http://sourceforge.net/projects/palfinder/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.support_files || [])
inputs:
  - id: config_file
    type: File
    doc: Path to the configuration file (e.g., pal_finder.cfg) containing run parameters
      such as 'findPrimers'.
    inputBinding:
      position: 1
  - id: support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the config file with relative paths (read files, primer3 mispriming
      library such as simple.ref). Staged in the working directory.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: summary_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Result files written by pal_finder (microsatellite and primer summaries).
    outputBinding:
      glob: '*summary*'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pal_finder:0.02.04--2
stdout: pal_finder.out
