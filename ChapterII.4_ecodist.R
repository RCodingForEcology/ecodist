### Sarah Goslee
### Chapter II.4. The Ecodist Package for Dissimilarity-Based Analysis of Ecological Data
### Coding For Ecology, edited by Duccio Rocchini


####### BEGIN CODE BLOCK 1 #######

    # change to match preferred directory configuration
    datadir <- "data"
    codedir <- "code"
    figdir  <- "figures"
    outdir  <- "results"
    

    # make figures and tables?
    makefigs <- FALSE


    library(ecodist)
    # imports graph
    # uses sf, terra, maps for spatial operations, but only loaded if called for

    # custom functions
    source(file.path(codedir, "0.functions.R"))


    # custom color palettes
    source(file.path(codedir, "1.colors.R"))


    # data import
    #  - veg: site by species table
    #  - geo: spatial and environmental data
    source(file.path(codedir, "2.gunnison.R"))


    # focus on dominant and/or abundant species
    veg.dom <- colSums(veg) > 250 | 100 * colSums(veg > 0) / nrow(veg) > 25


    ### OPTIONAL ###
    # create elevation map if desired
    # both code files can stand alone
    # loads additional libraries
    # only used to produce Figure 1
    # creates dem.tif in the data directory
    # source(file.path(codedir, "3.dem.R"))
    # source(file.path(codedir, "runlast.fig02.R"))


    # load completed analyses if available
    # otherwise recalculate everything
    if(file.exists(file.path(outdir, "analyses.RDA"))) {
        load(file.path(outdir, "analyses.RDA"))
        runall <- FALSE
    } else {
        runall <- TRUE
    }


####### END CODE BLOCK 1 #######


####### BEGIN CODE BLOCK 2 #######


    # three different ways to conceptualize vegetation community composition

    # raw % cover; emphasizes abundant species
    veg.bc <- bcdist(veg)

    # scaled to species maximum
    # gives rare and abundant species the same weight
    veg.rel <- relrange(veg)
    veg.rel.bc <- bcdist(veg.rel)

    # compares presences only 
    veg.jd <- distance(veg, method = "jaccard")

    ### compare methods

    ss(); methods.mantel <- list(
        mantel(veg.bc ~ veg.rel.bc, nperm = 10000, nboot = 1000),
        mantel(veg.bc ~ veg.jd, nperm = 10000, nboot = 1000),
        mantel(veg.rel.bc ~ veg.jd, nperm = 10000, nboot = 1000))

    # not continuing with these
    rm(veg.rel.bc, veg.jd)

    # same meaningful units in X and Y, so not scaled
    geo.ed <- dist(subset(geo, select = c(X, Y)))

    # single variable, so not scaled
    elev.ed <- dist(geo$Elevation)


####### END CODE BLOCK 2 #######


####### BEGIN CODE BLOCK 3 #######


    if(runall) {

        ss(); veg.mantel <- list(
            mantel(veg.bc ~ geo.ed, nperm = 10000, nboot = 1000),
            mantel(veg.bc ~ geo.ed + elev.ed, nperm = 10000, nboot = 1000),
            mantel(veg.bc ~ elev.ed, nperm = 10000, nboot = 1000),
            mantel(veg.bc ~ elev.ed + geo.ed, nperm = 10000, nboot = 1000)
        )

        veg.mantel.labels <- c(
            "Veg ~ Space        ",
            "Veg ~ Space | Elev ",
            "Veg ~ Elev         ",
            "Veg ~ Elev | Space ")

        ###

        ss(); env.mantel <- mantel(elev.ed ~ geo.ed, nperm = 10000, nboot = 1000)

		### also rank
		
        ss(); veg.mantel.rank <- list(
            mantel(veg.bc ~ geo.ed, nperm = 10000, nboot = 1000, mrank = TRUE),
            mantel(veg.bc ~ geo.ed + elev.ed, nperm = 10000, nboot = 1000, mrank = TRUE),
            mantel(veg.bc ~ elev.ed, nperm = 10000, nboot = 1000, mrank = TRUE),
            mantel(veg.bc ~ elev.ed + geo.ed, nperm = 10000, nboot = 1000, mrank = TRUE)
        )

        veg.mantel.rank.labels <- c(
            "ranked Veg ~ Space        ",
            "ranked Veg ~ Space | Elev ",
            "ranked Veg ~ Elev         ",
            "ranked Veg ~ Elev | Space ")

        ###

        ss(); env.mantel.rank <- mantel(elev.ed ~ geo.ed, nperm = 10000, nboot = 1000, mrank = TRUE)

    }

#### display formatted mantel results

    # a. Linear relationships
    mprint(veg.mantel, veg.mantel.labels)
    mprint(env.mantel, "Space ~ Elev")

    # b. Monotonic (rank-order) relationships
    mprint(veg.mantel.rank, veg.mantel.rank.labels)
    mprint(env.mantel.rank, "ranked Space ~ Elev")


####### END CODE BLOCK 3 #######


####### BEGIN CODE BLOCK 4 #######


    if(runall) {

        ss(); veg.bc.mrm <- MRM(veg.bc ~ geo.ed + elev.ed, nperm = 10000, mrank = FALSE)

        ss(); veg.bc.mrm.rank <- MRM(veg.bc ~ geo.ed + elev.ed, nperm = 10000, mrank = TRUE)

    }


    mrmprint(veg.bc.mrm)


####### END CODE BLOCK 4 #######


####### BEGIN CODE BLOCK 5 #######


    if(runall) {

		# convenience function to perform a test of group dissimilarity
        ss(); veg.bc.mg <- mgroup(veg.bc, geo$Gradient, nperm=10000)

        # duplicates mgroup: mantel(veg.bc ~ gradient.site.d)
        gradient.site.d <- dist(as.numeric(as.factor(sub("\\..*$", "", rownames(veg)))))
        gradient.site.d[gradient.site.d > 0] <- 1

    
        ss(); gradient.mantel <- list(
            mantel(veg.bc ~ gradient.site.d, nperm = 10000, nboot = 1000),
            mantel(veg.bc ~ gradient.site.d + geo.ed, nperm = 10000, nboot = 1000),
            mantel(veg.bc ~ gradient.site.d + elev.ed, nperm = 10000, nboot = 1000),
            mantel(veg.bc ~ gradient.site.d + geo.ed + elev.ed, nperm = 10000, nboot = 1000)
        )

        gradient.mantel.labels <- c(
            "Veg ~ Gradient                 ",
            "Veg ~ Gradient | Space         ",
            "Veg ~ Gradient | Elev          ",
            "Veg ~ Gradient | Space + Elev  ")

	###
	
	
        ss(); gradient.mantel.rank <- list(
            mantel(veg.bc ~ gradient.site.d, nperm = 10000, nboot = 1000, mrank = TRUE),
            mantel(veg.bc ~ gradient.site.d + geo.ed, nperm = 10000, nboot = 1000, mrank = TRUE),
            mantel(veg.bc ~ gradient.site.d + elev.ed, nperm = 10000, nboot = 1000, mrank = TRUE),
            mantel(veg.bc ~ gradient.site.d + elev.ed + geo.ed, nperm = 10000, nboot = 1000, mrank = TRUE)
        )

        gradient.mantel.rank.labels <- c(
            "ranked Veg ~ Gradient                 ",
            "ranked Veg ~ Gradient | Space         ",
            "ranked Veg ~ Gradient | Elev          ",
            "ranked Veg ~ Gradient | Space + Elev  ")
    }

 
    # a. Mantel tests of group difference
    mprint(gradient.mantel, gradient.mantel.labels)
   
    # b. mgroup() test of group difference
    cat(paste(capture.output(print(veg.bc.mg, digits = 4)), collapse = "\n"), "\n")


####### END CODE BLOCK 5 #######


####### BEGIN CODE BLOCK 6 #######


    if(runall) {

        ss(); veg.bc.nmds <- nmds(veg.bc, mindim = 1, maxdim = 4, nits = 100)
        veg.bc.nmdsmin <- min(veg.bc.nmds)

        ss(); veg.bc.pco <- pco(veg.bc)

        ###

        # reconstructs the spatial pattern of the map, possibly rotated

        ss(); geo.nmds <- nmds(geo.ed, mindim = 2, maxdim = 2, nits = 100)
        geo.nmdsmin <- min(geo.nmds)

        ss(); geo.pco  <- pco(geo.ed)

        ###

        ss(); veg.bc.nmds.vf <- vf(veg.bc.nmdsmin, veg[, veg.dom], nperm = 10000)
        ss(); veg.bc.nmds.evf <- vf(veg.bc.nmdsmin, geo[, "Elevation", drop=FALSE], nperm = 10000)

        ###

        ss(); veg.bc.pco.vf <- vf(veg.bc.pco$vectors[, 1:2], veg[, veg.dom], nperm = 10000)
        ss(); veg.bc.pco.evf <- vf(veg.bc.pco$vectors[, 1:2], geo[, "Elevation", drop=FALSE], nperm = 10000)

    }

  
    # NMDS fit metrics by dimension
   
    round(sapply(split(veg.bc.nmds$r2, rep(1:4, each = 100)), mean), 4)
    round(sapply(split(veg.bc.nmds$stress, rep(1:4, each = 100)), mean), 4)

    # PCO axis variance indicated by eigenvalues
    head(veg.bc.pco$values)


####### END CODE BLOCK 6 #######


####### BEGIN CODE BLOCK 7 #######


    if(runall) {

        veg.bc.path <- pathdist(veg.bc)

        ###

        ss(); veg.bc.nmds.path <- nmds(veg.bc.path, mindim = 2, maxdim = 2, nits = 100)
        veg.bc.nmdsmin.path <- min(veg.bc.nmds.path)

        ss(); veg.bc.nmds.vf.path <- vf(veg.bc.nmdsmin.path, veg[, veg.dom], nperm = 10000)
        ss(); veg.bc.nmds.evf.path <- vf(veg.bc.nmdsmin.path, geo[, "Elevation", drop=FALSE], nperm = 10000)

        ###

        ss(); veg.bc.pco.path <- pco(veg.bc.path)
        
        ss(); veg.bc.pco.vf.path <- vf(veg.bc.pco.path$vectors[, 1:2], veg[, veg.dom], nperm = 10000)
        ss(); veg.bc.pco.evf.path <- vf(veg.bc.pco.path$vectors[, 1:2], geo[, "Elevation", drop=FALSE], nperm = 10000)

    }


###


    if(runall) {

        ss(); veg.mantel.path <- list(
            mantel(veg.bc.path ~ geo.ed, nperm = 10000, nboot = 1000),
            mantel(veg.bc.path ~ geo.ed + elev.ed, nperm = 10000, nboot = 1000),
            mantel(veg.bc.path ~ elev.ed, nperm = 10000, nboot = 1000),
            mantel(veg.bc.path ~ elev.ed + geo.ed, nperm = 10000, nboot = 1000)
        )

        veg.mantel.path.labels <- c(
            "extended Veg ~ Space        ",
            "extended Veg ~ Space | Elev ",
            "extended Veg ~ Elev         ",
            "extended Veg ~ Elev | Space ")

    }


####### END CODE BLOCK 7 #######


####### BEGIN CODE BLOCK 8 #######


    if(runall) {

        ss(); veg.bc.pm <- pmgram(veg.bc, geo.ed, nperm = 10000)
        ss(); veg.bc.pme <- pmgram(veg.bc, geo.ed, elev.ed, nperm = 10000)

        ss(); veg.bc.epm <- pmgram(veg.bc, elev.ed, nperm = 10000)
        ss(); veg.bc.epmg <- pmgram(veg.bc, elev.ed, geo.ed, nperm = 10000)

        ss(); elev.pm <- pmgram(elev.ed, geo.ed, nperm = 10000)

        ###

        ss(); veg.bc.mm <- mgram(veg.bc, geo.ed, nperm = 10000)

    }


####### END CODE BLOCK 8 #######


####### BEGIN CODE BLOCK 9 #######


	if(runall) {
	
	    # save results
	    f <- ls()
	    f <- f[!(f %in% c("makefigs", "codedir", "col3.dark", "col3.lite", "col6.dark", "col6.dark.t", "col6.lite", "sym6.filled", "datadir", "distance", "elev.ed", "figdir", "geo", "geo.ed", "gradient.site.d", "mprint", "mrmprint", "pathdist", "outdir", "relrange", "rotate2d", "runall", "species", "ss", "veg", "veg.bc", "veg.dom", "veg.rel", "f"))]
	    save(list = f, file = "results/analyses.RDA")
	    rm(f)
	    
	}



	if(makefigs) {
		invisible(sapply(list.files(path = codedir, pattern = "^fig", full.names = TRUE),  source))
        rmarkdown::render(file.path(codedir, "table01.Rmd"), output_file = file.path("..", figdir, "table01_species.pdf"))

        # table 2 is incorporated into the chapter as results sections, but included here to demonstrate how 
        # you might make a publication table
        rmarkdown::render(file.path(codedir, "table02.Rmd"), output_file = file.path("..", figdir, "table02_mantel.pdf"))

	}


####### END CODE BLOCK 9 #######






