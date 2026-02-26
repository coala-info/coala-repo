cwlVersion: v1.2
class: CommandLineTool
baseCommand: irida-sistr-results
label: irida-sistr-results
doc: "Compile SISTR results from an IRIDA instance into a table.\n\nTool homepage:
  http://github.com/phac-nml/irida-sistr-results"
inputs:
  - id: all_projects
    type:
      - 'null'
      - boolean
    doc: Explicitly load results from all projects the user has access to.  Will
      ignore the values given in --project.
    inputBinding:
      position: 101
      prefix: --all-projects
  - id: client_id
    type:
      - 'null'
      - string
    doc: The client id for an IRIDA instance.
    inputBinding:
      position: 101
      prefix: --client-id
  - id: client_secret
    type:
      - 'null'
      - string
    doc: The client secret for the IRIDA instance.
    inputBinding:
      position: 101
      prefix: --client-secret
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file for IRIDA (overrides values in 
      ['/usr/local/lib/python3.6/site-packages/irida_sistr_results/etc/config.ini',
      '/root/.local/share/irida-sistr-results/config.ini'])
    inputBinding:
      position: 101
      prefix: --config
  - id: exclude_reportable_status
    type:
      - 'null'
      - boolean
    doc: Excludes printing of reportable serovar status in final output.
    inputBinding:
      position: 101
      prefix: --exclude-reportable-status
  - id: exclude_user_existing_results
    type:
      - 'null'
      - boolean
    doc: If including user results, do not replace existing SISTR analysis that 
      were automatically generated with user-run SISTR results.
    inputBinding:
      position: 101
      prefix: --exclude-user-existing-results
  - id: include_user_results
    type:
      - 'null'
      - boolean
    doc: Include SISTR analysis results run directly by the user.
    inputBinding:
      position: 101
      prefix: --include-user-results
  - id: irida_url
    type:
      - 'null'
      - string
    doc: The URL to the IRIDA instance.
    inputBinding:
      position: 101
      prefix: --irida-url
  - id: password
    type:
      - 'null'
      - string
    doc: The password for the IRIDA instance. Prompts for password if left 
      blank.
    inputBinding:
      position: 101
      prefix: --password
  - id: projects
    type:
      - 'null'
      - type: array
        items: string
    doc: Projects to scan for SISTR results. If left blank will scan all 
      projects the user has access to.
    inputBinding:
      position: 101
      prefix: --project
  - id: reportable_serovars_file
    type:
      - 'null'
      - File
    doc: The reportable serovars file
    default: 
      /usr/local/lib/python3.6/site-packages/irida_sistr_results/data/reportable_serovars.tsv
    inputBinding:
      position: 101
      prefix: --reportable-serovars-file
  - id: samples_created_since
    type:
      - 'null'
      - string
    doc: Only include samples created more recently than this date (in format 
      YYYY-MM-DD) or this many days ago (as a number) [Include all samples]
    inputBinding:
      position: 101
      prefix: --samples-created-since
  - id: timeout
    type:
      - 'null'
      - int
    doc: Connection timeout when getting results from IRIDA.
    inputBinding:
      position: 101
      prefix: --connection-timeout
  - id: username
    type:
      - 'null'
      - string
    doc: The username for the IRIDA instance.
    inputBinding:
      position: 101
      prefix: --username
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose logging.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: workflow
    type:
      - 'null'
      - type: array
        items: string
    doc: Only include results of these workflow versions (or uuids) ['0.1', 
      '0.2', '0.3'] [all versions]
    inputBinding:
      position: 101
      prefix: --workflow
outputs:
  - id: output_tab
    type:
      - 'null'
      - File
    doc: Print results to tab-deliminited file.
    outputBinding:
      glob: $(inputs.output_tab)
  - id: output_excel
    type:
      - 'null'
      - File
    doc: Print results to the given excel file.
    outputBinding:
      glob: $(inputs.output_excel)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irida-sistr-results:0.6.0--py36_0
