# color sets

    # sets of dark colors for symbols and light colors for shading
    # two matching color-blind-safe sets of three colors
    # order for both is green (veg), orange (space), purple (elevation)
    # also swatched on freeform diagram
    col3.dark <- RColorBrewer::brewer.pal(3, "Dark2")
    col3.lite <- RColorBrewer::brewer.pal(3, "Set2")
    names(col3.dark) <- names(col3.lite) <- c("veg", "geo", "elev")

    # also need six colors for Gradient
    # these are NOT color-blind-safe; also use symbols
    col6.dark <- RColorBrewer::brewer.pal(6, "Dark2")
    col6.lite <- RColorBrewer::brewer.pal(6, "Set2")

	col6.dark.t <- grDevices::adjustcolor(col6.dark, alpha.f = 0.35)


# symbol sets

	# use 6 unicode symbols for the gradients, because the base pch only has 5
	# https://jrgraphix.net/r/Unicode/25A0-25FF
	
	# 25A0 square
	# 25CF circle
	# 25B2 up triangle
	# 25BC down triangle
	# 25BA right triangle
	# 25C4 left triangle

	sym6.filled <- c("\u25A0", "\u25CF", "\u25B2", "\u25BC", "\u25BA", "\u25C4")
	# fails!# sym6.open   <- c("\u25A1", "\u25CB", "\u25B5", "\u25BD", "\u25B7", "\u25C3")