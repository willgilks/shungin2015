#!/bin/bash
#$ -N log_shungin2015


## DESCRIPTION

## Starts an R script for plotting Shungin et al 2015 associated loci effect sizes.


    echo "`date +%y/%m/%d_%H:%M:%S`"
    uname -sa
    set -ex
    ls -lah

            R --vanilla < shungin.R

## http://www.sussex.ac.uk/lifesci/morrowlab/
## wpgilks@gmail.com


    echo "`date +%y/%m/%d_%H:%M:%S`"
    exit

##
##
##