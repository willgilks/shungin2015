## Run log
mylog = file("log_shunginAnalysis.txt", open = "wt")
sink(mylog)
Sys.time()

## DESCRIPTION

## R code for plotting summary results from Shungin et al New genetic loci link adipose and insulin biology to body fat distribution.
## Nature. 2015 Feb 12; 518(7538): 187–196. doi:  10.1038/nature14132
## Selected data is from Table 1 on this referenced publication, omitting the only locus from non-European study.
## http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4338562/table/T1/

## To make the published table readable into R, without downstream errors:
## I pasted it into a text document.
## Removed the top header row.
## Added the c., f., and m. prefixes to the corresponding column names (combined, female, male).
## Added Sex.diff.P as name of last column.
## In m.beta column, the long 'minus' symbol was replaced with a short one, so column read as numeric rather than character. 


## Load packages. (CHECK they are installed.)

  require (dplyr)
  require (tidyr)
  require (ggplot2)
  require (cowplot)
  require (ggrepel)
  
## Load data.
  setwd ("~/shungin2015/")
  shung = read.table("shungin2015results.txt", header = T)
  head(shung)
  str(shung)
  shung

  
## Re-format data.
  
  myshu = shung %>%
    select (SNP, Locus, f.beta, m.beta, Sex.diff.P, effect.group) %>%
    mutate (lg.P = -log10(Sex.diff.P), study = "shung")
            
            head(myshu)    
            names(myshu)
  
## Plot the data.
  myplot = 
    ggplot (myshu, aes(f.beta, m.beta, label = Locus, 
                       fill = as.factor(myshu$effect.group),
                       shape = as.factor(myshu$effect.group))) +
    geom_text_repel(data = myshu ,  segment.size = 0.2,
                    size = 2.5, colour = "grey20", segment.color = "grey30",
                    point.padding = unit(0.2, "lines")) +
    geom_point(alpha = .95, size = 2) +
    scale_fill_manual(name = NULL, 
                      labels = c("Female-biased", "Male-biased", "Both sexes"),
                      values = c("female" = "red","same.sex" = "black", "male" = "blue")) +
    scale_shape_manual(name = NULL, 
                       labels = c("Female-biased", "Male-biased", "Both sexes"),
                       values = c("female" = 21,"same.sex" = 23,"male" = 22)) +
    scale_y_continuous(name = expression("effect size in males, "~beta[M]),
                       breaks = seq(0,0.06, 0.01), limits = c(0,0.04)) +
    scale_x_continuous(name = expression("effect size in females, "~beta[F]),
                       breaks = seq(0,0.06, 0.01), limits = c(0,0.07)) +
    coord_fixed(ratio = 1, expand = FALSE) +
    theme_bw(base_size = 9) + 
    guides(fill = guide_legend(keyheight = .6)) +
      theme (legend.position = c(.13, .09), 
             panel.grid.minor = element_blank(),
             axis.line.y = element_line(size = .3, colour = "black"),
             axis.line.x = element_line(size = .3, colour = "black"), 
             legend.key = element_blank(),
             legend.background = element_rect(fill="white", size=.2, colour = NULL))
  
  
  save_plot("Figure_2.pdf", myplot, base_width = 6)
  
  
  ### End stuff ####
  ls()
  rm(list = ls())
  sessionInfo()
  
  Sys.time()
  sink()
  unlink("log_shunginAnalysis.txt")

