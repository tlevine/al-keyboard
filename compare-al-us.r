#!/usr/bin/env Rscript
library(ggplot2)

f <- read.csv('frequencies.csv', stringsAsFactors = FALSE)
f$p <- f$percent / 100
f$percent <- NULL
f$language <- factor(f$language, levels = c('al', 'en'))

vowels <- c('a','e','i','o','u','ë')
common.letters <- intersect(f[f$language == 'al','letter'],
                            f[f$language == 'en','letter'])

f$unique <- f$letter %in% common.letters
f$unique <- factor(f$unique, levels = c(TRUE, FALSE))
f$vowel <- f$letter %in% vowels

levels(f$language) <- c('Albanian', 'English')
levels(f$unique) <- c('Both languages', 'Just one language')

scale <- 1.25
f$ylabel <- 1.5 + ((as.numeric(f$language) - 1.5 + c(-0.05, 0.05)) * scale)
p <- ggplot(f) +
       aes(group = letter, x = p, label = letter) +
       geom_line(aes(y = language)) +
       geom_text(aes(y = ylabel, ymax = ylabel,
                     color = unique, fontface = as.numeric(vowel) + 1),
                 position = 'dodge', size = 8) +
                #position = position_stack(height = 0))
       ggtitle('Common letters in Albanian and English') +
       xlab('Usage rate of the letter') +
       ylab('Language') +
       scale_color_discrete('Letter language')

ggsave('letter-usage.png', p, width = 16, height = 9)
