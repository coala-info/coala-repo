process BATCH_PARSER {
  tag { "batch parser" }
  container 'quay.io/biocontainers/r-exomedepth:1.1.12--r36h6786f55_0'

  input:
    path bams
    path samples

  output:
    path "bams_x_batch_*.csv"

  script:
  """
  #!/usr/bin/env Rscript

  bamsList <- c(strsplit('${bams}', ' ')[[1]])
  bamsList <- sort(bamsList[grepl('*.bam\$', bamsList)])
  samplesFile <- read.table('${samples}', header = T, sep = ' ')

  bams <- data.frame(unlist(bamsList))
  colnames(bams)[1] <- 'file'
  samples <- samplesFile
  samplesOrder <- samples[order(samples\$sample_id),]

  indx <- sapply(samplesOrder\$sample_id, grep, bams\$file)
  temp_df <- cbind(samplesOrder[unlist(indx), , drop = F], bams[unlist(indx), , drop = F])
  temp_df\$index_file <- paste(temp_df\$file, '.bai', sep = '')
  output <- split(temp_df, temp_df\$batch)

  sapply(names(output), function(x)
    write.table(output[[x]], file = paste0('bams_x_batch_', x, '.csv'), sep = ',', row.names = F))
  """
}
