cwlVersion: v1.2
class: CommandLineTool
baseCommand: haysac_config
label: haystac_config
doc: "Configuration options\n\nTool homepage: https://github.com/antonisdim/haystac"
inputs:
  - id: api_key
    type:
      - 'null'
      - string
    doc: Personal NCBI API key (increases max concurrent requests from 3 to 10, 
      https://www.ncbi.nlm.nih.gov/account/register/)
    inputBinding:
      position: 101
      prefix: --api-key
  - id: cache
    type:
      - 'null'
      - Directory
    doc: Cache folder for storing genomes downloaded from NCBI and other shared 
      data
    default: /root/haystac/cache
    inputBinding:
      position: 101
      prefix: --cache
  - id: clear_cache
    type:
      - 'null'
      - boolean
    doc: Clear the contents of the cache folder, and delete the folder itself
    default: false
    inputBinding:
      position: 101
      prefix: --clear-cache
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda as a package manger
    default: true
    inputBinding:
      position: 101
      prefix: --use-conda
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystac:0.4.12--pyhcf36b3e_0
stdout: haystac_config.out
