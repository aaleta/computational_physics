library(gganimate)

plot_points = function(data, fill = "#84BCDA", size = 6, min_number = -10, max_number = 10)
{
	p <- ggplot(data, aes(x = x, y = y)) +
		theme_classic() +
		theme(axis.text.y = element_blank(),
			axis.line.y = element_blank(),
			axis.ticks.y = element_blank(),
			axis.ticks = element_line(color = "black", linewidth = 1),
			axis.ticks.length.x = unit(.3, "cm"),
			axis.text.x = element_text(size = 16)
		) +
		geom_point(fill = fill, color = "black", pch = 21, size = size) +
		transition_states(step, transition_length = 1, state_length = 1) +
		ease_aes('linear') +
		scale_y_continuous(expand = c(0,0), limits = c(0, 3)) +
		scale_x_continuous(limits = c(min_number, max_number),
					breaks = seq(min_number, max_number, by = 1)
		) +
		xlab("") +
		ylab("")

	return(p)
}
