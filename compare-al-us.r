library(ggplot2)

f <- read.csv('frequencies.csv', stringsAsFactors = FALSE)
f$p <- f$percent / 100
f$percent <- NULL
f$language <- factor(f$language, levels = c('al', 'en'))
