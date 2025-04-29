# Figure 4: Triangle inequality.


    # example data

    dat.pass <- structure(list(s1 = c(0L, 0L, 4L), s2 = c(5L, 4L, 0L), s3 = c(0L,
    3L, 2L), s4 = c(3L, 2L, 3L)), row.names = c("A", "B",
    "C"), class = "data.frame")

    dat.pass.bc <- bcdist(dat.pass)
    dat.pass.pco <- pco(dat.pass.bc) # put into a metric space for plotting

    # fits in a metric space:
    # > dat.pass.bc
    #           A         B
    # B 0.2941176
    # C 0.6470588 0.5555556
    # > dist(dat.pass.pco$vectors)
    #           A         B
    # B 0.2941176
    # C 0.6470588 0.5555556

    ###

    dat.fail <- structure(list(s1 = c(0L, 0L, 4L), s2 = c(5L, 4L, 2L), s3 = c(0L,
    3L, 3L), s4 = c(3L, 2L, 0L)), class = "data.frame", row.names = c("A",
    "B", "C"))

    dat.fail.bc <- bcdist(dat.fail)
    dat.fail.pco <- pco(dat.fail.bc) # put into a metric space for plotting

    # does not fit in a metric space:
    # > dist(dat.fail.pco$vectors)
    #           A         B
    # B 0.3113100
    # C 0.7647986 0.4534886
    # > dat.fail.bc
    #           A         B
    # B 0.2941176
    # C 0.7647059 0.4444444


############################################


    png(file.path(figdir, "fig04_tri.png"), width = 1200, height = 600, pointsize = 30)


        par(mfrow=c(1, 2))
        par(mai = par()$mai * c(.1, .1, 1, .1))

        plot(dat.pass.pco$vectors[, 1:2], type="n", xaxt = "n", yaxt = "n", xlab = "", ylab = "", asp = 1, xlim = range(dat.pass.pco$vectors[, 1]) * c(1.05, 1.05), main = "a. Passes triangle inequality")
        segments(x0 = dat.pass.pco$vectors[c(1, 2, 3), 1], y0 = dat.pass.pco$vectors[c(1, 2, 3), 2], x1 = dat.pass.pco$vectors[c(2, 3, 1), 1], y1 = dat.pass.pco$vectors[c(2, 3, 1), 2])
        points(dat.pass.pco$vectors[, 1:2], pch = 16, cex = 2, col = "lightgreen")
        text(dat.pass.pco$vectors[, 1:2], rownames(dat.pass), pos = c(1, 3, 1))

        # used locator()
        pos.pass <- list(x = c(-0.17, 0.053, 0.0091951362707323), y = c(0.007, -0.107, 0.13))

        text(pos.pass$x[1], pos.pass$y[1], paste("AB:", round(dat.pass.bc[1], 2), "\n", "AC + BC:", round(dat.pass.bc[2] + dat.pass.bc[3], 2)), col = "darkgreen", pos = 4)
        text(pos.pass$x[2], pos.pass$y[2], paste("AC:", round(dat.pass.bc[2], 2), "\n", "AC + BC:", round(dat.pass.bc[1] + dat.pass.bc[3], 2)), col = "darkgreen", pos = 1)
        text(pos.pass$x[3], pos.pass$y[3], paste("BC:", round(dat.pass.bc[3], 2), "\n", "AC + BC:", round(dat.pass.bc[1] + dat.pass.bc[2], 2)), col = "darkgreen", pos = 4)

        text(par()$usr[2], par()$usr[3] + (par()$usr[4] - par()$usr[3]) * .85, gsub("  ", "   ", paste(capture.output(dat.pass), collapse = "\n")), pos = 2, cex = .7)


        ###


        plot(dat.fail.pco$vectors[, 1:2], type="n", xaxt = "n", yaxt = "n", xlab = "", ylab = "", asp = 1, xlim = range(dat.fail.pco$vectors[, 1]) * c(1.05, 1.4), main = "b. Fails triangle inequality")
        segments(x0 = dat.fail.pco$vectors[c(1, 2), 1], y0 = dat.fail.pco$vectors[c(1, 2), 2], x1 = dat.fail.pco$vectors[c(2, 3), 1], y1 = dat.fail.pco$vectors[c(2, 3), 2])
        segments(x0 = dat.fail.pco$vectors[1, 1], y0 = dat.fail.pco$vectors[1, 2] - .1, x1 = dat.fail.pco$vectors[3, 1] + .1, y1 = dat.fail.pco$vectors[3, 2] - .1, lty = 2, lend = 1)
        points(dat.fail.pco$vectors[, 1:2], pch = 16, cex = 2, col = "salmon")
        text(dat.fail.pco$vectors[, 1:2], rownames(dat.fail), pos = c(3, 3, 3))

        pos.fail <- list(x = c(-0.205, 0.0346, 0.196), y = c(0.09, -0.144, 0.09))

        text(pos.fail$x[1], pos.fail$y[1], paste("AB:", round(dat.fail.bc[1], 2), "\n", "AC + BC:", round(dat.fail.bc[2] + dat.fail.bc[3], 2)), col = "darkgreen", pos = 3)
        text(pos.fail$x[2], pos.fail$y[2], paste("AC:", round(dat.fail.bc[2], 2), "\n", "AC + BC:", round(dat.fail.bc[1] + dat.fail.bc[3], 2)), col = "darkred", pos = 1)
        text(pos.fail$x[3], pos.fail$y[3], paste("BC:", round(dat.fail.bc[3], 2), "\n", "AC + BC:", round(dat.fail.bc[1] + dat.fail.bc[2], 2)), col = "darkgreen", pos = 3)

        text(par()$usr[2], par()$usr[3] + (par()$usr[4] - par()$usr[3]) * .85, gsub("  ", "   ", paste(capture.output(dat.fail), collapse = "\n")), pos = 2, cex = .7)


    dev.off()
