# Figure 10. Mantel correlogram and piecewise correlogram.

    png(file.path(figdir, "fig10_mgram.png"), width = 1000, height = 1200, pointsize = 30)

		par(mfrow=c(2, 1))
		par(mai = par()$mai * c(.9, 1, .8, .6))
	    plot(veg.bc.mm, main = "a. Mantel correlogram, vegetation ~ space", xlab = "Geographic distance")
	    plot(veg.bc.pm, main = "b. Piecewise correlogram, vegetation ~ space", xlab = "Geographic distance")

    dev.off()

# Figure 11. Partial and elevation correlograms.

    png(file.path(figdir, "fig11_pmgram.png"), width = 1000, height = 1200, pointsize = 30)

		par(mfrow=c(2, 1))
		par(mai = par()$mai * c(.9, 1, .8, .6))
	    plot(veg.bc.pme, main = "a. Vegetation ~ space | elevation", xlab = "Geographic distance")
	    plot(veg.bc.epm, main = "a. Vegetation ~ elevation", xlab = "Elevation difference")

    dev.off()
