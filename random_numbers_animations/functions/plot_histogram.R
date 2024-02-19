library(gganimate)

plot_histograms = function(data, n_plots, fill1 = "#84BCDA", fill2 = "#99C24D", size = 6, min_number = -10, max_number = 10, delta_hist = 0.5, type = NULL)
{
	n_intervals = (max_number - min_number) / delta_hist
	n_shared = n_plots / n_intervals

	if(type == "metropolis") {
		n_shared = n_plots / 10
	}

	p <- ggplot(data, aes(x = x, y = y)) + #, fill = color)) +
		theme_classic() +
		theme(axis.text.y = element_blank(),
			axis.line.y = element_blank(),
			axis.ticks.y = element_blank(),
			axis.ticks = element_line(color = "black", linewidth = 1),
			axis.ticks.length.x = unit(.3, "cm"),
			axis.text.x = element_text(size = 16),
			legend.position = "none"
		) +
		geom_col(fill = fill1, color = "black", just = 0, width = delta_hist) +
		#scale_fill_manual(values = c(fill2, fill1)) +
		transition_states(step, transition_length = 1, state_length = 1) +
		ease_aes('linear') +
		scale_y_continuous(expand = c(0,0), limits = c(0, 2 * n_shared)) +
		scale_x_continuous(limits = c(min_number - 1, max_number + 1),
					breaks = seq(min_number, max_number, by = 1)
		) +
		xlab("") +
		ylab("")

	return(p)
}
