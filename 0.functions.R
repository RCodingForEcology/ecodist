# custom functions


############################################


# set random seed for reproducibility

    ss <- function(s = 12345) {
        invisible(set.seed(s))
    }


############################################


# pretty printing for mantel output

    mprint <- function(x, labels = NA) {

        p1 <- function(y, label = NA) {

            if(is.na(label)) {
                out <- gsub("\\+", " ", sprintf("r = %+0.3f, p = %0.5f, lim = %+0.3f - %+0.3f", y[1], y[2], y[5], y[6]))
            } else {
                out <- paste(label, gsub("\\+", " ", sprintf("r = %+0.3f, p = %0.4f, lim = %+0.3f - %+0.3f", y[1], y[2], y[5], y[6])))
            }

            out

        }

        if(inherits(x, "list")) {
            if(length(labels) != length(x)) {
                labels <- rep(labels, length.out = length(x)) # recycles labels if not enough
            }
            x <- sapply(seq_along(x), function(i)p1(x[[i]], labels[[i]]))
        } else {
            x <- p1(x, labels)
        }


        opt <- getOption("scipen")
        options(scipen=999)
        
		x <- capture.output(print(x, digits = 4, quote = FALSE))
		x <- gsub("\\[[0-9]+\\] ", "", x)
		cat(paste(x, collapse = "\n"), "\n")
		
        options(scipen = opt)

        invisible()

    }


############################################


# pretty plot for mantel output

    mplot <- function(x, labels = NA, showP = FALSE, xlim, ylim, yinc = 0.5, ...) {

        par(mai = par()$mai * c(1, .3, .2, .2))

        n <- length(x)
        y <- rev(seq_len(n))
        r <- sapply(x, function(y)y[1])
        p <- sapply(x, function(y)y[2])
        llim <-  sapply(x, function(y)y[5])
        ulim <-  sapply(x, function(y)y[6])

        if(missing(xlim)) {
            xlim <- range(c(llim, ulim))
            xlim[2] <- xlim[2] + xlim[2] * 0.2
        }

        if(missing(ylim)) {
            ylim <- c(1, n + yinc*2)
        }

        if(showP) {
            out <- paste0(labels, sprintf("p = %0.5f", p))
        } else {
            out <- labels
        }

        plot(r, y, xlim=xlim, xlab = "Mantel r", ylim = ylim, ylab = "", yaxt = "n", bty = "n", ...) 
        
        segments(llim, y, ulim, y)

        text(llim, y+yinc, out, pos = 4, cex = .8)

        invisible()

    }

############################################


# pretty printing for MRM output

    mrmprint <- function(x) {
        #x$coef <- round(x$coef, 4)
        #x$r.squared <- round(x$r.squared, 4)


        opt <- getOption("scipen")
        options(scipen=999)

		x <- capture.output(print(x, digits = 4, quote = FALSE))
		x <- gsub("\\[[0-9]+\\] ", "", x)
		cat(paste(x, collapse = "\n"), "\n")
		
        options(scipen = opt)

        invisible()
    }


############################################

