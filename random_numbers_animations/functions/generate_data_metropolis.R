source("functions/create_elliptic_path.R")
source("functions/histogram_functions.R")
library(data.table)

uniform_update = function(min_number, max_number)
{
	return(runif(1, min_number, max_number))
}

generate_data = function(min_number = -10, max_number = 10, delta_hist = 0.5, steps = 100, interpolation = 10, ellipse_b = 1, epsilon = 0.1)
{
	points = list()
	histograms = list()

	x = -9.8
	histogram_df = create_histogram(x, min_number, max_number, delta_hist)
	histogram_0 = histogram_df

	for(i in 1:steps)
	{
		x_new = x + uniform_update(-epsilon, epsilon)
		
		C = exp(-20 * (x_new ** 2 - x ** 2))
		if(C < runif(1)) {
			x_new = x
		}

		movement_df = create_elliptic_path(x, x_new, interpolation, ellipse_b, i, min_number, max_number)

		if(x_new > max_number) {
			x_new = min_number + x_new - max_number
		}

		if(x_new < min_number) {
			x_new = max_number + x_new - min_number
		}

		histogram_df = update_histogram(histogram_df, x_new, min_number, delta_hist, i, interpolation)

		points[[i]] = movement_df
		histograms[[i]] = histogram_df

		x = x_new
	}

	points = rbindlist(points)
	histograms = rbind(histogram_0, rbindlist(histograms))

	return(list(points, histograms))	
}
