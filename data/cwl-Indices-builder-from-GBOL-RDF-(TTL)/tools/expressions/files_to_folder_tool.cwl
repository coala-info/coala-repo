cwlVersion: v1.2

class: CommandLineTool

doc: |
  Transforms the input files to a mentioned directory

requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}

  InitialWorkDirRequirement:
    listing:
        - entryname: mv.sh
          entry: |-
            shift;
            mkdir $(inputs.destination); 
            # Move each file individually, ignoring non-existing files
            for file in $@; do
              if [ -e "$file" ]; then
                mv -n "$file" "$(inputs.destination)"
              fi
            ls $(inputs.destination)
            done
inputs:
  files:
    type: File[]?
    inputBinding:
      position: 2
  folders:
    type: Directory[]?
    inputBinding:
      position: 3
  destination:
    type: string
    inputBinding:
      position: 1

baseCommand: [bash, -x, mv.sh]

outputs:
  results:
    type: Directory
    outputBinding:
      glob: $(inputs.destination)


$namespaces:
 s: http://schema.org/

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateModified: 2024-10-07
s:dateCreated: "2020-00-00"
s:license: https://spdx.org/licenses/Apache-2.0 
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"