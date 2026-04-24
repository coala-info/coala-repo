cwlVersion: v1.2
class: CommandLineTool
baseCommand: cath-resolve-hits
label: cath-tools_cath-resolve-hits
doc: "Collapse a list of domain matches to your query sequence(s) down to the non-overlapping
  subset (ie domain architecture) that maximises the sum of the hits' scores.\n\n\
  Tool homepage: https://github.com/UCLOrengoGroup/cath-tools"
inputs:
  - id: input_file
    type: File
    doc: Input file. Use '-' for standard input.
    inputBinding:
      position: 1
  - id: apply_cath_rules
    type:
      - 'null'
      - boolean
    doc: '[DEPRECATED] Apply rules specific to CATH-Gene3D during the parsing and
      processing'
    inputBinding:
      position: 102
      prefix: --apply-cath-rules
  - id: cath_rules_help
    type:
      - 'null'
      - boolean
    doc: Show help on the rules activated by the (DEPRECATED) --apply-cath-rules
      option
    inputBinding:
      position: 102
      prefix: --cath-rules-help
  - id: filter_query_id
    type:
      - 'null'
      - type: array
        items: string
    doc: Ignore all input data except that for query protein(s) <id> (may be 
      specified multiple times for multiple query proteins)
    inputBinding:
      position: 102
      prefix: --filter-query-id
  - id: high_scores_preference
    type:
      - 'null'
      - int
    doc: Prefer higher scores to degree <val> (<val> may be negative to reduce 
      preference for higher scores; 0 leaves scores unaffected)
    inputBinding:
      position: 102
      prefix: --high-scores-preference
  - id: html_exclude_rejected_hits
    type:
      - 'null'
      - boolean
    doc: Exclude hits rejected by the score filters from the HTML
    inputBinding:
      position: 102
      prefix: --html-exclude-rejected-hits
  - id: html_max_num_non_soln_hits
    type:
      - 'null'
      - int
    doc: Only display up to <num> non-solution hits in the HTML
    inputBinding:
      position: 102
      prefix: --html-max-num-non-soln-hits
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Parse the input data from <format>, one of available formats: hmmer_domtblout,
      hmmscan_out, hmmsearch_out, raw_with_scores, raw_with_evalues'
    inputBinding:
      position: 102
      prefix: --input-format
  - id: input_hits_are_grouped
    type:
      - 'null'
      - boolean
    doc: Rely on the input hits being grouped by query protein (so the run is 
      faster and uses less memory)
    inputBinding:
      position: 102
      prefix: --input-hits-are-grouped
  - id: limit_queries
    type:
      - 'null'
      - int
    doc: Only process the first <num> query protein(s) encountered in the input 
      data
    inputBinding:
      position: 102
      prefix: --limit-queries
  - id: long_domains_preference
    type:
      - 'null'
      - int
    doc: Prefer longer hits to degree <val> (<val> may be negative to prefer 
      shorter; 0 leaves scores unaffected)
    inputBinding:
      position: 102
      prefix: --long-domains-preference
  - id: min_gap_length
    type:
      - 'null'
      - int
    doc: When parsing starts/stops from alignment data, ignore gaps of less than
      <length> residues
    inputBinding:
      position: 102
      prefix: --min-gap-length
  - id: min_seg_length
    type:
      - 'null'
      - int
    doc: Ignore all segments that are fewer than <length> residues long
    inputBinding:
      position: 102
      prefix: --min-seg-length
  - id: naive_greedy
    type:
      - 'null'
      - boolean
    doc: Use a naive, greedy approach to resolving (not recommended except for 
      comparison)
    inputBinding:
      position: 102
      prefix: --naive-greedy
  - id: output_trimmed_hits
    type:
      - 'null'
      - boolean
    doc: When writing out the final hits, output the hits' starts/stop as they 
      are *after trimming*
    inputBinding:
      position: 102
      prefix: --output-trimmed-hits
  - id: overlap_trim_spec
    type:
      - 'null'
      - string
    doc: Allow different hits' segments to overlap a bit by trimming all 
      segments using spec <trim> of the form n/m (n is a segment length; m is 
      the *total* length to be trimmed off both ends)
    inputBinding:
      position: 102
      prefix: --overlap-trim-spec
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress the default output of resolved hits in plain text to stdout
    inputBinding:
      position: 102
      prefix: --quiet
  - id: raw_format_help
    type:
      - 'null'
      - boolean
    doc: Show help about the raw input formats (raw_with_scores and 
      raw_with_evalues)
    inputBinding:
      position: 102
      prefix: --raw-format-help
  - id: restrict_html_within_body
    type:
      - 'null'
      - boolean
    doc: Restrict HTML output to the contents of the body tag. The contents 
      should be included inside a body tag of class crh-body
    inputBinding:
      position: 102
      prefix: --restrict-html-within-body
  - id: worst_permissible_bitscore
    type:
      - 'null'
      - float
    doc: Ignore any hits with a bitscore worse than <bitscore>
    inputBinding:
      position: 102
      prefix: --worst-permissible-bitscore
  - id: worst_permissible_evalue
    type:
      - 'null'
      - float
    doc: Ignore any hits with an evalue worse than <evalue>
    inputBinding:
      position: 102
      prefix: --worst-permissible-evalue
  - id: worst_permissible_score
    type:
      - 'null'
      - float
    doc: Ignore any hits with a score worse than <score>
    inputBinding:
      position: 102
      prefix: --worst-permissible-score
outputs:
  - id: hits_text_to_file
    type:
      - 'null'
      - File
    doc: Write the resolved hits in plain text to file <file>
    outputBinding:
      glob: $(inputs.hits_text_to_file)
  - id: summarise_to_file
    type:
      - 'null'
      - File
    doc: Write a brief text summary of the input data to file <file> (or '-' for
      stdout)
    outputBinding:
      glob: $(inputs.summarise_to_file)
  - id: html_output_to_file
    type:
      - 'null'
      - File
    doc: Write the results as HTML to file <file> (or '-' for stdout)
    outputBinding:
      glob: $(inputs.html_output_to_file)
  - id: json_output_to_file
    type:
      - 'null'
      - File
    doc: Write the results as JSON to file <file> (or '-' for stdout)
    outputBinding:
      glob: $(inputs.json_output_to_file)
  - id: export_css_file
    type:
      - 'null'
      - File
    doc: Export the CSS used in the HTML output to <file> (or '-' for stdout)
    outputBinding:
      glob: $(inputs.export_css_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cath-tools:0.16.5--h78a066a_0
