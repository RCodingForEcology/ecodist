These code files create the analyses and figures for the forthcoming Springer UseR! volume R Coding for Ecology, edited by Duccio Rocchini.

Chapter II.7, The ecodist package for dissimilarity-based analysis of ecological data, by Sarah Goslee.

This code was written for the R package [ecodist](https://cran.r-project.org/web/packages/ecodist/index.html) written by Sarah Goslee and Dean Urban (version 2.1.3, 2023-10-30). 

Files should be run in order:

  - 0.functions.R - pretty plotting functions for ecodist output (may be folded into a later version of the package).
  - 1.colors.R - colors and symbols for consistent figures across the chapter.
  - 2.gunnison.R - if not available locally, downloads and saves plant composition data from [67 grassland sites](https://portal.edirepository.org/nis/mapbrowse?packageid=edi.418.1) of the Upper Gunnison Basin, CO, USA, 2014.
      Data citation: Lynn, J.S., M.R. Kazenel, S.N. Kivlin, and J.A. Rudgers. 2019. Plant composition data from 67 grassland sites of the Upper Gunnison Basin, CO, USA, 2014 ver 1. Environmental Data Initiative. https://doi.org/10.6073/pasta/f0050c1cfe11a5f78e7bd736c8d6f6ee (Accessed 2025-04-29).
  - 3.dem.R - if not available locally, downloads and saves USGS National Elevation Dataset [3DEP 1/3 arc-second tiles](https://www.usgs.gov/3d-elevation-program/about-3dep-products-services).
  - fig*.*.R - all calculations and plotting code for each figure in Chapter II.7.
  - table01.Rmd and table02.Rmd - tables formatted using _knitr::kable_.
