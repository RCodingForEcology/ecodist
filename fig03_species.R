# Figure 3. Frequency-abundance curve.


    png(file.path(figdir, "fig03_species.png"), width = 1000, height = 700, pointsize = 30)

        par(mai = par()$mai * c(1, 1, .3, .3))

        # overview plot of species
        plot(100 * colSums(veg > 0) / nrow(veg), apply(veg, 2, mean), xlab = "Frequency of occurrence (% of sites)", ylab = "Mean abundance (% cover)", col = col3.dark["veg"], cex = 0.5)


        text((100 * colSums(veg > 0) / nrow(veg))[veg.dom], apply(veg, 2, mean)[veg.dom], colnames(veg)[veg.dom], pos = 1, cex = .55, col = col3.dark["veg"])

    dev.off()


