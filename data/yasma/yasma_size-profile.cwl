cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yasma
  - size-profile
label: yasma_size-profile
doc: "Convenience function for calculating aligned size profile.\n\nTool homepage:
  https://github.com/NateyJay/YASMA"
inputs:
  - id: alignment_file
    type:
      - 'null'
      - string
    default: align/alignment.bam
    doc: Alignment file input (bam or cram). Give the path inside the project directory (output_directory); the depth table and index of the alignment must sit beside it.
    inputBinding:
      position: 101
      prefix: --alignment_file
      valueFrom: $(inputs.output_directory.basename)/$(self)
  - id: all
    type:
      - 'null'
      - boolean
    doc: "Override any annotation conditions and use\n                           \
      \       all libraries for size-profiling."
    inputBinding:
      position: 101
      prefix: --all
  - id: annotation_conditions
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --annotation_conditions
    doc: "List of conditions names which will be\n                               \
      \   included in the profile. Defaults to use all\n                         \
      \         libraries, though this is likely not what\n                      \
      \            you want if you have multiple groups."
    inputBinding:
      position: 101
  - id: conditions
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --conditions
    doc: "Values denoting condition groups (sets of\n                            \
      \      replicate libraries) for projects with\n                            \
      \      multiple tissues/treatments/genotypes. Can\n                        \
      \          be entered here as space sparated duplexes,\n                   \
      \               with the library base_name and condition\n                 \
      \                 groups delimited by a colon. E.g.\n                      \
      \            SRR1111111:WT SRR1111112:WT SRR1111113:mut\n                  \
      \                SRR1111114:mut"
    inputBinding:
      position: 101
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Flag to force override of output_file\n                                \
      \  (default does nothing when this file is\n                               \
      \   found)."
    inputBinding:
      position: 101
      prefix: --force
  - id: output_directory
    type: Directory
    doc: "Directory name for annotation output.\n                                \
      \  Defaults to the current directory, with this\n                          \
      \        directory name as the project name."
    inputBinding:
      position: 101
      prefix: --output_directory
      valueFrom: $(self.basename)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: project_directory
    type: Directory
    doc: Project directory with the files this step wrote
    outputBinding:
      glob: $(inputs.output_directory.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{entry: inputs.output_directory, writable: true}];
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
stdout: yasma_size-profile.out
