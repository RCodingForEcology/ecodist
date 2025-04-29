# Figure 2. Location of study site within the US, and locations of sampling points with respect to elevation.

    # packages not needed for other analyses or figures
    # NOTE: the proxy package, which is loaded by the spatial packages below, 
    # currently overwrites the base dim.dist() method, which causes ecodist to
    # fail. Loading ecodist LAST will restore default behavior

    library(sf)
    library(terra)
    library(maps)


    # data files not needed for other analyses or figures 

    dem <- rast(file.path(datadir, "dem.tif"))
    geo.pts <- readRDS(file.path(datadir, "geo.pts.RDS"))

    geo.gradno <- as.numeric(as.factor(geo$Gradient))

############################################


    png(file.path(figdir, "fig01_map.png"), width = 1100, height = 1000, pointsize = 30)
    
        par(mai = par()$mai * c(1, 1, .3, .3))

        # elevation map

        plot(dem, col = terrain.colors(20), plg = list(title = "Elevation (m)"))
        plot(geo.pts[1], col = "black", add = TRUE, pch = sym6.filled[geo.gradno], cex = .7)


        ###


        # add inset of CONUS

        par(fig = c(0.35, .75, .7, .95), mar=c(0,0,0,0), new=TRUE)

        plot(c(-125.14957, -66.53919), c(24.88254, 49.63062), type="n", xaxt="n", yaxt="n", xlab="", ylab="", bty="n")
        rect(-125.14957, 24.88254, -66.53919, 49.63062, col="white")

        map("state", add=TRUE)
        points(colMeans(st_coordinates(geo.pts))[1], colMeans(st_coordinates(geo.pts))[2], pch = 10, col = "red")

    dev.off()


############################################


