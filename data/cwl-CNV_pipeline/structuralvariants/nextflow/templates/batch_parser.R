args <- commandArgs(TRUE)

bamsList <- c(strsplit(args[1], ' ')[[1]])
bamsList <- sort(bamsList[grepl('*.bam$', bamsList)])
samplesFile <- read.table(args[2], header = T, sep = ' ')

bams <- data.frame(unlist(bamsList))
colnames(bams)[1] <- 'file'
samples <- samplesFile
samplesOrder <- samples[order(samples$sample_id),]

indx <- sapply(samplesOrder$sample_id, grep, bams$file)
temp_df <- cbind(samplesOrder[unlist(indx), , drop = F], bams[unlist(indx), , drop = F])
temp_df$index_file <- paste(temp_df$file, '.bai', sep = '')
output <- split(temp_df, temp_df$batch)

sapply(names(output), function(x)
  write.table(output[[x]], file = paste0('bams_x_batch_', x, '.csv'), sep = ',', row.names = F)))
