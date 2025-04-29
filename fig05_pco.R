# Figure 5. PCO ordination


    png(file.path(figdir, "fig05_pco.png"), width = 1000, height = 1100, pointsize = 30)

        par(mai = par()$mai * c(1, 1, .3, .3))

        geo.gradno <- as.numeric(as.factor(geo$Gradient))
        geo.elevno <- as.numeric(cut(geo$Elevation, breaks = quantile(geo$Elevation, seq(0, 1, by=.2)), include.lowest = TRUE))

        ###

        # rotate ordination to focus on elevation
        ord.rot <- rotate2d(veg.bc.pco, veg.bc.pco.evf)
        vf.rot  <- rotate2d(veg.bc.pco.vf, veg.bc.pco.evf)
        evf.rot <- rotate2d(veg.bc.pco.evf, veg.bc.pco.evf)
        
        # flip vertically to match first NMDS ordination
        ord.rot$X2 <- -1 * ord.rot$X2
        vf.rot$X2 <- -1 * vf.rot$X2

        plot(ord.rot, col = col6.dark.t[geo.gradno], pch = sym6.filled[geo.gradno], cex = geo.elevno/2, xlab = "PCO 1", ylab = "PCO 2", main = "", asp = 1)
        plot(vf.rot, r = 0.5, col = col3.dark["veg"], lwd = 3, cex = 0.9)
        plot(evf.rot, col = col3.dark["elev"], lty = 2, lwd = 5, cex = 0.9)
                
    dev.off()


############################################


    rm(geo.gradno, geo.elevno, ord.rot, vf.rot, evf.rot)





