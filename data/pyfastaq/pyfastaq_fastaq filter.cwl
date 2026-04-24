cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastaq_fastaq filter
label: pyfastaq_fastaq filter
doc: "Filter FASTA/FASTQ files based on various criteria.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA or FASTQ file.
    inputBinding:
      position: 1
  - id: discard_ambiguous
    type:
      - 'null'
      - boolean
    doc: Discard sequences with ambiguous bases (e.g., 'N').
    inputBinding:
      position: 102
      prefix: --discard-ambiguous
  - id: discard_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Discard sequences with IDs in this comma-separated list.
    inputBinding:
      position: 102
      prefix: --discard-ids
  - id: discard_qual_above
    type:
      - 'null'
      - int
    doc: Discard sequences where at least one quality score is above this 
      threshold (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-above
  - id: discard_qual_above_count
    type:
      - 'null'
      - int
    doc: Discard sequences where at least this many quality scores are above a 
      threshold (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-above-count
  - id: discard_qual_above_range
    type:
      - 'null'
      - string
    doc: Discard sequences where at least one quality score is above this range 
      (e.g., '20-30') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-above-range
  - id: discard_qual_above_threshold
    type:
      - 'null'
      - int
    doc: Discard sequences where at least one quality score is above this 
      threshold (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-above-threshold
  - id: discard_qual_below
    type:
      - 'null'
      - int
    doc: Discard sequences where at least one quality score is below this 
      threshold (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-below
  - id: discard_qual_below_count
    type:
      - 'null'
      - int
    doc: Discard sequences where at least this many quality scores are below a 
      threshold (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-below-count
  - id: discard_qual_below_range
    type:
      - 'null'
      - string
    doc: Discard sequences where at least one quality score is below this range 
      (e.g., '20-30') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-below-range
  - id: discard_qual_below_threshold
    type:
      - 'null'
      - int
    doc: Discard sequences where at least one quality score is below this 
      threshold (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-below-threshold
  - id: discard_qual_range
    type:
      - 'null'
      - string
    doc: Discard sequences where all quality scores are within this range (e.g.,
      '20-30') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-range
  - id: discard_qual_score_at_pos
    type:
      - 'null'
      - string
    doc: Discard sequences where the quality score at the specified position(s) 
      is below this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos
  - id: discard_qual_score_at_pos_avg
    type:
      - 'null'
      - string
    doc: Discard sequences where the average quality score at the specified 
      positions is below this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-avg
  - id: discard_qual_score_at_pos_avg_count
    type:
      - 'null'
      - string
    doc: Discard sequences where the average quality score at the specified 
      positions is below this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-avg-count
  - id: discard_qual_score_at_pos_avg_iqr
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the average quality 
      score at the specified positions is below this value (e.g., '10:20') (for 
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-avg-iqr
  - id: discard_qual_score_at_pos_avg_q1
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the average quality score
      at the specified positions is below this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-avg-q1
  - id: discard_qual_score_at_pos_avg_q3
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the average quality score
      at the specified positions is below this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-avg-q3
  - id: discard_qual_score_at_pos_avg_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the average quality score at the specified 
      positions is within this range (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-avg-range
  - id: discard_qual_score_at_pos_avg_range_count
    type:
      - 'null'
      - string
    doc: Discard sequences where the average quality score within the specified 
      position ranges is below this value (e.g., '10-20:30-40') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-avg-range-count
  - id: discard_qual_score_at_pos_avg_stddev
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of the average quality 
      score at the specified positions is below this value (e.g., '10:20') (for 
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-avg-stddev
  - id: discard_qual_score_at_pos_count
    type:
      - 'null'
      - string
    doc: Discard sequences where at least this many quality scores at the 
      specified positions are above a threshold (e.g., '2:10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-count
  - id: discard_qual_score_at_pos_count_avg
    type:
      - 'null'
      - string
    doc: Discard sequences where the average count of quality scores above a 
      threshold at the specified positions is below this value (e.g., '2:10') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-count-avg
  - id: discard_qual_score_at_pos_count_avg_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the average count of quality scores within a 
      range at the specified positions is below this value (e.g., '2:10-20') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-count-avg-range
  - id: discard_qual_score_at_pos_count_iqr
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the count of quality
      scores above a threshold at the specified positions is below this value 
      (e.g., '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-count-iqr
  - id: discard_qual_score_at_pos_count_q1
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the count of quality 
      scores above a threshold at the specified positions is below this value 
      (e.g., '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-count-q1
  - id: discard_qual_score_at_pos_count_q3
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the count of quality 
      scores above a threshold at the specified positions is below this value 
      (e.g., '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-count-q3
  - id: discard_qual_score_at_pos_count_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the count of quality scores within a range at 
      the specified positions is below this value (e.g., '2:10-20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-count-range
  - id: discard_qual_score_at_pos_count_range_stddev
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of the count of quality 
      scores within a range at the specified positions is below this value 
      (e.g., '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-count-range-stddev
  - id: discard_qual_score_at_pos_count_stddev
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of the count of quality 
      scores above a threshold at the specified positions is below this value 
      (e.g., '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-count-stddev
  - id: discard_qual_score_at_pos_iqr
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of quality scores at 
      the specified positions is below this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr
  - id: discard_qual_score_at_pos_iqr_avg
    type:
      - 'null'
      - string
    doc: Discard sequences where the average of the interquartile range of 
      quality scores at the specified positions is below this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-avg
  - id: discard_qual_score_at_pos_iqr_count
    type:
      - 'null'
      - string
    doc: Discard sequences where the count of interquartile ranges of quality 
      scores above a threshold at the specified positions is below this value 
      (e.g., '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-count
  - id: discard_qual_score_at_pos_iqr_iqr
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the interquartile 
      range of quality scores at the specified positions is below this value 
      (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-iqr
  - id: discard_qual_score_at_pos_iqr_q1
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the interquartile range 
      of quality scores at the specified positions is below this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-q1
  - id: discard_qual_score_at_pos_iqr_q3
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the interquartile range 
      of quality scores at the specified positions is below this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-q3
  - id: discard_qual_score_at_pos_iqr_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of quality scores 
      within the specified position ranges is below this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-range
  - id: discard_qual_score_at_pos_iqr_range_avg
    type:
      - 'null'
      - string
    doc: Discard sequences where the average of the interquartile range of 
      quality scores within the specified position ranges is below this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-range-avg
  - id: discard_qual_score_at_pos_iqr_range_avg_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the average of the interquartile range of 
      quality scores within the specified position ranges is below this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-range-avg-range
  - id: discard_qual_score_at_pos_iqr_range_avg_range_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the average of the interquartile range of 
      quality scores within the specified position ranges is below this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-range-avg-range-range
  - id: discard_qual_score_at_pos_iqr_range_iqr
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the interquartile 
      range of quality scores within the specified position ranges is below this
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-range-iqr
  - id: discard_qual_score_at_pos_iqr_range_iqr_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the interquartile 
      range of quality scores within the specified position ranges is below this
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-range-iqr-range
  - id: discard_qual_score_at_pos_iqr_range_iqr_range_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the interquartile 
      range of quality scores within the specified position ranges is below this
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-range-iqr-range-range
  - id: discard_qual_score_at_pos_iqr_range_q1
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the interquartile range 
      of quality scores within the specified position ranges is below this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-range-q1
  - id: discard_qual_score_at_pos_iqr_range_q1_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the interquartile range 
      of quality scores within the specified position ranges is below this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-range-q1-range
  - id: discard_qual_score_at_pos_iqr_range_q1_range_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the interquartile range 
      of quality scores within the specified position ranges is below this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-range-q1-range-range
  - id: discard_qual_score_at_pos_iqr_range_q3
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the interquartile range 
      of quality scores within the specified position ranges is below this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-range-q3
  - id: discard_qual_score_at_pos_iqr_range_q3_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the interquartile range 
      of quality scores within the specified position ranges is below this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-range-q3-range
  - id: discard_qual_score_at_pos_iqr_range_q3_range_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the interquartile range 
      of quality scores within the specified position ranges is below this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-range-q3-range-range
  - id: discard_qual_score_at_pos_iqr_stddev
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of the interquartile 
      range of quality scores at the specified positions is below this value 
      (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-iqr-stddev
  - id: discard_qual_score_at_pos_q1
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of quality scores at the 
      specified positions is below this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q1
  - id: discard_qual_score_at_pos_q1_avg
    type:
      - 'null'
      - string
    doc: Discard sequences where the average of the first quartile of quality 
      scores at the specified positions is below this value (e.g., '10:20') (for
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q1-avg
  - id: discard_qual_score_at_pos_q1_count
    type:
      - 'null'
      - string
    doc: Discard sequences where the count of first quartiles of quality scores 
      above a threshold at the specified positions is below this value (e.g., 
      '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q1-count
  - id: discard_qual_score_at_pos_q1_iqr
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the first quartile 
      of quality scores at the specified positions is below this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q1-iqr
  - id: discard_qual_score_at_pos_q1_q1
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the first quartile of 
      quality scores at the specified positions is below this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q1-q1
  - id: discard_qual_score_at_pos_q1_q3
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the first quartile of 
      quality scores at the specified positions is below this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q1-q3
  - id: discard_qual_score_at_pos_q1_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of quality scores within the
      specified position ranges is below this value (e.g., '10-20:30-40') (for 
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q1-range
  - id: discard_qual_score_at_pos_q1_stddev
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of the first quartile of
      quality scores at the specified positions is below this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q1-stddev
  - id: discard_qual_score_at_pos_q3
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of quality scores at the 
      specified positions is below this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q3
  - id: discard_qual_score_at_pos_q3_avg
    type:
      - 'null'
      - string
    doc: Discard sequences where the average of the third quartile of quality 
      scores at the specified positions is below this value (e.g., '10:20') (for
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q3-avg
  - id: discard_qual_score_at_pos_q3_count
    type:
      - 'null'
      - string
    doc: Discard sequences where the count of third quartiles of quality scores 
      above a threshold at the specified positions is below this value (e.g., 
      '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q3-count
  - id: discard_qual_score_at_pos_q3_iqr
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the third quartile 
      of quality scores at the specified positions is below this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q3-iqr
  - id: discard_qual_score_at_pos_q3_q1
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the third quartile of 
      quality scores at the specified positions is below this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q3-q1
  - id: discard_qual_score_at_pos_q3_q3
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the third quartile of 
      quality scores at the specified positions is below this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q3-q3
  - id: discard_qual_score_at_pos_q3_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of quality scores within the
      specified position ranges is below this value (e.g., '10-20:30-40') (for 
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q3-range
  - id: discard_qual_score_at_pos_q3_stddev
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of the third quartile of
      quality scores at the specified positions is below this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-q3-stddev
  - id: discard_qual_score_at_pos_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the quality score at the specified position(s) 
      is within this range (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range
  - id: discard_qual_score_at_pos_range_avg
    type:
      - 'null'
      - string
    doc: Discard sequences where the average quality score within the specified 
      position ranges is below this value (e.g., '10-20:30-40') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-avg
  - id: discard_qual_score_at_pos_range_avg_iqr
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the average quality 
      score within the specified position ranges is below this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-avg-iqr
  - id: discard_qual_score_at_pos_range_avg_iqr_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the average quality 
      score within the specified position ranges is below this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-avg-iqr-range
  - id: discard_qual_score_at_pos_range_avg_q1
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the average quality score
      within the specified position ranges is below this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-avg-q1
  - id: discard_qual_score_at_pos_range_avg_q1_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the average quality score
      within the specified position ranges is below this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-avg-q1-range
  - id: discard_qual_score_at_pos_range_avg_q3
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the average quality score
      within the specified position ranges is below this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-avg-q3
  - id: discard_qual_score_at_pos_range_avg_q3_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the average quality score
      within the specified position ranges is below this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-avg-q3-range
  - id: discard_qual_score_at_pos_range_avg_stddev
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of the average quality 
      score within the specified position ranges is below this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-avg-stddev
  - id: discard_qual_score_at_pos_range_avg_stddev_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of the average quality 
      score within the specified position ranges is below this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-avg-stddev-range
  - id: discard_qual_score_at_pos_range_count
    type:
      - 'null'
      - string
    doc: Discard sequences where at least this many quality scores at the 
      specified positions are within a range (e.g., '2:10-20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-count
  - id: discard_qual_score_at_pos_range_count_avg
    type:
      - 'null'
      - string
    doc: Discard sequences where the average count of quality scores within a 
      range at the specified positions is below this value (e.g., '2:10-20') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-count-avg
  - id: discard_qual_score_at_pos_range_count_iqr
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the count of quality
      scores within a range at the specified positions is below this value 
      (e.g., '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-count-iqr
  - id: discard_qual_score_at_pos_range_count_q1
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the count of quality 
      scores within a range at the specified positions is below this value 
      (e.g., '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-count-q1
  - id: discard_qual_score_at_pos_range_count_q3
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the count of quality 
      scores within a range at the specified positions is below this value 
      (e.g., '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-count-q3
  - id: discard_qual_score_at_pos_range_count_stddev
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of the count of quality 
      scores within a range at the specified positions is below this value 
      (e.g., '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-count-stddev
  - id: discard_qual_score_at_pos_range_iqr
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of quality scores 
      within the specified position ranges is below this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-iqr
  - id: discard_qual_score_at_pos_range_q1
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of quality scores within the
      specified position ranges is below this value (e.g., '10-20:30-40') (for 
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-q1
  - id: discard_qual_score_at_pos_range_q3
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of quality scores within the
      specified position ranges is below this value (e.g., '10-20:30-40') (for 
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-q3
  - id: discard_qual_score_at_pos_range_stddev
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of quality scores within
      the specified position ranges is below this value (e.g., '10-20:30-40') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-stddev
  - id: discard_qual_score_at_pos_range_threshold
    type:
      - 'null'
      - string
    doc: Discard sequences where the quality score at the specified position(s) 
      is within this range (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-range-threshold
  - id: discard_qual_score_at_pos_stddev
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of quality scores at the
      specified positions is below this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev
  - id: discard_qual_score_at_pos_stddev_count
    type:
      - 'null'
      - string
    doc: Discard sequences where the count of standard deviations of quality 
      scores above a threshold at the specified positions is below this value 
      (e.g., '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-count
  - id: discard_qual_score_at_pos_stddev_iqr
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the standard 
      deviation of quality scores at the specified positions is below this value
      (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-iqr
  - id: discard_qual_score_at_pos_stddev_q1
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the standard deviation of
      quality scores at the specified positions is below this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-q1
  - id: discard_qual_score_at_pos_stddev_q3
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the standard deviation of
      quality scores at the specified positions is below this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-q3
  - id: discard_qual_score_at_pos_stddev_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of quality scores within
      the specified position ranges is below this value (e.g., '10-20:30-40') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-range
  - id: discard_qual_score_at_pos_stddev_range_avg
    type:
      - 'null'
      - string
    doc: Discard sequences where the average of the standard deviation of 
      quality scores within the specified position ranges is below this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-range-avg
  - id: discard_qual_score_at_pos_stddev_range_iqr
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the standard 
      deviation of quality scores within the specified position ranges is below 
      this value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-range-iqr
  - id: discard_qual_score_at_pos_stddev_range_iqr_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the standard 
      deviation of quality scores within the specified position ranges is below 
      this value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-range-iqr-range
  - id: discard_qual_score_at_pos_stddev_range_iqr_range_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the interquartile range of the standard 
      deviation of quality scores within the specified position ranges is below 
      this value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-range-iqr-range-range
  - id: discard_qual_score_at_pos_stddev_range_q1
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the standard deviation of
      quality scores within the specified position ranges is below this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-range-q1
  - id: discard_qual_score_at_pos_stddev_range_q1_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the standard deviation of
      quality scores within the specified position ranges is below this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-range-q1-range
  - id: discard_qual_score_at_pos_stddev_range_q1_range_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the first quartile of the standard deviation of
      quality scores within the specified position ranges is below this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-range-q1-range-range
  - id: discard_qual_score_at_pos_stddev_range_q3
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the standard deviation of
      quality scores within the specified position ranges is below this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-range-q3
  - id: discard_qual_score_at_pos_stddev_range_q3_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the standard deviation of
      quality scores within the specified position ranges is below this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-range-q3-range
  - id: discard_qual_score_at_pos_stddev_range_q3_range_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the third quartile of the standard deviation of
      quality scores within the specified position ranges is below this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-range-q3-range-range
  - id: discard_qual_score_at_pos_stddev_range_stddev
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of the standard 
      deviation of quality scores within the specified position ranges is below 
      this value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-range-stddev
  - id: discard_qual_score_at_pos_stddev_range_stddev_range
    type:
      - 'null'
      - string
    doc: Discard sequences where the standard deviation of the standard 
      deviation of quality scores within the specified position ranges is below 
      this value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-stddev-range-stddev-range
  - id: discard_qual_score_at_pos_threshold
    type:
      - 'null'
      - string
    doc: Discard sequences where the quality score at the specified position(s) 
      is below this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --discard-qual-score-at-pos-threshold
  - id: discard_regex
    type:
      - 'null'
      - string
    doc: Discard sequences whose IDs match this regular expression.
    inputBinding:
      position: 102
      prefix: --discard-regex
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: keep_ambiguous
    type:
      - 'null'
      - boolean
    doc: Keep sequences with ambiguous bases (e.g., 'N').
    inputBinding:
      position: 102
      prefix: --keep-ambiguous
  - id: keep_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Keep only sequences with IDs in this comma-separated list.
    inputBinding:
      position: 102
      prefix: --keep-ids
  - id: keep_qual_above
    type:
      - 'null'
      - int
    doc: Keep sequences where at least one quality score is above this threshold
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --keep-qual-above
  - id: keep_qual_above_count
    type:
      - 'null'
      - int
    doc: Keep sequences where at least this many quality scores are above a 
      threshold (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --keep-qual-above-count
  - id: keep_qual_above_range
    type:
      - 'null'
      - string
    doc: Keep sequences where at least one quality score is above this range 
      (e.g., '20-30') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --keep-qual-above-range
  - id: keep_qual_above_threshold
    type:
      - 'null'
      - int
    doc: Keep sequences where at least one quality score is above this threshold
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --keep-qual-above-threshold
  - id: keep_qual_below
    type:
      - 'null'
      - int
    doc: Keep sequences where at least one quality score is below this threshold
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --keep-qual-below
  - id: keep_qual_below_count
    type:
      - 'null'
      - int
    doc: Keep sequences where at least this many quality scores are below a 
      threshold (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --keep-qual-below-count
  - id: keep_qual_below_range
    type:
      - 'null'
      - string
    doc: Keep sequences where at least one quality score is below this range 
      (e.g., '20-30') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --keep-qual-below-range
  - id: keep_qual_below_threshold
    type:
      - 'null'
      - int
    doc: Keep sequences where at least one quality score is below this threshold
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --keep-qual-below-threshold
  - id: keep_qual_range
    type:
      - 'null'
      - string
    doc: Keep sequences where all quality scores are within this range (e.g., 
      '20-30') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --keep-qual-range
  - id: keep_regex
    type:
      - 'null'
      - string
    doc: Keep only sequences whose IDs match this regular expression.
    inputBinding:
      position: 102
      prefix: --keep-regex
  - id: max_gc
    type:
      - 'null'
      - float
    doc: Maximum GC content percentage to keep.
    inputBinding:
      position: 102
      prefix: --max-gc
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum sequence length to keep.
    inputBinding:
      position: 102
      prefix: --max-length
  - id: max_n
    type:
      - 'null'
      - int
    doc: Maximum number of 'N' bases to keep.
    inputBinding:
      position: 102
      prefix: --max-n
  - id: max_n_ratio
    type:
      - 'null'
      - float
    doc: Maximum ratio of 'N' bases to keep.
    inputBinding:
      position: 102
      prefix: --max-n-ratio
  - id: max_qual
    type:
      - 'null'
      - int
    doc: Maximum average quality score to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual
  - id: max_qual_avg
    type:
      - 'null'
      - float
    doc: Maximum average quality score to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-avg
  - id: max_qual_iqr
    type:
      - 'null'
      - float
    doc: Maximum interquartile range of quality scores to keep (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --max-qual-iqr
  - id: max_qual_median
    type:
      - 'null'
      - float
    doc: Maximum median quality score to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-median
  - id: max_qual_q1
    type:
      - 'null'
      - float
    doc: Maximum first quartile of quality scores to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-q1
  - id: max_qual_q3
    type:
      - 'null'
      - float
    doc: Maximum third quartile of quality scores to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-q3
  - id: max_qual_score
    type:
      - 'null'
      - int
    doc: Maximum quality score for any base to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score
  - id: max_qual_score_at_pos
    type:
      - 'null'
      - string
    doc: Keep sequences where the quality score at the specified position(s) is 
      at most this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos
  - id: max_qual_score_at_pos_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average quality score at the specified 
      positions is at most this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-avg
  - id: max_qual_score_at_pos_avg_count
    type:
      - 'null'
      - string
    doc: Keep sequences where the average quality score at the specified 
      positions is at most this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-avg-count
  - id: max_qual_score_at_pos_avg_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the average quality 
      score at the specified positions is at most this value (e.g., '10:20') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-avg-iqr
  - id: max_qual_score_at_pos_avg_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the average quality score at
      the specified positions is at most this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-avg-q1
  - id: max_qual_score_at_pos_avg_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the average quality score at
      the specified positions is at most this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-avg-q3
  - id: max_qual_score_at_pos_avg_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the average quality score at the specified 
      positions is within this range (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-avg-range
  - id: max_qual_score_at_pos_avg_range_count
    type:
      - 'null'
      - string
    doc: Keep sequences where the average quality score within the specified 
      position ranges is at most this value (e.g., '10-20:30-40') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-avg-range-count
  - id: max_qual_score_at_pos_avg_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the average quality 
      score at the specified positions is at most this value (e.g., '10:20') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-avg-stddev
  - id: max_qual_score_at_pos_count
    type:
      - 'null'
      - string
    doc: Keep sequences where at most this many quality scores at the specified 
      positions are above a threshold (e.g., '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-count
  - id: max_qual_score_at_pos_count_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average count of quality scores above a 
      threshold at the specified positions is at most this value (e.g., '2:10') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-count-avg
  - id: max_qual_score_at_pos_count_avg_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the average count of quality scores within a range
      at the specified positions is at most this value (e.g., '2:10-20') (for 
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-count-avg-range
  - id: max_qual_score_at_pos_count_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the count of quality 
      scores above a threshold at the specified positions is at most this value 
      (e.g., '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-count-iqr
  - id: max_qual_score_at_pos_count_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the count of quality scores 
      above a threshold at the specified positions is at most this value (e.g., 
      '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-count-q1
  - id: max_qual_score_at_pos_count_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the count of quality scores 
      above a threshold at the specified positions is at most this value (e.g., 
      '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-count-q3
  - id: max_qual_score_at_pos_count_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the count of quality scores within a range at the 
      specified positions is at most this value (e.g., '2:10-20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-count-range
  - id: max_qual_score_at_pos_count_range_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the count of quality 
      scores within a range at the specified positions is at most this value 
      (e.g., '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-count-range-stddev
  - id: max_qual_score_at_pos_count_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the count of quality 
      scores above a threshold at the specified positions is at most this value 
      (e.g., '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-count-stddev
  - id: max_qual_score_at_pos_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of quality scores at the 
      specified positions is at most this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr
  - id: max_qual_score_at_pos_iqr_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the interquartile range of quality 
      scores at the specified positions is at most this value (e.g., '10:20') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-avg
  - id: max_qual_score_at_pos_iqr_count
    type:
      - 'null'
      - string
    doc: Keep sequences where the count of interquartile ranges of quality 
      scores above a threshold at the specified positions is at most this value 
      (e.g., '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-count
  - id: max_qual_score_at_pos_iqr_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the interquartile range
      of quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-iqr
  - id: max_qual_score_at_pos_iqr_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the interquartile range of 
      quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-q1
  - id: max_qual_score_at_pos_iqr_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the interquartile range of 
      quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-q3
  - id: max_qual_score_at_pos_iqr_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of quality scores within 
      the specified position ranges is at most this value (e.g., '10-20:30-40') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-range
  - id: max_qual_score_at_pos_iqr_range_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the interquartile range of quality 
      scores within the specified position ranges is at most this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-range-avg
  - id: max_qual_score_at_pos_iqr_range_avg_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the interquartile range of quality 
      scores within the specified position ranges is at most this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-range-avg-range
  - id: max_qual_score_at_pos_iqr_range_avg_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the interquartile range of quality 
      scores within the specified position ranges is at most this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-range-avg-range-range
  - id: max_qual_score_at_pos_iqr_range_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the interquartile range
      of quality scores within the specified position ranges is at most this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-range-iqr
  - id: max_qual_score_at_pos_iqr_range_iqr_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the interquartile range
      of quality scores within the specified position ranges is at most this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-range-iqr-range
  - id: max_qual_score_at_pos_iqr_range_iqr_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the interquartile range
      of quality scores within the specified position ranges is at most this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-range-iqr-range-range
  - id: max_qual_score_at_pos_iqr_range_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the interquartile range of 
      quality scores within the specified position ranges is at most this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-range-q1
  - id: max_qual_score_at_pos_iqr_range_q1_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the interquartile range of 
      quality scores within the specified position ranges is at most this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-range-q1-range
  - id: max_qual_score_at_pos_iqr_range_q1_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the interquartile range of 
      quality scores within the specified position ranges is at most this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-range-q1-range-range
  - id: max_qual_score_at_pos_iqr_range_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the interquartile range of 
      quality scores within the specified position ranges is at most this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-range-q3
  - id: max_qual_score_at_pos_iqr_range_q3_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the interquartile range of 
      quality scores within the specified position ranges is at most this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-range-q3-range
  - id: max_qual_score_at_pos_iqr_range_q3_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the interquartile range of 
      quality scores within the specified position ranges is at most this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-range-q3-range-range
  - id: max_qual_score_at_pos_iqr_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the interquartile range 
      of quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-iqr-stddev
  - id: max_qual_score_at_pos_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of quality scores at the 
      specified positions is at most this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q1
  - id: max_qual_score_at_pos_q1_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the first quartile of quality 
      scores at the specified positions is at most this value (e.g., '10:20') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q1-avg
  - id: max_qual_score_at_pos_q1_count
    type:
      - 'null'
      - string
    doc: Keep sequences where the count of first quartiles of quality scores 
      above a threshold at the specified positions is at most this value (e.g., 
      '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q1-count
  - id: max_qual_score_at_pos_q1_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the first quartile of 
      quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q1-iqr
  - id: max_qual_score_at_pos_q1_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the first quartile of 
      quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q1-q1
  - id: max_qual_score_at_pos_q1_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the first quartile of 
      quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q1-q3
  - id: max_qual_score_at_pos_q1_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of quality scores within the 
      specified position ranges is at most this value (e.g., '10-20:30-40') (for
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q1-range
  - id: max_qual_score_at_pos_q1_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the first quartile of 
      quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q1-stddev
  - id: max_qual_score_at_pos_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of quality scores at the 
      specified positions is at most this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q3
  - id: max_qual_score_at_pos_q3_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the third quartile of quality 
      scores at the specified positions is at most this value (e.g., '10:20') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q3-avg
  - id: max_qual_score_at_pos_q3_count
    type:
      - 'null'
      - string
    doc: Keep sequences where the count of third quartiles of quality scores 
      above a threshold at the specified positions is at most this value (e.g., 
      '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q3-count
  - id: max_qual_score_at_pos_q3_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the third quartile of 
      quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q3-iqr
  - id: max_qual_score_at_pos_q3_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the third quartile of 
      quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q3-q1
  - id: max_qual_score_at_pos_q3_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the third quartile of 
      quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q3-q3
  - id: max_qual_score_at_pos_q3_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of quality scores within the 
      specified position ranges is at most this value (e.g., '10-20:30-40') (for
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q3-range
  - id: max_qual_score_at_pos_q3_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the third quartile of 
      quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-q3-stddev
  - id: max_qual_score_at_pos_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the quality score at the specified position(s) is 
      within this range (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range
  - id: max_qual_score_at_pos_range_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average quality score within the specified 
      position ranges is at most this value (e.g., '10-20:30-40') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-avg
  - id: max_qual_score_at_pos_range_avg_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the average quality 
      score within the specified position ranges is at most this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-avg-iqr
  - id: max_qual_score_at_pos_range_avg_iqr_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the average quality 
      score within the specified position ranges is at most this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-avg-iqr-range
  - id: max_qual_score_at_pos_range_avg_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the average quality score 
      within the specified position ranges is at most this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-avg-q1
  - id: max_qual_score_at_pos_range_avg_q1_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the average quality score 
      within the specified position ranges is at most this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-avg-q1-range
  - id: max_qual_score_at_pos_range_avg_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the average quality score 
      within the specified position ranges is at most this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-avg-q3
  - id: max_qual_score_at_pos_range_avg_q3_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the average quality score 
      within the specified position ranges is at most this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-avg-q3-range
  - id: max_qual_score_at_pos_range_avg_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the average quality 
      score within the specified position ranges is at most this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-avg-stddev
  - id: max_qual_score_at_pos_range_avg_stddev_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the average quality 
      score within the specified position ranges is at most this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-avg-stddev-range
  - id: max_qual_score_at_pos_range_count
    type:
      - 'null'
      - string
    doc: Keep sequences where at most this many quality scores at the specified 
      positions are within a range (e.g., '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-count
  - id: max_qual_score_at_pos_range_count_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average count of quality scores within a range
      at the specified positions is at most this value (e.g., '2:10-20') (for 
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-count-avg
  - id: max_qual_score_at_pos_range_count_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the count of quality 
      scores within a range at the specified positions is at most this value 
      (e.g., '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-count-iqr
  - id: max_qual_score_at_pos_range_count_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the count of quality scores 
      within a range at the specified positions is at most this value (e.g., 
      '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-count-q1
  - id: max_qual_score_at_pos_range_count_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the count of quality scores 
      within a range at the specified positions is at most this value (e.g., 
      '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-count-q3
  - id: max_qual_score_at_pos_range_count_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the count of quality 
      scores within a range at the specified positions is at most this value 
      (e.g., '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-count-stddev
  - id: max_qual_score_at_pos_range_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of quality scores within 
      the specified position ranges is at most this value (e.g., '10-20:30-40') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-iqr
  - id: max_qual_score_at_pos_range_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of quality scores within the 
      specified position ranges is at most this value (e.g., '10-20:30-40') (for
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-q1
  - id: max_qual_score_at_pos_range_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of quality scores within the 
      specified position ranges is at most this value (e.g., '10-20:30-40') (for
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-q3
  - id: max_qual_score_at_pos_range_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of quality scores within 
      the specified position ranges is at most this value (e.g., '10-20:30-40') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-stddev
  - id: max_qual_score_at_pos_range_threshold
    type:
      - 'null'
      - string
    doc: Keep sequences where the quality score at the specified position(s) is 
      within this range (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-range-threshold
  - id: max_qual_score_at_pos_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of quality scores at the 
      specified positions is at most this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev
  - id: max_qual_score_at_pos_stddev_count
    type:
      - 'null'
      - string
    doc: Keep sequences where the count of standard deviations of quality scores
      above a threshold at the specified positions is at most this value (e.g., 
      '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-count
  - id: max_qual_score_at_pos_stddev_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the standard deviation 
      of quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-iqr
  - id: max_qual_score_at_pos_stddev_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the standard deviation of 
      quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-q1
  - id: max_qual_score_at_pos_stddev_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the standard deviation of 
      quality scores at the specified positions is at most this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-q3
  - id: max_qual_score_at_pos_stddev_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of quality scores within 
      the specified position ranges is at most this value (e.g., '10-20:30-40') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-range
  - id: max_qual_score_at_pos_stddev_range_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the standard deviation of quality 
      scores within the specified position ranges is at most this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-range-avg
  - id: max_qual_score_at_pos_stddev_range_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the standard deviation 
      of quality scores within the specified position ranges is at most this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-range-iqr
  - id: max_qual_score_at_pos_stddev_range_iqr_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the standard deviation 
      of quality scores within the specified position ranges is at most this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-range-iqr-range
  - id: max_qual_score_at_pos_stddev_range_iqr_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the standard deviation 
      of quality scores within the specified position ranges is at most this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-range-iqr-range-range
  - id: max_qual_score_at_pos_stddev_range_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the standard deviation of 
      quality scores within the specified position ranges is at most this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-range-q1
  - id: max_qual_score_at_pos_stddev_range_q1_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the standard deviation of 
      quality scores within the specified position ranges is at most this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-range-q1-range
  - id: max_qual_score_at_pos_stddev_range_q1_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the standard deviation of 
      quality scores within the specified position ranges is at most this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-range-q1-range-range
  - id: max_qual_score_at_pos_stddev_range_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the standard deviation of 
      quality scores within the specified position ranges is at most this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-range-q3
  - id: max_qual_score_at_pos_stddev_range_q3_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the standard deviation of 
      quality scores within the specified position ranges is at most this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-range-q3-range
  - id: max_qual_score_at_pos_stddev_range_q3_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the standard deviation of 
      quality scores within the specified position ranges is at most this value 
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-range-q3-range-range
  - id: max_qual_score_at_pos_stddev_range_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the standard deviation 
      of quality scores within the specified position ranges is at most this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-range-stddev
  - id: max_qual_score_at_pos_stddev_range_stddev_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the standard deviation 
      of quality scores within the specified position ranges is at most this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-stddev-range-stddev-range
  - id: max_qual_score_at_pos_threshold
    type:
      - 'null'
      - string
    doc: Keep sequences where the quality score at the specified position(s) is 
      at most this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-at-pos-threshold
  - id: max_qual_score_count
    type:
      - 'null'
      - int
    doc: Maximum count of bases with quality score above a threshold to keep 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-count
  - id: max_qual_score_ratio
    type:
      - 'null'
      - float
    doc: Maximum ratio of bases with quality score above a threshold to keep 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-score-ratio
  - id: max_qual_stddev
    type:
      - 'null'
      - float
    doc: Maximum standard deviation of quality scores to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --max-qual-stddev
  - id: min_gc
    type:
      - 'null'
      - float
    doc: Minimum GC content percentage to keep.
    inputBinding:
      position: 102
      prefix: --min-gc
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length to keep.
    inputBinding:
      position: 102
      prefix: --min-length
  - id: min_n
    type:
      - 'null'
      - int
    doc: Minimum number of 'N' bases to keep.
    inputBinding:
      position: 102
      prefix: --min-n
  - id: min_n_ratio
    type:
      - 'null'
      - float
    doc: Minimum ratio of 'N' bases to keep.
    inputBinding:
      position: 102
      prefix: --min-n-ratio
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Minimum average quality score to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual
  - id: min_qual_avg
    type:
      - 'null'
      - float
    doc: Minimum average quality score to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-avg
  - id: min_qual_iqr
    type:
      - 'null'
      - float
    doc: Minimum interquartile range of quality scores to keep (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --min-qual-iqr
  - id: min_qual_median
    type:
      - 'null'
      - float
    doc: Minimum median quality score to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-median
  - id: min_qual_q1
    type:
      - 'null'
      - float
    doc: Minimum first quartile of quality scores to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-q1
  - id: min_qual_q3
    type:
      - 'null'
      - float
    doc: Minimum third quartile of quality scores to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-q3
  - id: min_qual_score
    type:
      - 'null'
      - int
    doc: Minimum quality score for any base to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score
  - id: min_qual_score_at_pos
    type:
      - 'null'
      - string
    doc: Keep sequences where the quality score at the specified position(s) is 
      at least this value (e.g., '10:20' for positions 10 and 20) (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos
  - id: min_qual_score_at_pos_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average quality score at the specified 
      positions is at least this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-avg
  - id: min_qual_score_at_pos_avg_count
    type:
      - 'null'
      - string
    doc: Keep sequences where the average quality score at the specified 
      positions is at least this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-avg-count
  - id: min_qual_score_at_pos_avg_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the average quality 
      score at the specified positions is at least this value (e.g., '10:20') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-avg-iqr
  - id: min_qual_score_at_pos_avg_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the average quality score at
      the specified positions is at least this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-avg-q1
  - id: min_qual_score_at_pos_avg_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the average quality score at
      the specified positions is at least this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-avg-q3
  - id: min_qual_score_at_pos_avg_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the average quality score at the specified 
      positions is within this range (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-avg-range
  - id: min_qual_score_at_pos_avg_range_count
    type:
      - 'null'
      - string
    doc: Keep sequences where the average quality score within the specified 
      position ranges is at least this value (e.g., '10-20:30-40') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-avg-range-count
  - id: min_qual_score_at_pos_avg_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the average quality 
      score at the specified positions is at least this value (e.g., '10:20') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-avg-stddev
  - id: min_qual_score_at_pos_count
    type:
      - 'null'
      - string
    doc: Keep sequences where at least this many quality scores at the specified
      positions are above a threshold (e.g., '2:10' for 2 positions with score 
      >= 10) (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-count
  - id: min_qual_score_at_pos_count_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average count of quality scores above a 
      threshold at the specified positions is at least this value (e.g., '2:10')
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-count-avg
  - id: min_qual_score_at_pos_count_avg_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the average count of quality scores within a range
      at the specified positions is at least this value (e.g., '2:10-20') (for 
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-count-avg-range
  - id: min_qual_score_at_pos_count_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the count of quality 
      scores above a threshold at the specified positions is at least this value
      (e.g., '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-count-iqr
  - id: min_qual_score_at_pos_count_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the count of quality scores 
      above a threshold at the specified positions is at least this value (e.g.,
      '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-count-q1
  - id: min_qual_score_at_pos_count_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the count of quality scores 
      above a threshold at the specified positions is at least this value (e.g.,
      '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-count-q3
  - id: min_qual_score_at_pos_count_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the count of quality scores within a range at the 
      specified positions is at least this value (e.g., '2:10-20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-count-range
  - id: min_qual_score_at_pos_count_range_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the count of quality 
      scores within a range at the specified positions is at least this value 
      (e.g., '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-count-range-stddev
  - id: min_qual_score_at_pos_count_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the count of quality 
      scores above a threshold at the specified positions is at least this value
      (e.g., '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-count-stddev
  - id: min_qual_score_at_pos_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of quality scores at the 
      specified positions is at least this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr
  - id: min_qual_score_at_pos_iqr_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the interquartile range of quality 
      scores at the specified positions is at least this value (e.g., '10:20') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-avg
  - id: min_qual_score_at_pos_iqr_count
    type:
      - 'null'
      - string
    doc: Keep sequences where the count of interquartile ranges of quality 
      scores above a threshold at the specified positions is at least this value
      (e.g., '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-count
  - id: min_qual_score_at_pos_iqr_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the interquartile range
      of quality scores at the specified positions is at least this value (e.g.,
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-iqr
  - id: min_qual_score_at_pos_iqr_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the interquartile range of 
      quality scores at the specified positions is at least this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-q1
  - id: min_qual_score_at_pos_iqr_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the interquartile range of 
      quality scores at the specified positions is at least this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-q3
  - id: min_qual_score_at_pos_iqr_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of quality scores within 
      the specified position ranges is at least this value (e.g., '10-20:30-40')
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-range
  - id: min_qual_score_at_pos_iqr_range_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the interquartile range of quality 
      scores within the specified position ranges is at least this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-range-avg
  - id: min_qual_score_at_pos_iqr_range_avg_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the interquartile range of quality 
      scores within the specified position ranges is at least this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-range-avg-range
  - id: min_qual_score_at_pos_iqr_range_avg_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the interquartile range of quality 
      scores within the specified position ranges is at least this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-range-avg-range-range
  - id: min_qual_score_at_pos_iqr_range_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the interquartile range
      of quality scores within the specified position ranges is at least this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-range-iqr
  - id: min_qual_score_at_pos_iqr_range_iqr_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the interquartile range
      of quality scores within the specified position ranges is at least this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-range-iqr-range
  - id: min_qual_score_at_pos_iqr_range_iqr_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the interquartile range
      of quality scores within the specified position ranges is at least this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-range-iqr-range-range
  - id: min_qual_score_at_pos_iqr_range_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the interquartile range of 
      quality scores within the specified position ranges is at least this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-range-q1
  - id: min_qual_score_at_pos_iqr_range_q1_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the interquartile range of 
      quality scores within the specified position ranges is at least this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-range-q1-range
  - id: min_qual_score_at_pos_iqr_range_q1_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the interquartile range of 
      quality scores within the specified position ranges is at least this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-range-q1-range-range
  - id: min_qual_score_at_pos_iqr_range_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the interquartile range of 
      quality scores within the specified position ranges is at least this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-range-q3
  - id: min_qual_score_at_pos_iqr_range_q3_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the interquartile range of 
      quality scores within the specified position ranges is at least this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-range-q3-range
  - id: min_qual_score_at_pos_iqr_range_q3_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the interquartile range of 
      quality scores within the specified position ranges is at least this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-range-q3-range-range
  - id: min_qual_score_at_pos_iqr_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the interquartile range 
      of quality scores at the specified positions is at least this value (e.g.,
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-iqr-stddev
  - id: min_qual_score_at_pos_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of quality scores at the 
      specified positions is at least this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q1
  - id: min_qual_score_at_pos_q1_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the first quartile of quality 
      scores at the specified positions is at least this value (e.g., '10:20') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q1-avg
  - id: min_qual_score_at_pos_q1_count
    type:
      - 'null'
      - string
    doc: Keep sequences where the count of first quartiles of quality scores 
      above a threshold at the specified positions is at least this value (e.g.,
      '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q1-count
  - id: min_qual_score_at_pos_q1_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the first quartile of 
      quality scores at the specified positions is at least this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q1-iqr
  - id: min_qual_score_at_pos_q1_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the first quartile of 
      quality scores at the specified positions is at least this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q1-q1
  - id: min_qual_score_at_pos_q1_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the first quartile of 
      quality scores at the specified positions is at least this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q1-q3
  - id: min_qual_score_at_pos_q1_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of quality scores within the 
      specified position ranges is at least this value (e.g., '10-20:30-40') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q1-range
  - id: min_qual_score_at_pos_q1_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the first quartile of 
      quality scores at the specified positions is at least this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q1-stddev
  - id: min_qual_score_at_pos_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of quality scores at the 
      specified positions is at least this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q3
  - id: min_qual_score_at_pos_q3_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the third quartile of quality 
      scores at the specified positions is at least this value (e.g., '10:20') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q3-avg
  - id: min_qual_score_at_pos_q3_count
    type:
      - 'null'
      - string
    doc: Keep sequences where the count of third quartiles of quality scores 
      above a threshold at the specified positions is at least this value (e.g.,
      '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q3-count
  - id: min_qual_score_at_pos_q3_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the third quartile of 
      quality scores at the specified positions is at least this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q3-iqr
  - id: min_qual_score_at_pos_q3_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the third quartile of 
      quality scores at the specified positions is at least this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q3-q1
  - id: min_qual_score_at_pos_q3_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the third quartile of 
      quality scores at the specified positions is at least this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q3-q3
  - id: min_qual_score_at_pos_q3_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of quality scores within the 
      specified position ranges is at least this value (e.g., '10-20:30-40') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q3-range
  - id: min_qual_score_at_pos_q3_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the third quartile of 
      quality scores at the specified positions is at least this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-q3-stddev
  - id: min_qual_score_at_pos_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the quality score at the specified position(s) is 
      within this range (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range
  - id: min_qual_score_at_pos_range_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average quality score within the specified 
      position ranges is at least this value (e.g., '10-20:30-40') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-avg
  - id: min_qual_score_at_pos_range_avg_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the average quality 
      score within the specified position ranges is at least this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-avg-iqr
  - id: min_qual_score_at_pos_range_avg_iqr_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the average quality 
      score within the specified position ranges is at least this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-avg-iqr-range
  - id: min_qual_score_at_pos_range_avg_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the average quality score 
      within the specified position ranges is at least this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-avg-q1
  - id: min_qual_score_at_pos_range_avg_q1_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the average quality score 
      within the specified position ranges is at least this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-avg-q1-range
  - id: min_qual_score_at_pos_range_avg_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the average quality score 
      within the specified position ranges is at least this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-avg-q3
  - id: min_qual_score_at_pos_range_avg_q3_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the average quality score 
      within the specified position ranges is at least this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-avg-q3-range
  - id: min_qual_score_at_pos_range_avg_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the average quality 
      score within the specified position ranges is at least this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-avg-stddev
  - id: min_qual_score_at_pos_range_avg_stddev_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the average quality 
      score within the specified position ranges is at least this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-avg-stddev-range
  - id: min_qual_score_at_pos_range_count
    type:
      - 'null'
      - string
    doc: Keep sequences where at least this many quality scores at the specified
      positions are within a range (e.g., '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-count
  - id: min_qual_score_at_pos_range_count_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average count of quality scores within a range
      at the specified positions is at least this value (e.g., '2:10-20') (for 
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-count-avg
  - id: min_qual_score_at_pos_range_count_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the count of quality 
      scores within a range at the specified positions is at least this value 
      (e.g., '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-count-iqr
  - id: min_qual_score_at_pos_range_count_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the count of quality scores 
      within a range at the specified positions is at least this value (e.g., 
      '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-count-q1
  - id: min_qual_score_at_pos_range_count_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the count of quality scores 
      within a range at the specified positions is at least this value (e.g., 
      '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-count-q3
  - id: min_qual_score_at_pos_range_count_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the count of quality 
      scores within a range at the specified positions is at least this value 
      (e.g., '2:10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-count-stddev
  - id: min_qual_score_at_pos_range_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of quality scores within 
      the specified position ranges is at least this value (e.g., '10-20:30-40')
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-iqr
  - id: min_qual_score_at_pos_range_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of quality scores within the 
      specified position ranges is at least this value (e.g., '10-20:30-40') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-q1
  - id: min_qual_score_at_pos_range_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of quality scores within the 
      specified position ranges is at least this value (e.g., '10-20:30-40') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-q3
  - id: min_qual_score_at_pos_range_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of quality scores within 
      the specified position ranges is at least this value (e.g., '10-20:30-40')
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-stddev
  - id: min_qual_score_at_pos_range_threshold
    type:
      - 'null'
      - string
    doc: Keep sequences where the quality score at the specified position(s) is 
      within this range (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-range-threshold
  - id: min_qual_score_at_pos_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of quality scores at the 
      specified positions is at least this value (e.g., '10:20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev
  - id: min_qual_score_at_pos_stddev_count
    type:
      - 'null'
      - string
    doc: Keep sequences where the count of standard deviations of quality scores
      above a threshold at the specified positions is at least this value (e.g.,
      '2:10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-count
  - id: min_qual_score_at_pos_stddev_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the standard deviation 
      of quality scores at the specified positions is at least this value (e.g.,
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-iqr
  - id: min_qual_score_at_pos_stddev_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the standard deviation of 
      quality scores at the specified positions is at least this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-q1
  - id: min_qual_score_at_pos_stddev_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the standard deviation of 
      quality scores at the specified positions is at least this value (e.g., 
      '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-q3
  - id: min_qual_score_at_pos_stddev_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of quality scores within 
      the specified position ranges is at least this value (e.g., '10-20:30-40')
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-range
  - id: min_qual_score_at_pos_stddev_range_avg
    type:
      - 'null'
      - string
    doc: Keep sequences where the average of the standard deviation of quality 
      scores within the specified position ranges is at least this value (e.g., 
      '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-range-avg
  - id: min_qual_score_at_pos_stddev_range_iqr
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the standard deviation 
      of quality scores within the specified position ranges is at least this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-range-iqr
  - id: min_qual_score_at_pos_stddev_range_iqr_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the standard deviation 
      of quality scores within the specified position ranges is at least this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-range-iqr-range
  - id: min_qual_score_at_pos_stddev_range_iqr_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the interquartile range of the standard deviation 
      of quality scores within the specified position ranges is at least this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-range-iqr-range-range
  - id: min_qual_score_at_pos_stddev_range_q1
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the standard deviation of 
      quality scores within the specified position ranges is at least this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-range-q1
  - id: min_qual_score_at_pos_stddev_range_q1_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the standard deviation of 
      quality scores within the specified position ranges is at least this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-range-q1-range
  - id: min_qual_score_at_pos_stddev_range_q1_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the first quartile of the standard deviation of 
      quality scores within the specified position ranges is at least this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-range-q1-range-range
  - id: min_qual_score_at_pos_stddev_range_q3
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the standard deviation of 
      quality scores within the specified position ranges is at least this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-range-q3
  - id: min_qual_score_at_pos_stddev_range_q3_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the standard deviation of 
      quality scores within the specified position ranges is at least this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-range-q3-range
  - id: min_qual_score_at_pos_stddev_range_q3_range_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the third quartile of the standard deviation of 
      quality scores within the specified position ranges is at least this value
      (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-range-q3-range-range
  - id: min_qual_score_at_pos_stddev_range_stddev
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the standard deviation 
      of quality scores within the specified position ranges is at least this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-range-stddev
  - id: min_qual_score_at_pos_stddev_range_stddev_range
    type:
      - 'null'
      - string
    doc: Keep sequences where the standard deviation of the standard deviation 
      of quality scores within the specified position ranges is at least this 
      value (e.g., '10-20:30-40') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-stddev-range-stddev-range
  - id: min_qual_score_at_pos_threshold
    type:
      - 'null'
      - string
    doc: Keep sequences where the quality score at the specified position(s) is 
      at least this value (e.g., '10:20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-at-pos-threshold
  - id: min_qual_score_count
    type:
      - 'null'
      - int
    doc: Minimum count of bases with quality score above a threshold to keep 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-count
  - id: min_qual_score_ratio
    type:
      - 'null'
      - float
    doc: Minimum ratio of bases with quality score above a threshold to keep 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-score-ratio
  - id: min_qual_stddev
    type:
      - 'null'
      - float
    doc: Minimum standard deviation of quality scores to keep (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --min-qual-stddev
  - id: qual_count_threshold
    type:
      - 'null'
      - int
    doc: The quality score threshold used with --keep-qual-below-count and 
      --discard-qual-below-count (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-count-threshold
  - id: qual_score_at_pos_avg_count_threshold
    type:
      - 'null'
      - string
    doc: The average quality score threshold used with 
      --min-qual-score-at-pos-avg-count and --max-qual-score-at-pos-avg-count 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-avg-count-threshold
  - id: qual_score_at_pos_avg_iqr_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-avg-iqr and --max-qual-score-at-pos-avg-iqr (e.g.,
      '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-avg-iqr-threshold
  - id: qual_score_at_pos_avg_q1_threshold
    type:
      - 'null'
      - string
    doc: The first quartile threshold used with --min-qual-score-at-pos-avg-q1 
      and --max-qual-score-at-pos-avg-q1 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-avg-q1-threshold
  - id: qual_score_at_pos_avg_q3_threshold
    type:
      - 'null'
      - string
    doc: The third quartile threshold used with --min-qual-score-at-pos-avg-q3 
      and --max-qual-score-at-pos-avg-q3 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-avg-q3-threshold
  - id: qual_score_at_pos_avg_range_count_threshold
    type:
      - 'null'
      - string
    doc: The average quality score range threshold used with 
      --min-qual-score-at-pos-avg-range-count and 
      --max-qual-score-at-pos-avg-range-count (e.g., '10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-avg-range-count-threshold
  - id: qual_score_at_pos_avg_range_threshold
    type:
      - 'null'
      - string
    doc: The average quality score range threshold used with 
      --min-qual-score-at-pos-avg-range and --max-qual-score-at-pos-avg-range 
      (e.g., '10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-avg-range-threshold
  - id: qual_score_at_pos_avg_stddev_threshold
    type:
      - 'null'
      - string
    doc: The standard deviation threshold used with 
      --min-qual-score-at-pos-avg-stddev and --max-qual-score-at-pos-avg-stddev 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-avg-stddev-threshold
  - id: qual_score_at_pos_avg_threshold
    type:
      - 'null'
      - string
    doc: The average quality score threshold used with 
      --min-qual-score-at-pos-avg and --max-qual-score-at-pos-avg (e.g., '10') 
      (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-avg-threshold
  - id: qual_score_at_pos_count_avg_range_threshold
    type:
      - 'null'
      - string
    doc: The quality score range threshold used with 
      --min-qual-score-at-pos-count-avg-range and 
      --max-qual-score-at-pos-count-avg-range (e.g., '10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-count-avg-range-threshold
  - id: qual_score_at_pos_count_avg_threshold
    type:
      - 'null'
      - string
    doc: The quality score threshold used with --min-qual-score-at-pos-count-avg
      and --max-qual-score-at-pos-count-avg (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-count-avg-threshold
  - id: qual_score_at_pos_count_iqr_threshold
    type:
      - 'null'
      - string
    doc: The quality score threshold used with --min-qual-score-at-pos-count-iqr
      and --max-qual-score-at-pos-count-iqr (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-count-iqr-threshold
  - id: qual_score_at_pos_count_q1_threshold
    type:
      - 'null'
      - string
    doc: The quality score threshold used with --min-qual-score-at-pos-count-q1 
      and --max-qual-score-at-pos-count-q1 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-count-q1-threshold
  - id: qual_score_at_pos_count_q3_threshold
    type:
      - 'null'
      - string
    doc: The quality score threshold used with --min-qual-score-at-pos-count-q3 
      and --max-qual-score-at-pos-count-q3 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-count-q3-threshold
  - id: qual_score_at_pos_count_range_stddev_threshold
    type:
      - 'null'
      - string
    doc: The quality score range threshold used with 
      --min-qual-score-at-pos-count-range-stddev and 
      --max-qual-score-at-pos-count-range-stddev (e.g., '10-20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-count-range-stddev-threshold
  - id: qual_score_at_pos_count_range_threshold
    type:
      - 'null'
      - string
    doc: The quality score range threshold used with 
      --min-qual-score-at-pos-count-range and 
      --max-qual-score-at-pos-count-range (e.g., '10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-count-range-threshold
  - id: qual_score_at_pos_count_stddev_threshold
    type:
      - 'null'
      - string
    doc: The quality score threshold used with 
      --min-qual-score-at-pos-count-stddev and 
      --max-qual-score-at-pos-count-stddev (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-count-stddev-threshold
  - id: qual_score_at_pos_count_threshold
    type:
      - 'null'
      - string
    doc: The quality score threshold used with --min-qual-score-at-pos-count and
      --max-qual-score-at-pos-count (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-count-threshold
  - id: qual_score_at_pos_iqr_avg_threshold
    type:
      - 'null'
      - string
    doc: The average interquartile range threshold used with 
      --min-qual-score-at-pos-iqr-avg and --max-qual-score-at-pos-iqr-avg (e.g.,
      '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-avg-threshold
  - id: qual_score_at_pos_iqr_count_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-iqr-count and --max-qual-score-at-pos-iqr-count 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-count-threshold
  - id: qual_score_at_pos_iqr_iqr_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-iqr-iqr and --max-qual-score-at-pos-iqr-iqr (e.g.,
      '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-iqr-threshold
  - id: qual_score_at_pos_iqr_q1_threshold
    type:
      - 'null'
      - string
    doc: The first quartile threshold used with --min-qual-score-at-pos-iqr-q1 
      and --max-qual-score-at-pos-iqr-q1 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-q1-threshold
  - id: qual_score_at_pos_iqr_q3_threshold
    type:
      - 'null'
      - string
    doc: The third quartile threshold used with --min-qual-score-at-pos-iqr-q3 
      and --max-qual-score-at-pos-iqr-q3 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-q3-threshold
  - id: qual_score_at_pos_iqr_range_avg_range_range_threshold
    type:
      - 'null'
      - string
    doc: The average interquartile range threshold used with 
      --min-qual-score-at-pos-iqr-range-avg-range-range and 
      --max-qual-score-at-pos-iqr-range-avg-range-range (e.g., '10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-range-avg-range-range-threshold
  - id: qual_score_at_pos_iqr_range_avg_range_threshold
    type:
      - 'null'
      - string
    doc: The average interquartile range threshold used with 
      --min-qual-score-at-pos-iqr-range-avg-range and 
      --max-qual-score-at-pos-iqr-range-avg-range (e.g., '10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-range-avg-range-threshold
  - id: qual_score_at_pos_iqr_range_avg_threshold
    type:
      - 'null'
      - string
    doc: The average interquartile range threshold used with 
      --min-qual-score-at-pos-iqr-range-avg and 
      --max-qual-score-at-pos-iqr-range-avg (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-range-avg-threshold
  - id: qual_score_at_pos_iqr_range_iqr_range_range_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-iqr-range-iqr-range-range and 
      --max-qual-score-at-pos-iqr-range-iqr-range-range (e.g., '10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-range-iqr-range-range-threshold
  - id: qual_score_at_pos_iqr_range_iqr_range_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-iqr-range-iqr-range and 
      --max-qual-score-at-pos-iqr-range-iqr-range (e.g., '10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-range-iqr-range-threshold
  - id: qual_score_at_pos_iqr_range_iqr_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-iqr-range-iqr and 
      --max-qual-score-at-pos-iqr-range-iqr (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-range-iqr-threshold
  - id: qual_score_at_pos_iqr_range_q1_range_range_threshold
    type:
      - 'null'
      - string
    doc: The first quartile range threshold used with 
      --min-qual-score-at-pos-iqr-range-q1-range-range and 
      --max-qual-score-at-pos-iqr-range-q1-range-range (e.g., '10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-range-q1-range-range-threshold
  - id: qual_score_at_pos_iqr_range_q1_range_threshold
    type:
      - 'null'
      - string
    doc: The first quartile range threshold used with 
      --min-qual-score-at-pos-iqr-range-q1-range and 
      --max-qual-score-at-pos-iqr-range-q1-range (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-range-q1-range-threshold
  - id: qual_score_at_pos_iqr_range_q1_threshold
    type:
      - 'null'
      - string
    doc: The first quartile threshold used with 
      --min-qual-score-at-pos-iqr-range-q1 and 
      --max-qual-score-at-pos-iqr-range-q1 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-range-q1-threshold
  - id: qual_score_at_pos_iqr_range_q3_range_range_threshold
    type:
      - 'null'
      - string
    doc: The third quartile range threshold used with 
      --min-qual-score-at-pos-iqr-range-q3-range-range and 
      --max-qual-score-at-pos-iqr-range-q3-range-range (e.g., '10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-range-q3-range-range-threshold
  - id: qual_score_at_pos_iqr_range_q3_range_threshold
    type:
      - 'null'
      - string
    doc: The third quartile range threshold used with 
      --min-qual-score-at-pos-iqr-range-q3-range and 
      --max-qual-score-at-pos-iqr-range-q3-range (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-range-q3-range-threshold
  - id: qual_score_at_pos_iqr_range_q3_threshold
    type:
      - 'null'
      - string
    doc: The third quartile threshold used with 
      --min-qual-score-at-pos-iqr-range-q3 and 
      --max-qual-score-at-pos-iqr-range-q3 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-range-q3-threshold
  - id: qual_score_at_pos_iqr_range_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-iqr-range and --max-qual-score-at-pos-iqr-range 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-range-threshold
  - id: qual_score_at_pos_iqr_stddev_threshold
    type:
      - 'null'
      - string
    doc: The standard deviation threshold used with 
      --min-qual-score-at-pos-iqr-stddev and --max-qual-score-at-pos-iqr-stddev 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-stddev-threshold
  - id: qual_score_at_pos_iqr_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with --min-qual-score-at-pos-iqr
      and --max-qual-score-at-pos-iqr (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-iqr-threshold
  - id: qual_score_at_pos_q1_avg_threshold
    type:
      - 'null'
      - string
    doc: The average first quartile threshold used with 
      --min-qual-score-at-pos-q1-avg and --max-qual-score-at-pos-q1-avg (e.g., 
      '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q1-avg-threshold
  - id: qual_score_at_pos_q1_count_threshold
    type:
      - 'null'
      - string
    doc: The first quartile threshold used with --min-qual-score-at-pos-q1-count
      and --max-qual-score-at-pos-q1-count (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q1-count-threshold
  - id: qual_score_at_pos_q1_iqr_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-q1-iqr and --max-qual-score-at-pos-q1-iqr (e.g., 
      '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q1-iqr-threshold
  - id: qual_score_at_pos_q1_q1_threshold
    type:
      - 'null'
      - string
    doc: The first quartile threshold used with --min-qual-score-at-pos-q1-q1 
      and --max-qual-score-at-pos-q1-q1 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q1-q1-threshold
  - id: qual_score_at_pos_q1_q3_threshold
    type:
      - 'null'
      - string
    doc: The third quartile threshold used with --min-qual-score-at-pos-q1-q3 
      and --max-qual-score-at-pos-q1-q3 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q1-q3-threshold
  - id: qual_score_at_pos_q1_range_threshold
    type:
      - 'null'
      - string
    doc: The first quartile range threshold used with 
      --min-qual-score-at-pos-q1-range and --max-qual-score-at-pos-q1-range 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q1-range-threshold
  - id: qual_score_at_pos_q1_stddev_threshold
    type:
      - 'null'
      - string
    doc: The standard deviation threshold used with 
      --min-qual-score-at-pos-q1-stddev and --max-qual-score-at-pos-q1-stddev 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q1-stddev-threshold
  - id: qual_score_at_pos_q1_threshold
    type:
      - 'null'
      - string
    doc: The first quartile threshold used with --min-qual-score-at-pos-q1 and 
      --max-qual-score-at-pos-q1 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q1-threshold
  - id: qual_score_at_pos_q3_avg_threshold
    type:
      - 'null'
      - string
    doc: The average third quartile threshold used with 
      --min-qual-score-at-pos-q3-avg and --max-qual-score-at-pos-q3-avg (e.g., 
      '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q3-avg-threshold
  - id: qual_score_at_pos_q3_count_threshold
    type:
      - 'null'
      - string
    doc: The third quartile threshold used with --min-qual-score-at-pos-q3-count
      and --max-qual-score-at-pos-q3-count (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q3-count-threshold
  - id: qual_score_at_pos_q3_iqr_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-q3-iqr and --max-qual-score-at-pos-q3-iqr (e.g., 
      '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q3-iqr-threshold
  - id: qual_score_at_pos_q3_q1_threshold
    type:
      - 'null'
      - string
    doc: The first quartile threshold used with --min-qual-score-at-pos-q3-q1 
      and --max-qual-score-at-pos-q3-q1 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q3-q1-threshold
  - id: qual_score_at_pos_q3_q3_threshold
    type:
      - 'null'
      - string
    doc: The third quartile threshold used with --min-qual-score-at-pos-q3-q3 
      and --max-qual-score-at-pos-q3-q3 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q3-q3-threshold
  - id: qual_score_at_pos_q3_range_threshold
    type:
      - 'null'
      - string
    doc: The third quartile range threshold used with 
      --min-qual-score-at-pos-q3-range and --max-qual-score-at-pos-q3-range 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q3-range-threshold
  - id: qual_score_at_pos_q3_stddev_threshold
    type:
      - 'null'
      - string
    doc: The standard deviation threshold used with 
      --min-qual-score-at-pos-q3-stddev and --max-qual-score-at-pos-q3-stddev 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q3-stddev-threshold
  - id: qual_score_at_pos_q3_threshold
    type:
      - 'null'
      - string
    doc: The third quartile threshold used with --min-qual-score-at-pos-q3 and 
      --max-qual-score-at-pos-q3 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-q3-threshold
  - id: qual_score_at_pos_range_avg_iqr_range_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-range-avg-iqr-range and 
      --max-qual-score-at-pos-range-avg-iqr-range (e.g., '10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-avg-iqr-range-threshold
  - id: qual_score_at_pos_range_avg_iqr_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-range-avg-iqr and 
      --max-qual-score-at-pos-range-avg-iqr (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-avg-iqr-threshold
  - id: qual_score_at_pos_range_avg_q1_range_threshold
    type:
      - 'null'
      - string
    doc: The first quartile range threshold used with 
      --min-qual-score-at-pos-range-avg-q1-range and 
      --max-qual-score-at-pos-range-avg-q1-range (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-avg-q1-range-threshold
  - id: qual_score_at_pos_range_avg_q1_threshold
    type:
      - 'null'
      - string
    doc: The first quartile threshold used with 
      --min-qual-score-at-pos-range-avg-q1 and 
      --max-qual-score-at-pos-range-avg-q1 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-avg-q1-threshold
  - id: qual_score_at_pos_range_avg_q3_range_threshold
    type:
      - 'null'
      - string
    doc: The third quartile range threshold used with 
      --min-qual-score-at-pos-range-avg-q3-range and 
      --max-qual-score-at-pos-range-avg-q3-range (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-avg-q3-range-threshold
  - id: qual_score_at_pos_range_avg_q3_threshold
    type:
      - 'null'
      - string
    doc: The third quartile threshold used with 
      --min-qual-score-at-pos-range-avg-q3 and 
      --max-qual-score-at-pos-range-avg-q3 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-avg-q3-threshold
  - id: qual_score_at_pos_range_avg_stddev_range_threshold
    type:
      - 'null'
      - string
    doc: The standard deviation range threshold used with 
      --min-qual-score-at-pos-range-avg-stddev-range and 
      --max-qual-score-at-pos-range-avg-stddev-range (e.g., '10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-avg-stddev-range-threshold
  - id: qual_score_at_pos_range_avg_stddev_threshold
    type:
      - 'null'
      - string
    doc: The standard deviation threshold used with 
      --min-qual-score-at-pos-range-avg-stddev and 
      --max-qual-score-at-pos-range-avg-stddev (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-avg-stddev-threshold
  - id: qual_score_at_pos_range_avg_threshold
    type:
      - 'null'
      - string
    doc: The average quality score threshold used with 
      --min-qual-score-at-pos-range-avg and --max-qual-score-at-pos-range-avg 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-avg-threshold
  - id: qual_score_at_pos_range_count_avg_threshold
    type:
      - 'null'
      - string
    doc: The quality score range threshold used with 
      --min-qual-score-at-pos-range-count-avg and 
      --max-qual-score-at-pos-range-count-avg (e.g., '10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-count-avg-threshold
  - id: qual_score_at_pos_range_count_iqr_threshold
    type:
      - 'null'
      - string
    doc: The quality score range threshold used with 
      --min-qual-score-at-pos-range-count-iqr and 
      --max-qual-score-at-pos-range-count-iqr (e.g., '10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-count-iqr-threshold
  - id: qual_score_at_pos_range_count_q1_threshold
    type:
      - 'null'
      - string
    doc: The quality score range threshold used with 
      --min-qual-score-at-pos-range-count-q1 and 
      --max-qual-score-at-pos-range-count-q1 (e.g., '10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-count-q1-threshold
  - id: qual_score_at_pos_range_count_q3_threshold
    type:
      - 'null'
      - string
    doc: The quality score range threshold used with 
      --min-qual-score-at-pos-range-count-q3 and 
      --max-qual-score-at-pos-range-count-q3 (e.g., '10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-count-q3-threshold
  - id: qual_score_at_pos_range_count_stddev_threshold
    type:
      - 'null'
      - string
    doc: The quality score range threshold used with 
      --min-qual-score-at-pos-range-count-stddev and 
      --max-qual-score-at-pos-range-count-stddev (e.g., '10-20') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-count-stddev-threshold
  - id: qual_score_at_pos_range_count_threshold
    type:
      - 'null'
      - string
    doc: The quality score range threshold used with 
      --min-qual-score-at-pos-range-count and 
      --max-qual-score-at-pos-range-count (e.g., '10-20') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-count-threshold
  - id: qual_score_at_pos_range_iqr_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-range-iqr and --max-qual-score-at-pos-range-iqr 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-iqr-threshold
  - id: qual_score_at_pos_range_q1_threshold
    type:
      - 'null'
      - string
    doc: The first quartile threshold used with --min-qual-score-at-pos-range-q1
      and --max-qual-score-at-pos-range-q1 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-q1-threshold
  - id: qual_score_at_pos_range_q3_threshold
    type:
      - 'null'
      - string
    doc: The third quartile threshold used with --min-qual-score-at-pos-range-q3
      and --max-qual-score-at-pos-range-q3 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-q3-threshold
  - id: qual_score_at_pos_range_stddev_threshold
    type:
      - 'null'
      - string
    doc: The standard deviation threshold used with 
      --min-qual-score-at-pos-range-stddev and 
      --max-qual-score-at-pos-range-stddev (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-range-stddev-threshold
  - id: qual_score_at_pos_stddev_count_threshold
    type:
      - 'null'
      - string
    doc: The standard deviation threshold used with 
      --min-qual-score-at-pos-stddev-count and 
      --max-qual-score-at-pos-stddev-count (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-count-threshold
  - id: qual_score_at_pos_stddev_iqr_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-stddev-iqr and --max-qual-score-at-pos-stddev-iqr 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-iqr-threshold
  - id: qual_score_at_pos_stddev_q1_threshold
    type:
      - 'null'
      - string
    doc: The first quartile threshold used with 
      --min-qual-score-at-pos-stddev-q1 and --max-qual-score-at-pos-stddev-q1 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-q1-threshold
  - id: qual_score_at_pos_stddev_q3_threshold
    type:
      - 'null'
      - string
    doc: The third quartile threshold used with 
      --min-qual-score-at-pos-stddev-q3 and --max-qual-score-at-pos-stddev-q3 
      (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-q3-threshold
  - id: qual_score_at_pos_stddev_range_avg_threshold
    type:
      - 'null'
      - string
    doc: The average standard deviation threshold used with 
      --min-qual-score-at-pos-stddev-range-avg and 
      --max-qual-score-at-pos-stddev-range-avg (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-range-avg-threshold
  - id: qual_score_at_pos_stddev_range_iqr_range_range_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-stddev-range-iqr-range-range and 
      --max-qual-score-at-pos-stddev-range-iqr-range-range (e.g., '10') (for 
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-range-iqr-range-range-threshold
  - id: qual_score_at_pos_stddev_range_iqr_range_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-stddev-range-iqr-range and 
      --max-qual-score-at-pos-stddev-range-iqr-range (e.g., '10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-range-iqr-range-threshold
  - id: qual_score_at_pos_stddev_range_iqr_threshold
    type:
      - 'null'
      - string
    doc: The interquartile range threshold used with 
      --min-qual-score-at-pos-stddev-range-iqr and 
      --max-qual-score-at-pos-stddev-range-iqr (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-range-iqr-threshold
  - id: qual_score_at_pos_stddev_range_q1_range_range_threshold
    type:
      - 'null'
      - string
    doc: The first quartile range threshold used with 
      --min-qual-score-at-pos-stddev-range-q1-range-range and 
      --max-qual-score-at-pos-stddev-range-q1-range-range (e.g., '10') (for 
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-range-q1-range-range-threshold
  - id: qual_score_at_pos_stddev_range_q1_range_threshold
    type:
      - 'null'
      - string
    doc: The first quartile range threshold used with 
      --min-qual-score-at-pos-stddev-range-q1-range and 
      --max-qual-score-at-pos-stddev-range-q1-range (e.g., '10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-range-q1-range-threshold
  - id: qual_score_at_pos_stddev_range_q1_threshold
    type:
      - 'null'
      - string
    doc: The first quartile threshold used with 
      --min-qual-score-at-pos-stddev-range-q1 and 
      --max-qual-score-at-pos-stddev-range-q1 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-range-q1-threshold
  - id: qual_score_at_pos_stddev_range_q3_range_range_threshold
    type:
      - 'null'
      - string
    doc: The third quartile range threshold used with 
      --min-qual-score-at-pos-stddev-range-q3-range-range and 
      --max-qual-score-at-pos-stddev-range-q3-range-range (e.g., '10') (for 
      FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-range-q3-range-range-threshold
  - id: qual_score_at_pos_stddev_range_q3_range_threshold
    type:
      - 'null'
      - string
    doc: The third quartile range threshold used with 
      --min-qual-score-at-pos-stddev-range-q3-range and 
      --max-qual-score-at-pos-stddev-range-q3-range (e.g., '10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-range-q3-range-threshold
  - id: qual_score_at_pos_stddev_range_q3_threshold
    type:
      - 'null'
      - string
    doc: The third quartile threshold used with 
      --min-qual-score-at-pos-stddev-range-q3 and 
      --max-qual-score-at-pos-stddev-range-q3 (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-range-q3-threshold
  - id: qual_score_at_pos_stddev_range_stddev_range_threshold
    type:
      - 'null'
      - string
    doc: The standard deviation range threshold used with 
      --min-qual-score-at-pos-stddev-range-stddev-range and 
      --max-qual-score-at-pos-stddev-range-stddev-range (e.g., '10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-range-stddev-range-threshold
  - id: qual_score_at_pos_stddev_range_stddev_threshold
    type:
      - 'null'
      - string
    doc: The standard deviation threshold used with 
      --min-qual-score-at-pos-stddev-range-stddev and 
      --max-qual-score-at-pos-stddev-range-stddev (e.g., '10') (for FASTQ 
      files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-range-stddev-threshold
  - id: qual_score_at_pos_stddev_range_threshold
    type:
      - 'null'
      - string
    doc: The standard deviation threshold used with 
      --min-qual-score-at-pos-stddev-range and 
      --max-qual-score-at-pos-stddev-range (e.g., '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-range-threshold
  - id: qual_score_at_pos_stddev_threshold
    type:
      - 'null'
      - string
    doc: The standard deviation threshold used with 
      --min-qual-score-at-pos-stddev and --max-qual-score-at-pos-stddev (e.g., 
      '10') (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-at-pos-stddev-threshold
  - id: qual_score_threshold
    type:
      - 'null'
      - int
    doc: The quality score threshold used with --min-qual-score-count and 
      --max-qual-score-count (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-score-threshold
  - id: qual_threshold
    type:
      - 'null'
      - int
    doc: The quality score threshold used with --min-qual-score-ratio and 
      --max-qual-score-ratio (for FASTQ files).
    inputBinding:
      position: 102
      prefix: --qual-threshold
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name. If not specified, output goes to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
