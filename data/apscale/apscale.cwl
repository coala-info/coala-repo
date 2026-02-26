cwlVersion: v1.2
class: CommandLineTool
baseCommand: apscale
label: apscale
doc: "Advanced Pipeline for Simple yet Comprehensive AnaLysEs of DNA metabarcoding
  data, see https://github.com/DominikBuchner/apscale for detailed help.\n\nTool homepage:
  https://github.com/DominikBuchner/apscale"
inputs:
  - id: analyze
    type:
      - 'null'
      - Directory
    doc: Run the analysis module. Providing a PATH is optional. If no path is 
      provided apscale will run in the current working directory.
    inputBinding:
      position: 101
      prefix: --analyze
  - id: create_project
    type:
      - 'null'
      - string
    doc: Creates a new apscale project with the name provided
    inputBinding:
      position: 101
      prefix: --create_project
  - id: denoising
    type:
      - 'null'
      - Directory
    doc: Run the denoising module. Providing a PATH is optional. If no path is 
      provided apscale will run in the current working directory.
    inputBinding:
      position: 101
      prefix: --denoising
  - id: dereplication
    type:
      - 'null'
      - Directory
    doc: Run the dereplication_pooling module. Providing a PATH is optional. If 
      no path is provided apscale will run in the current working directory.
    inputBinding:
      position: 101
      prefix: --dereplication
  - id: generate_read_table
    type:
      - 'null'
      - Directory
    doc: Run the read table generation module. Providing a PATH is optional. If 
      no path is provided apscale will run in the current working directory.
    inputBinding:
      position: 101
      prefix: --generate_read_table
  - id: nc_removal
    type:
      - 'null'
      - Directory
    doc: Run the negative control removal module. Providing a PATH is optional. 
      If no path is provided apscale will run in the current working directory.
    inputBinding:
      position: 101
      prefix: --nc_removal
  - id: pe_merging
    type:
      - 'null'
      - Directory
    doc: Run the pe_merging module. Providing a PATH is optional. If no path is 
      provided apscale will run in the current working directory.
    inputBinding:
      position: 101
      prefix: --pe_merging
  - id: primer_trimming
    type:
      - 'null'
      - Directory
    doc: Run the primer_trimimng module. Providing a PATH is optional. If no 
      path is provided apscale will run in the current working directory.
    inputBinding:
      position: 101
      prefix: --primer_trimming
  - id: quality_filtering
    type:
      - 'null'
      - Directory
    doc: Run the quality_filtering module. Providing a PATH is optional. If no 
      path is provided apscale will run in the current working directory.
    inputBinding:
      position: 101
      prefix: --quality_filtering
  - id: replicate_merging
    type:
      - 'null'
      - Directory
    doc: Run the replicate merging module. Providing a PATH is optional. If no 
      path is provided apscale will run in the current working directory.
    inputBinding:
      position: 101
      prefix: --replicate_merging
  - id: run_apscale
    type:
      - 'null'
      - Directory
    doc: Run the entire pipeline. Providing a PATH is optional. If no path is 
      provided apscale will run in the current working directory.
    inputBinding:
      position: 101
      prefix: --run_apscale
  - id: swarm_clustering
    type:
      - 'null'
      - Directory
    doc: Run the swarm clustering module. Providing a PATH is optional. If no 
      path is provided apscale will run in the current working directory.
    inputBinding:
      position: 101
      prefix: --swarm_clustering
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apscale:4.3.0--pyhdfd78af_0
stdout: apscale.out
