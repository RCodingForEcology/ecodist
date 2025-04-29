# Figure 7. Comparison of BC and extended BC distance.

    png(file.path(figdir, "fig07_extended.png"), width = 1000, height = 1000, pointsize = 30)

        par(mai = par()$mai * c(1, 1, .3, .3))

        plot(veg.bc, veg.bc.path, xlab = "Original BC dissimilarity", ylab = "Extended BC dissimilarity")
        
        m <- mantel(veg.bc ~ veg.bc.path, nperm = 10000, nboot = 0)
        r <- sprintf("%0.3f", m[1])
        p <- sprintf("%0.4f", m[2])
        txt <- paste0("Mantel r: ", r, "\np <= ", p)

        text(0.4, 1.5, txt, pos = 4)
        
    dev.off()


############################################


    rm(m, r, p, txt)

